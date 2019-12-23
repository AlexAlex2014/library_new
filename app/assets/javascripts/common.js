$(document).on('turbolinks:load', function() {
    $(document).ready(function() {
        // const element =  document.querySelector('.top_text h1');
        // element.classList.add('animated', 'fadeInDown');

        function heightDetect() {
            $(".main_head").css("height", $(window).height());
        };

        heightDetect();
        $(window).resize(function() {
            heightDetect();
        });

        $(".toggle_mnu").on('click', function() {
            $(".sandwich").toggleClass("active");
        });

        $(".top_mnu ul a").on('click', function() {
            $(".top_mnu").fadeOut(600);
            $(".sandwich").toggleClass("active");
        });

        $(".toggle_mnu").on('click', function () {
            if ($(".top_mnu").is(":visible")) {
                $(".top_text").removeClass("h_opacify");
                $(".top_mnu").fadeOut(600);
                $(".top_mnu li a").removeClass("fadeInUp animated");
            } else {
                $(".top_text").addClass("h_opacify");
                $(".top_mnu").fadeIn(600);
                $(".top_mnu li a").addClass("fadeInUp animated");
            };
        });

        $('section h2').each(function() {
            var ths = $(this);
            ths.html(ths.html().replace(/^(\S+)/, '<span>$1</span>'));
        });

        $(".top_mnu ul a").mPageScroll2id();
    });
});


$(document).on('turbolinks:load', function() {
    var script = document.createElement('script');
    script.src = 'https://cdnjs.cloudflare.com/ajax/libs/fotorama/4.6.4/fotorama.min.js';
    script.type = 'text/javascript';
    document.getElementsByTagName('head')[0].appendChild(script);

    $(".loader_inner").fadeOut();
    $(".loader").delay(400).fadeOut("slow");
});

