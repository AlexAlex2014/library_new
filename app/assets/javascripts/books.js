$(document).on('click', '#status', function(){
    var url = $(this).data("url")
    var id = $(this).attr("value");
    $.ajax({
        url: url,
        dataType: "script",
        data: { id: id },
        method: 'POST'
    });
});