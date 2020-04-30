import consumer from "./consumer"
$(document).on('turbolinks:load', function(){
  let room = document.getElementById('classroom')
  if(room){
    console.log("exist!")
    console.log($('#classroom').attr('data-room-id'))
    consumer.subscriptions.create({
      channel: "RoomChannel", 
      id:$('#classroom').attr('data-room-id')
      },
      {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log("yiha we are alive")
      },
  
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
  
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log("receive data")
        if (data.commit){
          window.store.commit(data.commit, JSON.parse(data.payload))
          console.log(data)
        }
        
      }
    });
  }
  
})

