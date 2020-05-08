window.store = new Vuex.Store({
    state: {
      groups:[],
      course: [],
    },
    mutations: {
      addCard(state, data){
        state.groups.push(data)
      },
      moveCard(state, data){
        const old_card_index = state.groups.findIndex((item)=>item.id==data.id)
        state.groups.splice(old_card_index, 1)
        state.groups.splice(data.position-1,0,data)
        console.log(`in window store index: ${data.position-1}`)
      },
      vote(state, data){
        const card_index = state.groups.findIndex((item)=>item.id==data.id)
        state.groups.splice(card_index, 1, data)
      }
    }
})
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
            if(! $.fn.DataTable.isDataTable(table)){
                table.DataTable({
                "lengthChange": false, 
                "pageLength": 10,
                });
            }
    });
    