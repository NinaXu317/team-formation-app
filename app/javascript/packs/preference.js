$(document).ready(function(){
    $("#calendarForm").hide();
    var calendar = null;
    var freeTime = [];
    var submitArray = [];
    $('.showCalendar').click(function (){ 
      $("#calendarForm").slideToggle();
      var calendarEl = document.getElementById('calendar');
      if(calendar){
          calendar.destroy();
          freeTime = [];
      }
      var eventList = new Array();
      calendar = new Calendar(calendarEl, {
          plugins: [ timeGridPlugin, momentPlugin, interactionPlugin, bootstrapPlugin],
          themeSystem: 'bootstrap',
          defaultView: 'timeGridWeek',
          columnHeaderFormat: 'ddd', 
          minTime: "08:00:00", 
          maxTime: "22:00:00",
          header:false,
          allDaySlot: false,
          selectable: true,
          selectHelper: true,
          
          select: function(info) {
              start = info.startStr;
              end = info.endStr;
              var weekdays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
              var event = {
                start: info.startStr,
                end: info.endStr, 
              };
              calendar.addEvent(event);
              console.log("Great: now update your database!");
              console.log(calendar.getEvents());
              
          },
          eventClick: function(info){
            info.event.remove();
          }
      });
      calendar.render();
    });
  
    $('.submitCalendar').click(function (){ 
        console.log("submitted: test");
        if(calendar){
          var weekdays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
          function iterate(event){
            var startDate = event.start;
            var endDate = event.end;
            if(startDate.getDay()==endDate.getDay()){
              freeTime.push({
                'weekday' : weekdays[endDate.getDay()],
                'start' : startDate.toString().split(" ")[4],
                'end' : endDate.toString().split(" ")[4]
              });
              //console.log(endDate.toString().split(" ")[4]);
            }else{
              freeTime.push({
                'weekday' : weekdays[startDate.getDay()],
                'start' : startDate.toString().split(" ")[4],
                'end' : "22:00:00"
              });
              freeTime.push({
                'weekday' : weekdays[endDate.getDay()],
                'start' : "08:00:00",
                'end' : endDate.toString().split(" ")[4],
              });
            }
          }
          calendar.getEvents().forEach(iterate);
        }
        console.log("form is submitted");
        submitArray = [];
        for(i=0; i<freeTime.length; i++){
          submitArray[i]=freeTime[i];
        }
        calendar.destroy();
        freeTime = [];
        //console.log(submitArray);
        $("#calendarForm").hide();
        document.getElementById("fullcalendar").value = JSON.stringify(submitArray);
        var list = document.getElementById("fullcalendar").value;
        console.log(JSON.parse(list));
        console.log(submitArray);
      });
      
  })