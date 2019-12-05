$(document).on('change', '.task-check', function(){
    // var link_true = $(this).attr("checked");
    // var lind_id = $(this).attr("value");
    //
    // if (link_true == 'checked') {
    //     // $('#' + id).text('Available' );
    //     $('#' + lind_id).siblings('.sub_link').show();
    // } else {
    //     // $('#' + id).text('On restoration' );
    //     $('#' + lind_id).siblings('.sub_link').hide();
    // }
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

$(document).ready(function() {
    $('.task-check').each(function() {
        // var link_true = $(this).hasAttr("checked");

        var lind_id = $(this).attr("value");

        if ($(this).attr("checked")) {
            // $('#' + id).text('Available' );
            $('#' + lind_id).siblings('.sub_link').show();
        } else {
            // $('#' + id).text('On restoration' );
            $('#' + lind_id).siblings('.sub_link').hide();
        }
    });
});