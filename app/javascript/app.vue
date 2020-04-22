<template>
  <div class = "wrapper overflow projects-container">
    <div id="app" class="row projects-row" >
      <div class="col projects-box"> 
        <div class = 'container' style="min-height: 300px; padding-top: 10px;">
          <h5 style='text-align: center; margin: 0px'>
           Projects
          </h5>
          <hr>
          <draggable v-model="groups" :options="{group: 'projects'}" @change="cardMoved">
          <a v-for="(group, index) in groups" class = 'row single-project-container' >
            <p class='project-name'>
            {{ group.project_name }}
            </p>
          </a>
        </draggable>
          <div class = 'row single-project-container'>
            <textarea v-model="messages['groups']" class="form-control editbox"></textarea>
            <button v-on:click = "submitMessages('groups', course.id)" class="btn btn-outline-primary addProjectBtn">Add</button>
          </div>
        </div>
      </div>
      
      <div id="middle-col">
        
        <i class="fas fa-exchange-alt fa-2x" id="change-icon"></i>
        
      </div>

      <div class="col projects-box"> 
        <div class = 'container' style="min-height: 300px; padding-top: 10px;">
          <h5 style='text-align: center; margin: 0px'> 
            Hold Projects
          </h5>
          <hr>
          <draggable v-model="holdprojects" :options="{group: 'projects'}" @change="cardMoved">
          <a v-for="(holdproject, index) in holdprojects" class = 'row single-project-container'>
            <p class='project-name'>
              {{ holdproject.project_name }}
            </p>
          </a>
          </draggable>
          <div class = 'row single-project-container'>
            <textarea v-model="messages['holdprojects']" class="form-control editbox"  ></textarea>
            <button v-on:click = "submitMessages('holdprojects', course.id)" class="btn btn-outline-primary addButton addProjectBtn">Add</button>
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
  props: ["group_list", "hold_list", "curr_course"],
  data: function(){
    return {
      messages: {},
      groups: this.group_list,
      holdprojects: this.hold_list,
      course: this.curr_course
    }
  },
  methods: {
    cardMoved: function(event){
      if(event.added != undefined){
        console.log(event)
        console.log(this.course.id)
        var moved_project_name = event.added.element.project_name
        console.log(moved_project_name)
        var data = new FormData
        if(this.groups.find((project)=>project.project_name===moved_project_name)){
          console.log("move from holds to groups")
          data.append("group[course_id]", this.course.id)
          data.append("group[project_name]", moved_project_name)
          data.append("group[position]", event.added.newIndex)
          Rails.ajax({
            url:"/groups",
            type: "POST",
            data: data,
            dataType: "json",
            success: (data) => {
              Rails.ajax({
                url: `/holdprojects/${event.added.element.id}`,
                type: "DELETE",
                dataType: "json",
              })
            }
          })
        }else{
          console.log("move from groups to holds")
          data.append("holdproject[course_id]", this.course.id)
          data.append("holdproject[project_name]", moved_project_name)
          data.append("holdproject[position]", event.added.newIndex)
          Rails.ajax({
            url:"/holdprojects",
            type: "POST",
            data: data,
            dataType: "json",
            success: (data) => {
              Rails.ajax({
                url:`/groups/${event.added.element.id}`,
                type: "DELETE",
                dataType: "json",
              })
            }
          })         
        }
      } else if (event.moved != undefined){
        var moved_project_name = event.moved.element.project_name
        var moved_project_id = event.moved.element.id
        if(this.groups.find((project)=>project.project_name===moved_project_name)){
          var data  = new FormData
          data.append("group[position]", event.moved.newIndex+1)
          Rails.ajax({
            url:`/groups/${moved_project_id}/move`,
            type: "PATCH",
            data: data,
            dataType: "json",
          })
        }else if(this.holdprojects.find((project)=>project.project_name===moved_project_name)){
          var data  = new FormData
          data.append("holdproject[position]", event.moved.newIndex + 1)
          console.log(event.moved.newIndex)
          Rails.ajax({
            url:`/holdprojects/${moved_project_id}/move`,
            type: "PATCH",
            data: data,
            dataType: "json",
          })
        }
      }
 
    },
    submitMessages: function(column_str, course_id){
      var data = new FormData
      if(column_str=='groups'){
        data.append("group[course_id]", course_id)
        data.append("group[project_name]", this.messages[column_str])

        Rails.ajax({
          url: "/groups",
          type: "POST",
          data: data,
          dataType: "json",
          success: (data) => {
            this.groups.push(data)
            this.messages[column_str] = undefined
          }
        })

      }else{
        data.append("holdproject[course_id]", course_id)
        data.append("holdproject[project_name]", this.messages[column_str]) 
        
        Rails.ajax({
          url: "/holdprojects",
          type: "POST",
          data: data,
          dataType: "json",
          success: (data) => {
            this.holdprojects.push(data)
            this.messages[column_str] = undefined
          }
        })
      } 
      
    }
  }
}
</script>

<style scoped>


  .projects-row{
    margin: 20px;
  }
  .projects-box{
    background: rgb(193, 213, 250);
    border-radius: 3px;
    min-height: 300px;
    white-space: normal;
    padding-bottom: 15px;
  }
  .single-project-container{
    background: white; 
    border-radius: 3px;
    margin-bottom:5px;
    min-height: 30px;
    align-items: center;
    text-decoration: none;
    cursor: pointer;
  }
  .project-name{
    margin: 0px;
    padding-left: 15px;
    color: rgb(100, 99, 99);
  }

  .editbox{
    padding: 0px;
    margin: 12px;
    margin-bottom: 0px;
  }
  .addProjectBtn{
    margin-left: 12px;
    margin-right: 12px;
    margin-bottom: 12px;
    width: 100%;
    border: 1.5px solid rgb(193, 213, 250);
    font-weight: bold;
    color: rgb(141, 180, 252);
  }
  .addProjectBtn:hover{
    background-color:rgb(193, 213, 250) ;
    color: white;
  }

  #middle-col{
    min-width: 100px;
    display: flex;
    align-items: center;

  }

  #change-icon{
    color: rgb(141, 180, 252);
    margin-left: 32px;
  }
</style>
