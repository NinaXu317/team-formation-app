
$(document).on('click', '.group-icon', function(event){
    event.preventDefault();
    event.stopPropagation();
    event.stopImmediatePropagation();
    $(this).closest('.course-column-box').find('.group-container').slideToggle(); 
    var table = $(this).closest('.course-column-box').find('#member-table');
    if(table){
        if(! $.fn.DataTable.isDataTable(table)){
            table.DataTable({
            searching: false,
            "lengthChange": false, 
            info: false,
            "paging":false,
            
            });
        }
    }
});
