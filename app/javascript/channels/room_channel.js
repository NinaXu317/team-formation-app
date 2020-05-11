import consumer from "./consumer"
var subscription
document.addEventListener('turbolinks:load', function(){
  let room = document.getElementById('classroom')
  var room_id = $('#classroom').attr('data-room-id')
  var exists_already = false
  console.log(consumer.subscriptions)
  for (var i=0; i<consumer.subscriptions.subscriptions.length; i++){
    var ident = consumer.subscriptions.subscriptions[i].identifier
    consumer.subscriptions.subscriptions[i].unsubscribe()
    consumer.subscriptions.subscriptions[i].disconnect()
    console.dir(ident)
    console.log(room_id)
    if (ident == `{"channel":"RoomChannel","id":"${room_id}"}`) {
      console.log('exists already')
      exists_already = true
    }
  }
  console.log(exists_already)
  if(room && !exists_already){
    console.log("exist!")
    console.log($('#classroom').attr('data-room-id'))
    subscription = consumer.subscriptions.create({
      channel: "RoomChannel", 
      id:$('#classroom').attr('data-room-id')
      },
      {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log(`connected to ${$('#classroom').attr('data-room-id')}`)
      },
  
      disconnected() {
        // Called when the subscription has been terminated by the server
        console.log(`disconnected from ${$('#classroom').attr('data-room-id')}`)
      },

      rejected: function() {
        console.log("rejected");
      },
  
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log("received")
        console.log(data)
        console.log(`receive data from ${$('#classroom').attr('data-room-id')}`)
        var parsed_data = JSON.parse(data.payload)
        console.log(data.commit)
        if(data.commit == "toggleVoting"){
          if(parsed_data.id == $('#classroom').attr('data-room-id')){
            console.log("toggle matches!")
            window.store.commit(data.commit, JSON.parse(data.payload))
          }
        }else if(parsed_data.course_id == $('#classroom').attr('data-room-id') && data.commit){
          console.log(parsed_data.course_id)
          console.log("matches!")
          window.store.commit(data.commit, JSON.parse(data.payload))
        }
            
      }
    });
  }
  
});

document.addEventListener("turbolinks:before-visit",function(){
  let room = document.getElementById('classroom')
  if(room){
    console.log(consumer.subscriptions)
    subscription.unsubscribe()
    subscription.disconnected()
  }
})

