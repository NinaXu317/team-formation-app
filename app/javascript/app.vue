<template>
  <div class = "wrapper overflow projects-container">
    <div id="app" class="row projects-row" >
      <div class="col projects-box"> 
        <div class = 'container student-projects-container'>
          <h5 class='project-title'>
           Active Projects
          </h5>
          <hr>
          <draggable v-model="groups" :options="{group: 'projects'}" @change="cardMoved">
          <a v-for="(group, index) in groups" class = 'row single-project-container-stu' >
            <div class='container project-container'>
              <h5 class='project-name-text'>
              {{ group.project_name }}
              </h5>
              <div class='form-control editbox-stu'>
                <p class="project-description-text">{{ group.description }}</p>
              </div>
              <div class='vote-buttons'>
                <button class='btn btn-info voteBtn' :id="'t'+group.id">Third ({{group.vthird}})</button>
                <button class='btn btn-warning voteBtn' :id="'s'+group.id">Second ({{group.vsecond}})</button> 
                <button class='btn btn-danger voteBtn' :id="'f'+group.id">First ({{group.vfirst}})</button>               
                   
                 
              </div>
            </div>
          </a>
          </draggable>
          <p>&nbsp</p>
          <div class = 'single-project-container-stu'>
            <div class= 'container project-container project-container-input'>
              <textarea v-model="messages['groups']" class="form-control editbox-stu editbox-name" placeholder="Project Name"></textarea>
              <textarea v-model="description['groups']" class="form-control editbox-stu editbox-description" placeholder="Description"></textarea>
              <div class="row">
                <div class="container">
                <button v-on:click = "submitMessages('groups', course.id)" class="btn btn-primary addProjectBtn">Add</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <div class="column" id="middle-col">
        <div class='container'>
        <div class="row drag-text">drag</div>
        <div class="row" >
        <i class="fas fa-exchange-alt fa-2x" id="change-icon"></i>
        </div>
        </div>
      </div>

      <div class="col projects-box"> 
        <div class = 'container student-projects-container'>
          <h5 class='project-title'>
            Projects on Hold
          </h5>
          <hr>
          <draggable v-model="holdprojects" :options="{group: 'projects'}" @change="cardMoved">
          <a v-for="(holdproject, index) in holdprojects" class = 'row single-project-container-stu'>
            <div class='container project-container'>
              <h5 class='project-name-text'>
                {{ holdproject.project_name }}
              </h5>
              <div class='form-control editbox-stu'>
                <p class="project-description-text">{{ holdproject.description }}</p>
              </div>
              <div class='vote-buttons'>
                             
                   
                <button class='btn btn-info voteBtn' :id="'t'+holdproject.id">Third ({{holdproject.vthird}})</button>  
                <button class='btn btn-warning voteBtn' :id="'s'+holdproject.id">Second ({{holdproject.vsecond}})</button>   
                <button class='btn btn-danger voteBtn' :id="'f'+holdproject.id">First ({{holdproject.vfirst}})</button> 
              </div>

            </div>
          
          </a>
          </draggable>
          <p>&nbsp</p>
          <div class = 'single-project-container-stu'>
            <div class= 'container project-container project-container-input'>
              <textarea v-model="messages['holdprojects']" class="form-control editbox-stu editbox-name" placeholder="Project Name"></textarea>
              <textarea v-model="description['holdprojects']" class="form-control editbox-stu editbox-description" placeholder="Description"></textarea>
              <div class="row">
                <div class="container">
                  <button v-on:click = "submitMessages('holdprojects', course.id)" class="btn btn-primary addButton addProjectBtn">Add</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</template>

<script>
import draggable from 'vuedraggable'
export default {
  components: {draggable},
  data: function(){
    return {
      messages: {},
      description: {},
    }
  },

  computed:{
    groups: {
      get(){
        return this.$store.state.groups.filter(group=>group.active==true)
      },
      set(value){
        console.log("in vue compute")
        console.log(value)   
      }
    },
    holdprojects: {
      get(){
        return this.$store.state.groups.filter(group=>group.active==false)
      },
      set(value){
        console.log("in vue compute")
        console.log(value)
      }
    },
    course: {
      get(){
        return this.$store.state.course
      }
    }
  },

  methods: {

    cardMoved: function(event){
      console.log(event)
      if(event.added != undefined || event.moved != undefined){ 
        const evt = event.added || event.moved
        const element = evt.element  
        var moved_project_name = element.project_name
        var data = new FormData      
        if(event.added != undefined && element.active==false){
          data.append("group[active]", true) 
        }else if(event.added != undefined){
          data.append("group[active]", false)
        }  
          data.append("group[position]", evt.newIndex+1) 
          console.log(`in app vue index: ${evt.newIndex+1}`)     
          Rails.ajax({
            beforeSend: () => true,
            url:`/groups/${element.id}/move`,
            type: "PATCH",
            data: data,
            dataType: "json",
            success: (data) => {
              console.log("broad cast success")
 
            }
          })
      }
    },
    submitMessages: function(column_str, course_id){
      var data = new FormData
      if(column_str=='groups'){
        data.append("group[active]", true)
      }else{
        data.append("group[active]", false)
      }
      data.append("group[course_id]", course_id)
      data.append("group[project_name]", this.messages[column_str])
      data.append("group[description]", this.description[column_str])
      
      Rails.ajax({
          beforeSend: () => true,
          url: "/groups",
          type: "POST",
          data: data,
          dataType: "json",
          success: (data) => {     
            this.messages[column_str] = undefined
            this.description[column_str]= undefined
          }
      })  
    }
  }
}
</script>

<style scoped>

  #change-icon{
    color: rgb(141, 180, 252);
    margin-left: 32px;
  }

</style>