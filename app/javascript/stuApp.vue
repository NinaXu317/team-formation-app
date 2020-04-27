<template>
    <div class="container projects-box"> 
        <div class = 'container' style="min-height: 300px; padding-top: 10px;">
          <h5 style='text-align: center; margin: 0px'>
            Projects
          </h5>
          <hr>

          <a v-for="(group, index) in groups" class='row single-project-container-stu' >            
                <div class='project-name-text'>
                    {{ group.project_name }}
                </div>
                <div class='form-control editbox-stu'>
                    <p class="project-description-text">{{ group.description }}</p>
                </div>
                <div class='vote-buttons'>              
                    <button v-on:click = "voteUpdate(group,'first')" class='btn btn-outline-danger' :id="'f'+group.id" >First ({{group.vfirst}})</button>      
                    <button v-on:click = "voteUpdate(group,'second')" class='btn btn-outline-warning' :id="'s'+group.id">Second ({{group.vsecond}})</button>        
                    <button v-on:click = "voteUpdate(group,'third')" class='btn btn-outline-info' :id="'t'+group.id">Thrid ({{group.vthird}})</button>
                </div>

          </a>

          <div class = 'single-project-container-stu'>
            <textarea v-model="messages['group']" class="form-control editbox" placeholder="Project Name"></textarea>
            <textarea v-model="description['group']" class="form-control editbox" placeholder="Description"></textarea>
            <button v-on:click = "submitMessages(course.id)" class="btn btn-outline-primary addProjectBtn">Add</button>
          </div>
          
        </div>
    </div>

</template>

<script>
import draggable from 'vuedraggable'
export default {
  components: {draggable},
  props: ["group_list", "curr_course", "curr_student", "curr_taking"],
  data: function(){
    return {
      messages: {},
      description:{},
      groups: this.group_list,
      course: this.curr_course,
      student: this.curr_student,
      taking: this.curr_taking
    }
  },
  methods: {
    voteUpdate: function(group, choice_str){
        var groupdata = new FormData
        var buttonType = ""
        var postcount = 0
        if(choice_str=='first'){
            groupdata.append("group[vfirst]", group.vfirst+1)
            Rails.ajax({
                url:`/groups/${group.id}`,
                type: "PATCH",
                data: groupdata,
                dataType: "json",
                success: (data) => {
                    group.vfirst += 1
                    document.getElementById(`f${group.id}`).innerHTML=choice_str.charAt(0).toUpperCase() + choice_str.slice(1)+ " ("+ group.vfirst+")"
                    console.log(`add 1 to ${group.project_name}`)
                    var prevcount = 0
                    var previd = -1
                    if(this.taking.votefirst==-1){
                        console.log("not vote A yet")
                        var takingdata = new FormData
                            takingdata.append(`taking[vote${choice_str}]`, group.id)
                            Rails.ajax({
                                    url:`/takings/${this.taking.id}`,
                                    type: "PATCH",
                                    data: takingdata,
                                    dataType: "json",
                                    success:  (data)=>{
                                        this.taking.votefirst = group.id
                                        console.log(`assign new taking to ${group.project_name}`)
                                    }           
                            })
                        console.log("option 1 finished")
                    }else{
                        previd = this.taking.votefirst
                        var prevgroup = this.groups.find(function(element){
                            if(element.id == previd){
                                return element
                            }
                        })
                        var prevdata = new FormData
                        prevdata.append(`group[v${choice_str}]`, prevgroup.vfirst-1)
                        Rails.ajax({
                            url:`/groups/${previd}`,
                            type: "PATCH",
                            data: prevdata,
                            dataType: "json",
                            success: (data) => {
                                prevgroup.vfirst -= 1
                                document.getElementById(`f${previd}`).innerHTML= choice_str.charAt(0).toUpperCase() + choice_str.slice(1)+ " ("+prevgroup.vfirst+")"
                                console.log("previous group number -1")
                                var takingdata = new FormData
                                takingdata.append(`taking[vote${choice_str}]`, group.id)
                                Rails.ajax({
                                    url:`/takings/${this.taking.id}`,
                                    type: "PATCH",
                                    data: takingdata,
                                    dataType: "json",  
                                    success:  (data)=>{
                                        this.taking.votefirst = group.id
                                        console.log(`assign new taking to ${group.project_name}`)
                                    }   
                                })
                                console.log("option 1 finished")
                            }
                        })
                    }
                }
            })
        }else if(choice_str=='second'){
            groupdata.append("group[vsecond]", group.vsecond+1)
            Rails.ajax({
                url:`/groups/${group.id}`,
                type: "PATCH",
                data: groupdata,
                dataType: "json",
                success: (data) => {
                    group.vsecond += 1
                    document.getElementById(`s${group.id}`).innerHTML=choice_str.charAt(0).toUpperCase() + choice_str.slice(1)+ " ("+ group.vsecond+")"
                    console.log(`add 1 to ${group.project_name}`)
                    var prevcount = 0
                    var previd = -1
                    if(this.taking.votesecond==-1){
                        console.log("not vote B yet")
                        var takingdata = new FormData
                            takingdata.append(`taking[vote${choice_str}]`, group.id)
                            Rails.ajax({
                                    url:`/takings/${this.taking.id}`,
                                    type: "PATCH",
                                    data: takingdata,
                                    dataType: "json",
                                    success:  (data)=>{
                                        this.taking.votesecond = group.id
                                        console.log(`assign new taking to ${group.project_name}`)
                                    }           
                            })
                        console.log("option 2 finished")
                    }else{
                        previd = this.taking.votesecond
                        var prevgroup = this.groups.find(function(element){
                            if(element.id == previd){
                                return element
                            }
                        })
                        var prevdata = new FormData
                        prevdata.append(`group[v${choice_str}]`, prevgroup.vsecond-1)
                        Rails.ajax({
                            url:`/groups/${previd}`,
                            type: "PATCH",
                            data: prevdata,
                            dataType: "json",
                            success: (data) => {
                                prevgroup.vsecond -= 1
                                document.getElementById(`s${previd}`).innerHTML= choice_str.charAt(0).toUpperCase() + choice_str.slice(1)+ " ("+prevgroup.vsecond+")"
                                console.log("previous group number -1")
                                var takingdata = new FormData
                                takingdata.append(`taking[vote${choice_str}]`, group.id)
                                Rails.ajax({
                                    url:`/takings/${this.taking.id}`,
                                    type: "PATCH",
                                    data: takingdata,
                                    dataType: "json",  
                                    success:  (data)=>{
                                        this.taking.votesecond = group.id
                                        console.log(`assign new taking to ${group.project_name}`)
                                    }   
                                })
                                console.log("option 2 finished")
                            }
                        })
                    }
                }
            })
        }else {
            groupdata.append("group[vthird]", group.vthird+1)
            Rails.ajax({
                url:`/groups/${group.id}`,
                type: "PATCH",
                data: groupdata,
                dataType: "json",
                success: (data) => {
                    group.vthird += 1
                    document.getElementById(`t${group.id}`).innerHTML=choice_str.charAt(0).toUpperCase() + choice_str.slice(1)+ " ("+ group.vthird+")"
                    console.log(`add 1 to ${group.project_name}`)
                    var prevcount = 0
                    var previd = -1
                    if(this.taking.votethird==-1){
                        console.log("not vote C yet")
                        var takingdata = new FormData
                            takingdata.append(`taking[vote${choice_str}]`, group.id)
                            Rails.ajax({
                                    url:`/takings/${this.taking.id}`,
                                    type: "PATCH",
                                    data: takingdata,
                                    dataType: "json",
                                    success:  (data)=>{
                                        this.taking.votethird = group.id
                                        console.log(`assign new taking to ${group.project_name}`)
                                    }           
                            })
                        console.log("option 3 finished")
                    }else{
                        previd = this.taking.votethird
                        var prevgroup = this.groups.find(function(element){
                            if(element.id == previd){
                                return element
                            }
                        })
                        var prevdata = new FormData
                        prevdata.append(`group[v${choice_str}]`, prevgroup.vthird-1)
                        Rails.ajax({
                            url:`/groups/${previd}`,
                            type: "PATCH",
                            data: prevdata,
                            dataType: "json",
                            success: (data) => {
                                prevgroup.vthird -= 1
                                document.getElementById(`t${previd}`).innerHTML= choice_str.charAt(0).toUpperCase() + choice_str.slice(1)+ " ("+prevgroup.vthird+")"
                                console.log("previous group number -1")
                                var takingdata = new FormData
                                takingdata.append(`taking[vote${choice_str}]`, group.id)
                                Rails.ajax({
                                    url:`/takings/${this.taking.id}`,
                                    type: "PATCH",
                                    data: takingdata,
                                    dataType: "json",  
                                    success:  (data)=>{
                                        this.taking.votethird = group.id
                                        console.log(`assign new taking to ${group.project_name}`)
                                    }   
                                })
                                console.log("option 3 finished")
                            }
                        })
                    }
                }
            })            
        }
    },



    submitMessages: function(course_id){
      var data = new FormData
      console.log("hello")
      console.log(this.description['group'])
      data.append("group[course_id]", course_id)
      data.append("group[project_name]", this.messages['group'])
      data.append("group[description]", this.description['group'])

        Rails.ajax({
          url: "/groups",
          type: "POST",
          data: data,
          dataType: "json",
          success: (data) => {
            this.groups.push(data)
            this.messages['group']= undefined
            this.description['group']=undefined
          }
        })
    }
  }
}
</script>

<style scoped>

</style>