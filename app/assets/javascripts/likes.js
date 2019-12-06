$(function () {
    $('.rating_star').click(function () {
        var star = $(this);
        var movie_id = $(this).attr('data-movie-id');
        var stars = $(this).attr('data-stars');

        for(i=1; i<=5; i++) {
            if(i <= stars) {
                $('#' + movie_id + '_' + i).addClass('on');
            } else {
                $('#' + movie_id + '_' + i).removeClass('on');
            }
        }
    });
});
