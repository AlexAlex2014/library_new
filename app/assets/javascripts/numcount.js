$(document).on('turbolinks:load', function() {
    var cc = 1;
    $(window).scroll(function () {
        $('#counter').each(function(){
            var cPos = $(this).offset().top,
                topWindow = $(window).scrollTop();
            if (cPos < topWindow + 150) {
                if (cc < 2) {
                    $('.number').addClass('viz');
                    $('.number').each(function() {
                        $(this).prop('Counter',0).animate({
                            Counter:$(this).text()
                        },{
                            duration: 4000,
                            easing: 'swing',
                            step:function(now) {
                                $(this).text(Math.ceil(now));
                            }
                        });
                    });
                    cc = cc + 1;
                };
            };
        });
    });
});
