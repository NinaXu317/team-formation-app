<template>
  <div class = "wrapper overflow projects-container">
    <div id="app" class="row" style="margin-top: 20px">
      <div class="col projects-box"> 
        <div class = 'container' style="min-height: 300px;"> Projects
          <draggable v-model="groups" :options="{group: 'projects'}" class="dragArea" @change="cardMoved">
          <div v-for="(group, index) in groups" class = 'row single-project-container'>
            {{ group.project_name }}
          </div>
        </draggable>
          <div class = 'row single-project-container'>
            <textarea v-model="messages['groups']" class="form-control"></textarea>
            <button v-on:click = "submitMessages('groups', course.id)" class="btn btn-outline-primary addButton">Add</button>
          </div>
          
          
        </div>
      </div>
      
      <div class="col projects-box"> 
        <div class = 'container' style="min-height: 300px;"> Hold Projects
          <draggable v-model="holdprojects" :options="{group: 'projects'}" class="dragArea" @change="cardMoved">
          <div v-for="(holdproject, index) in holdprojects" class = 'row single-project-container'>
            {{ holdproject.project_name }}
          </div>
          </draggable>
          <div class = 'row single-project-container'>
            <textarea v-model="messages['holdprojects']" class="form-control"  ></textarea>
            <button v-on:click = "submitMessages('holdprojects', curr_course.id)" class="btn btn-outline-primary addButton">Add</button>
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
      if(event.added== undefined){return}
  
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
  .dragArea{
    min-height: 10px;
  }
</style>
