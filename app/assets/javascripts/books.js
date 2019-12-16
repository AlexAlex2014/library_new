document.addEventListener("turbolinks:load", function() {
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
                    $('#' + id).siblings().children('.sub_link').show();
                } else {
                    $('#' + id).text('On restoration' );
                    $('#' + id).siblings().children('.sub_link').hide();
                }
            }
        });
    });
    $(document).ready(function () {
        $('.task-check').each(function () {
            var lind_id = $(this).attr("value");
            if ($(this).attr("checked")) {
                $('#' + lind_id).siblings().children('.sub_link').show();
            } else {
                $('#' + lind_id).siblings().children('.sub_link').hide();
            }
        });
        $('tr td h3 .list-group-item').each(function(){
              $(this).attr('data-search-term', $(this).text().toLowerCase());
        });
        $('.live-search-box').on('keyup', function(){
          var searchTerm = $(this).val().toLowerCase();
          $('tr td h3 .list-group-item').each(function(){
                if ($(this).filter('[data-search-term *= ' + searchTerm + ']').length > 0 || searchTerm.length < 1) {
                      $(this).parent().parent().parent().show();
                    } else {
                      $(this).parent().parent().parent().hide();
                    }
              });
        });
    });
});

$(document).on('click', ".delete-link", function() {
    var current_category_tbody = $(this).parents('.post-box')[0];

    if(confirm("Are you sure?")) {
        $.ajax({
            url: '/books/' + $(current_category_tbody).attr('data-item_id'),
            type: 'POST',
            data: { _method: 'DELETE' },
            success: function() {
                $(current_category_tbody).fadeOut(200);
            }
        });
    };
});
$(document).on('click', ".delete-link_com", function() {
    var current_comment_tbody = $(this).parents('.post-box')[0];
    if(confirm("Are you sure?")) {
        $.ajax({
            url: '/books/' + $(current_comment_tbody).attr('current-book_id') + '/comments/' + $(current_comment_tbody).attr('data-item_id'),
            type: 'POST',
            data: { _method: 'DELETE' },
            success: function() {
                $(current_comment_tbody).fadeOut(200);
            }
        });
    };
});