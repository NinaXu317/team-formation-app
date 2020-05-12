document.addEventListener("turbolinks:load", function(){
window.store = new Vuex.Store({
    state: {
      groups:[],
      course: [],
    },
    mutations: {
      addCard(state, data){
        state.groups.push(data)
        var active_groups = state.groups.filter((item)=>item.active == true)
        if(active_groups.length>=3 && state.course.voting==false){
          $(".header").hide()
          $(".disabled").hide()
          $(".enabled").show()
        }else {
          if(active_groups.length<3){
            $("#active3-warning-show").show()
            $("#active3-warning-hide").hide()
          }else{
            $("#active3-warning-show").hide()
            $("#active3-warning-hide").show()
          }
          $(".header").show()
          $(".disabled").show()
          $(".enabled").hide()
        }
      },
      moveCard(state, data){
        console.log(data)
        const old_card_index = state.groups.findIndex((item)=>item.id==data.id)
        state.groups.splice(old_card_index, 1)
        state.groups.splice(data.position-1,0,data)
        console.log(data.course_id)
        var active_groups = state.groups.filter((item)=>item.active == true)
        console.log(`in window store index: ${data.position-1}`)
        if(active_groups.length>=3 && state.course.voting==false){
          $(".header").hide()
          $(".disabled").hide()
          $(".enabled").show()
        }else {
          if(active_groups.length<3){
            $("#active3-warning-show").show()
            $("#active3-warning-hide").hide()
          }else{
            $("#active3-warning-show").hide()
            $("#active3-warning-hide").show()
          }
          $(".header").show()
          $(".disabled").show()
          $(".enabled").hide()
        }
      },
      vote(state, data){
        const card_index = state.groups.findIndex((item)=>item.id==data.id)
        state.groups.splice(card_index, 1, data)
      },
      toggleVoting(state, data){
        console.log(state.course)
        state.course = data
        console.log(state.course)
        console.log(data.voting)
        if(data.voting==false){
          $("#create-preference-show").show()
          $("#create-preference-hide").hide()
        }else{
          $("#create-preference-show").hide()
          $("#create-preference-hide").show()
        }
      }
    }
})
});
document.addEventListener("turbolinks:load", function(){
  var element = document.querySelector('#boards'); 
  if(element != undefined){
    window.store.state.groups = JSON.parse(element.dataset.groups)
    window.store.state.course = JSON.parse(element.dataset.course)
    const app = new Vue({
      el: element,
      store: window.store,
      template: "<App />",
      components: { App }
    });
  }    
});

document.addEventListener("turbolinks:load", function(){
    var element = document.querySelector('#stuboards');
    if(element != undefined){
      window.store.state.groups = JSON.parse(element.dataset.groups)
      window.store.state.course = JSON.parse(element.dataset.course)
      const stuapp = new Vue({
      el: element,
      store: window.store,
      data: {
          student: JSON.parse(element.dataset.student), 
          taking: JSON.parse(element.dataset.taking),

      },
      template: "<stuApp :curr_student='student' :curr_taking='taking' />",
      components: { stuApp }
      });       
    }  
  });

document.addEventListener("turbolinks:load", function(){
        var table = $('#students-table');
        if(table && $.fn.DataTable){
        if(! $.fn.DataTable.isDataTable(table)){
            table.DataTable({
            "lengthChange": false, 
            "pageLength": 10,
            });
        }
        }
});
    
document.addEventListener("turbolinks:load", function(){
  var classroom = $('#classroom')
  if(classroom){
    var voting = $('#classroom').attr('data-room-voting')
    var active = $('#classroom').attr('data-room-active')

    console.log(`active ${active}`)
    console.log(voting)
    if (active == "true" && voting == "false") {
      console.log(`hiding header`)
      $(".header").hide()
      $(".disabled").hide()
      $(".enabled").show()
      
    } else {
      console.log(`showing header`)
      $(".header").show()
      if(active=="true"){
        $("#active3-warning-show").hide()
        $("#active3-warning-hide").show()
      }else{
        $("#active3-warning-show").show()
        $("#active3-warning-hide").hide()
      }
      $(".disabled").show()
      $(".enabled").hide()
    }
    if(voting=="true"){
      $(".warnings").show()
      $("#create-preference-show").hide()
      $("#create-preference-hide").show()
    }else{
      $(".warnings").hide()
      $("#create-preference-show").show()
      $("#create-preference-hide").hide()
    }

    $("#toggle-button").on('click', function(event){
      $("#toggle-button").attr("disabled","disabled");
      console.log(window.store.state.course.id)
      console.log(`active2: `)
      console.log(active)
      var course_id = window.store.state.course.id
      var prev_status = window.store.state.course.voting
      var data = new FormData
      data.append("course[voting]", !window.store.state.course.voting)
      data.append("course[id]", course_id)
      console.dir(data.keys)
      console.dir(data.values)
      // window.store.state.course.voting= !prev_status
      console.log(`about to send ajax`)
      Rails.ajax({
        url: `/courses/${course_id}/toggle_voting`,
        type: "PATCH",
        data: data,
        dataType: "json",
        success: (data) => {
          console.log(`ajax received`)
          console.dir(data) 
          if (prev_status == data.voting) {
            console.log(`previous and current status are equal, changing current:`)
            data.voting = !data.voting
          }
          $("#toggle-button").removeAttr("disabled");
          console.log(`current status ${data.voting}`)
          console.log(`previous status ${prev_status}`)
          var active_count = window.store.state.groups.filter((group)=>group.active==true).length
          console.log(active_count)
          if (active_count>=3 && data.voting == false){
            $(".header").hide()
            console.log(`hiding header  deep`)
            $(".disabled").hide()
            $(".enabled").show()
          } else {
            if(active_count<3){
              $("#active3-warning-show").show()
              $("#active3-warning-hide").hide()
            }else{
              $("#active3-warning-show").hide()
              $("#active3-warning-hide").show()
            }
            $(".header").show()
            console.log(`showing header`)
            $(".disabled").show()
            $(".enabled").hide()
          }
          if(data.voting == false){
            $("#status").text('Current Process: Preference Filling')
            $("#toggle-button").text('Resume Voting')
            $(".warnings").hide()
          }else{
            $("#status").text('Current Process: Voting')
            $("#toggle-button").text( 'End Voting and Allow Preferences')
            $(".warnings").show()
          }
        },
        error: function(data) {
          console.log( `error`)
          console.log(data)
          console.dir(data)
        }
      })
      
    })
  }
});
