$(document).on('change', '.task-check', function(){
    var id = $(this).attr("value");
    $.ajax({
        url: '/books/'+this.value+'/toggle',
        dataType: 'json',
        type: 'POST',
        data: {status: this.checked, id: id},
        success: function(repsonse){
            if (repsonse.book.status == true) {
                $('#' + id).text('Available' );
                $('#' + id).siblings('.sub_link').show();
            } else {
                $('#' + id).text('On restoration' );
                $('#' + id).siblings('.sub_link').hide();

            }
        }
    });
});

document.addEventListener("turbolinks:load", function() {
    $(document).ready(function () {
        $('.task-check').each(function () {
            var lind_id = $(this).attr("value");
            if ($(this).attr("checked")) {
                $('#' + lind_id).siblings('.sub_link').show();
            } else {
                $('#' + lind_id).siblings('.sub_link').hide();
            }
        });
    });
});
