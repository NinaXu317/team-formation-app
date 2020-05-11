<template>
    <div class = "wrapper overflow projects-container">
        <div id="stuapp" class="row projects-row" >
            <div class="col projects-box"> 
                <div class = 'container student-projects-container'>
                    <h5 class='project-title'>
                        Rank Top 3 Projects:
                    </h5>
                    <hr>

                    <a v-for="(group, index) in groups" class='row single-project-container-stu' >
                        <div class='container project-container'>           
                            <h5 class='project-name-text'>
                                {{ group.project_name }}
                            </h5>
                            <div class='form-control editbox-stu'>
                                <p class="project-description-text">{{ group.description }}</p>
                            </div>
                            

                            <div v-if="course.voting==true" class='vote-buttons'>
                                <button v-if="taking.votethird==group.id" class='btn btn-info voteBtn' :id="'t'+group.id">Third ({{group.vthird}})</button>              
                                <button v-else v-on:click = "voteUpdate(group,'third')" class='btn btn-outline-info voteBtn' :id="'t'+group.id">Third ({{group.vthird}})</button>
                                <button v-if="taking.votesecond==group.id" class='btn btn-warning voteBtn' :id="'s'+group.id">Second ({{group.vsecond}})</button>  
                                <button v-else v-on:click = "voteUpdate(group,'second')" class='btn btn-outline-warning voteBtn' :id="'s'+group.id">Second ({{group.vsecond}})</button>
                                <button v-if="taking.votefirst==group.id" class='btn btn-danger voteBtn' :id="'f'+group.id">First ({{group.vfirst}})</button>  
                                <button v-else v-on:click = "voteUpdate(group,'first')" class='btn btn-outline-danger voteBtn' :id="'f'+group.id" >First ({{group.vfirst}})</button>    
                            </div>
                        </div>
                    </a>
                    <p>&nbsp</p>
                    <div v-if="course.voting==true" class = 'single-project-container-stu'>
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
            <div id="middle-col">
            </div>
            <div class="col projects-box"> 
                <div class = 'container student-projects-container'>
                    <h5 class='project-title'>
                    Projects on Hold
                    </h5>
                    <hr>
                  
                    <a v-for="(holdproject, index) in holdprojects" class = 'row single-project-container-stu'>
                        <div class='container project-container'>
                            <h5 class='project-name-text'>
                            {{ holdproject.project_name }}
                            </h5>
                            <div class='form-control editbox-stu'>
                                <p class="project-description-text">{{ holdproject.description }}</p>
                            </div>
                            <div v-if="course.voting==true" class='vote-buttons'>
                                <button v-if="taking.votethird==holdproject.id" class='btn btn-info voteBtn' :id="'t'+holdproject.id">Third ({{holdproject.vthird}})</button>              
                                <button v-else v-on:click = "voteUpdate(holdproject,'third')" class='btn btn-outline-info voteBtn' :id="'t'+holdproject.id">Third ({{holdproject.vthird}})</button>           
                                <button v-if="taking.votesecond==holdproject.id" class='btn btn-warning voteBtn' :id="'s'+holdproject.id">Second ({{holdproject.vsecond}})</button>  
                                <button v-else v-on:click = "voteUpdate(holdproject,'second')" class='btn btn-outline-warning voteBtn' :id="'s'+holdproject.id">Second ({{holdproject.vsecond}})</button>
                                <button v-if="taking.votefirst==holdproject.id" class='btn btn-danger voteBtn' :id="'f'+holdproject.id">First ({{holdproject.vfirst}})</button>  
                                <button v-else v-on:click = "voteUpdate(holdproject,'first')" class='btn btn-outline-danger voteBtn' :id="'f'+holdproject.id" >First ({{holdproject.vfirst}})</button>  
                                
                            </div>
                        </div>
                    </a>
                    <p>&nbsp</p>
                    <div v-if="course.voting==true" class = 'single-project-container-stu'>
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
export default {
  props: ["curr_student", "curr_taking"],
  computed: {
    groups:{
      get(){return this.$store.state.groups.filter(group=>group.active==true)},
      set(value){
          console.log("in vue compute")
          console.log(value)
      }
    },
    holdprojects:{
      get(){return this.$store.state.groups.filter(group=>group.active==false)},
      set(value){
        console.log("in vue compute")
        console.log(value)
      }
    },
    course(){
      return this.$store.state.course
    },
    allprojects(){
        return this.$store.state.groups
    }
  },
  data: function(){
    return {
      messages: {},
      description:{},
      student: this.curr_student,
      taking: this.curr_taking,  
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
                url:`/groups/${group.id}/vote`,
                type: "PATCH",
                data: groupdata,
                dataType: "json",
                success: (data) => {
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
                        var prevgroup = this.allprojects.find(function(element){
                            if(element.id == previd){
                                return element
                            }
                        })
                        console.log(`previous choice is ${prevgroup.project_name}`)
                        var prevdata = new FormData
                        prevdata.append(`group[v${choice_str}]`, prevgroup.vfirst-1)
                        Rails.ajax({
                            url:`/groups/${previd}/vote`,
                            type: "PATCH",
                            data: prevdata,
                            dataType: "json",
                            success: (data) => {
                                //document.getElementById(`f${previd}`).innerHTML= choice_str.charAt(0).toUpperCase() + choice_str.slice(1)+ " ("+prevgroup.vfirst+")"
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
                url:`/groups/${group.id}/vote`,
                type: "PATCH",
                data: groupdata,
                dataType: "json",
                success: (data) => {
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
                        var prevgroup = this.allprojects.find(function(element){
                            if(element.id == previd){
                                return element
                            }
                        })
                        console.log(prevgroup)
                        console.log(`prevgroup is ${prevgroup.project_name}`)
                        var prevdata = new FormData
                        prevdata.append(`group[v${choice_str}]`, prevgroup.vsecond-1)
                        Rails.ajax({
                            url:`/groups/${previd}/vote`,
                            type: "PATCH",
                            data: prevdata,
                            dataType: "json",
                            success: (data) => {
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
                url:`/groups/${group.id}/vote`,
                type: "PATCH",
                data: groupdata,
                dataType: "json",
                success: (data) => {     
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
                        var prevgroup = this.allprojects.find(function(element){
                            if(element.id == previd){
                                return element
                            }
                        })
                        var prevdata = new FormData
                        prevdata.append(`group[v${choice_str}]`, prevgroup.vthird-1)
                        Rails.ajax({
                            url:`/groups/${previd}/vote`,
                            type: "PATCH",
                            data: prevdata,
                            dataType: "json",
                            success: (data) => {
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



    submitMessages: function(column_str,course_id){
      
      console.log(this.description[column_str])
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
            this.messages[column_str] = undefined
            this.description[column_str]= undefined
          }
        })
    }
  }
}
</script>

