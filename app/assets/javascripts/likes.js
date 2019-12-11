document.addEventListener("turbolinks:load", function() {
    var set_stars = function (form_id, stars) {
        for (i = 1; i <= 5; i++) {
            if (i <= stars) {
                $('#' + form_id + '_' + i).addClass('on');
            } else {
                $('#' + form_id + '_' + i).removeClass('on');
            }
        }
    };
    $(function () {
        $('.rating_star').click(function () {
            var star = $(this);
            var form_id = $(this).attr('data-form-id');
            var stars = $(this).attr('data-stars');
            var data_id = $(this).attr("data-id");

            set_stars(form_id, stars);

            $('#' + form_id + '_stars').val(stars);

            $.ajax({
                type: "post",
                url: '/books/'+ data_id + '/create_star',
                data: $('#' + form_id).serialize(),
                success: function(){
                    location.reload();
                    $('.star_rating_form').each(function() {
                        $('[data-id=data_id]').removeClass('rating_star').addClass('rating_update');
                    });
                }
            });
        });
        $('.rating_update').click(function () {
            var star = $(this);
            var form_id = $(this).attr('data-form-id');
            var stars = $(this).attr('data-stars');
            var data_id = $(this).attr("data-id");

            set_stars(form_id, stars);

            $('#' + form_id + '_stars').val(stars);
            $.ajax({
                type: "patch",
                url: '/books/'+ data_id + '/update_star',
                data: $('#' + form_id).serialize()
            });
        });
        $('.star_rating_form').each(function() {
            var form_id = $(this).attr('id');
            var stars = $('#' + form_id + '_stars').val();
            set_stars(form_id, stars);
        });
    });
});
