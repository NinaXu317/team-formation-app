<template>
  <div class = "wrapper overflow projects-container">
    <div id="app" class="row projects-row" >
      <div class="col projects-box"> 
        <div class = 'container student-projects-container'>
          <h5 class='project-title'>
           Projects
          </h5>
          <hr>
          <draggable v-model="groups" :options="{group: 'projects'}" @change="cardMoved">
          <a v-for="(group, index) in groups" class = 'row single-project-container-stu' >
            <div class='container project-container'>
              <p class='project-name-text'>
              {{ group.project_name }}
              </p>
              <div class='form-control editbox-stu'>
                <p class="project-description-text">{{ group.description }}</p>
              </div>
              <div class='vote-buttons'>
                <button class='btn btn-info voteBtn' :id="'t'+group.id">Thrid ({{group.vthird}})</button>
                <button class='btn btn-warning voteBtn' :id="'s'+group.id">Second ({{group.vsecond}})</button> 
                <button class='btn btn-danger voteBtn' :id="'f'+group.id">First ({{group.vfirst}})</button>               
                   
                 
              </div>
            </div>
          </a>
          </draggable>
          <div class = 'single-project-container-stu'>
            <div class= 'container project-container project-container-input'>
              <textarea v-model="messages['groups']" class="form-control editbox-stu editbox-name" placeholder="Project Name"></textarea>
              <textarea v-model="description['groups']" class="form-control editbox-stu editbox-description" placeholder="Description"></textarea>
              <div class="row">
                <div class="container">
                <button v-on:click = "submitMessages('groups', course.id)" class="btn btn-outline-primary addProjectBtn">Add</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <div id="middle-col">
        
        <div>drag</div>
        <i class="fas fa-exchange-alt fa-2x" id="change-icon"></i>
        
      </div>

      <div class="col projects-box"> 
        <div class = 'container student-projects-container'>
          <h5 class='project-title'>
            Hold Projects
          </h5>
          <hr>
          <draggable v-model="holdprojects" :options="{group: 'projects'}" @change="cardMoved">
          <a v-for="(holdproject, index) in holdprojects" class = 'row single-project-container-stu'>
            <div class='container project-container'>
              <p class='project-name-text'>
                {{ holdproject.project_name }}
              </p>
              <div class='form-control editbox-stu'>
                <p class="project-description-text">{{ holdproject.description }}</p>
              </div>
              <div class='vote-buttons'>
                <button class='btn btn-danger voteBtn' :id="'f'+holdproject.id">First ({{holdproject.vfirst}})</button>             
                <button class='btn btn-warning voteBtn' :id="'s'+holdproject.id">Second ({{holdproject.vsecond}})</button>    
                <button class='btn btn-info voteBtn' :id="'t'+holdproject.id">Thrid ({{holdproject.vthird}})</button>     
              </div>

            </div>
          
          </a>
          </draggable>
          <div class = 'single-project-container-stu'>
            <div class= 'container project-container project-container-input'>
              <textarea v-model="messages['holdprojects']" class="form-control editbox-stu editbox-name" placeholder="Project Name"></textarea>
              <textarea v-model="description['holdprojects']" class="form-control editbox-stu editbox-description" placeholder="Description"></textarea>
              <div class="row">
                <div class="container">
                  <button v-on:click = "submitMessages('holdprojects', course.id)" class="btn btn-outline-primary addButton addProjectBtn">Add</button>
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
  props: ["group_list", "curr_course", "taking_list"],
  data: function(){
    return {
      messages: {},
      description: {},
      groups: this.group_list.filter(group=>group.active==true),
      holdprojects: this.group_list.filter(group=>group.active==false),
      course: this.curr_course,
      takings: this.taking_list,
      allprojects: this.group_list,
    }
  },
  methods: {
    cardMoved: function(event){
      if(event.added != undefined){
        console.log(event)
        var moved_project_name = event.added.element.project_name
        console.log(moved_project_name)
        console.log(event.added.element.id)
        
        if(this.groups.find((project)=>project.project_name===moved_project_name)){
          console.log("move from holds to groups")
          var data = new FormData
          data.append("group[active]", true)  
          data.append("group[position]", event.added.newIndex+1)      
          Rails.ajax({
            url:`/groups/${event.added.element.id}`,
            type: "PATCH",
            data: data,
            dataType: "json"
          })
        }else{
          console.log("move from groups to holds")
          var data = new FormData
          data.append("group[position]", event.added.newIndex+1)
          data.append("group[active]", false)
          Rails.ajax({
            url:`/groups/${event.added.element.id}`,
            type: "PATCH",
            data: data,
            dataType: "json"
          })   
        }
      }else if (event.moved != undefined){
        var moved_project_name = event.moved.element.project_name
        var moved_project_id = event.moved.element.id
        var data  = new FormData
        data.append("group[position]", event.moved.newIndex+1)
        Rails.ajax({
            url:`/groups/${moved_project_id}/move`,
            type: "PATCH",
            data: data,
            dataType: "json",
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
          url: "/groups",
          type: "POST",
          data: data,
          dataType: "json",
          success: (data) => {
            if(column_str=='groups'){
              this.groups.push(data)
            }else{
              this.holdprojects.push(data)
            }        
            this.messages[column_str] = undefined
            this.description[column_str]= undefined
          }
      })  
    }
  }
}
</script>

<style scoped>
  .projects-row{
    margin-left: 0px;
    margin-right: 0px;
  }
  .projects-box{
    background: rgb(193, 213, 250);
    border-radius: 3px;
    min-height: 300px;
    white-space: normal;
    padding-bottom: 15px;
  }


  #change-icon{
    color: rgb(141, 180, 252);
    margin-left: 32px;
  }

</style>