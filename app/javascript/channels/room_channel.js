import consumer from "./consumer"
var subscription
document.addEventListener('turbolinks:load', function(){
  let room = document.getElementById('classroom')
  if(room){
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
  
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log(`receive data from ${$('#classroom').attr('data-room-id')}`)
        var parsed_data = JSON.parse(data.payload)
        console.log(parsed_data.course_id)
        if (parsed_data.course_id == $('#classroom').attr('data-room-id') && data.commit){
          console.log("matches!")
          window.store.commit(data.commit, JSON.parse(data.payload))
          console.log(data)
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

