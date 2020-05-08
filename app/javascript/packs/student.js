$(document).on('click', '.group-icon', function(event){
    event.preventDefault();
    event.stopPropagation();
    event.stopImmediatePropagation();
    $(this).closest('.course-column-box').find('.group-container').slideToggle(); 
    var table = $(this).closest('.course-column-box').find('#member-table');
    if(! $.fn.DataTable.isDataTable(table)){
        table.DataTable({
         searching: false,
        "lengthChange": false, 
        "pageLength": 5,
        info: false,
        });
    }
});