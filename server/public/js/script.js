;(function($){
    'use strict';
    
    /* ==========================================================================
       Preloader
       ========================================================================== */
    $(window).on('load', function() { // makes sure the whole site is loaded 
        $('#status').fadeOut(); // will first fade out the loading animation 
        $('#preloader').delay(350).fadeOut('slow'); // will fade out the white DIV that covers the website. 
        $('body').delay(350).css({'overflow':'visible'});
    })
    /* ==========================================================================
    
    ========================================================================== */
    var $vdoPop = $('.video');
    if($vdoPop.length > 0){
     $vdoPop.magnificPopup({
      type: 'iframe',
      iframe: {
          markup: '<style>.mfp-iframe-holder .mfp-content {max-width: 900px;height:500px}</style>' +
          '<div class="mfp-iframe-scaler" >' +
          '<div class="mfp-close"></div>' +
          '<iframe class="mfp-iframe" frameborder="0" allowfullscreen></iframe>' +
          '</div></div>'
      }
  });
 }


    /* ==========================================================================
       Counter Up
       ========================================================================== */
       var $counter = $('.counter');
       if($counter.length > 0){
        $counter.counterUp({
            delay: 20,
            time: 5000
        });
    }

/* ==========================================================================
        Parallax
        ========================================================================== */
        var $parallax = $('.parallaxie');
        if($parallax.length > 0){
            $parallax.parallaxie({
                speed: 0.5,
            });
        }

/* ==========================================================================
    Screenshot carousel
    ========================================================================== */
    var $loop = $('.screen')
    if($loop.length > 0){
        $loop.owlCarousel({
            center: true,
            loop:true,
            nav: false,
            autoplay:true,
            autoplayTimeout:2000,
            margin:25,
            responsive:{
                320:{
                    items:1,
                    margin:10
                },
                481:{
                    items:3,
                    margin:60
                },
                991:{
                    items:4
                }
            }
        });
    }



/* ==========================================================================
    Testimonial Carousel
    ========================================================================== */
    
    var quoteCarousel = $('.quote')
    if(quoteCarousel.length > 0){
        quoteCarousel.owlCarousel({
            loop:true,
            autoplay:true,
            autoplayTimeout:2500,
            margin: 5,
            nav: false,
            responsive:{
                300:{
                    items:1,
                },
                480:{
                    items:2,
                }
                ,
                768:{
                    items:3,
                }
                ,
                1200:{
                    items:5,
                }
            }
        })
    }

  /* ==========================================================================
    device Carousel
    ========================================================================== */
    
    var $appSlide = $('.app-slide')
    if($appSlide.length > 0){
        $appSlide.owlCarousel({
            loop:true,
            center:true,
            margin: 0,
            autoWidth:true,
            nav: false,
            dots:true,
            ouchDrag : false,
            mouseDrag : false,
            dotsContainer: '.tab-list'
        })
        $('.owl-dot').on('click', function() {
          $appSlide.trigger('to.owl.carousel', [$(this).index(), 300]);
      });    
    }

    /* ==========================================================================
        Wow
        ========================================================================== */
        new WOW().init();
        
    /* ==========================================================================
      Mailchimp Form
      ========================================================================== */
      $('.subscribe form').submit(function(e) {
        e.preventDefault();
        var postdata = $('.subscribe form').serialize();
        $.ajax({
            type: 'POST',
            url: 'assets/subscribe.php',
            data: postdata,
            dataType: 'json',
            success: function(json) {
                if(json.valid == 0) {
                    $('.success-message').hide();
                    $('.error-message').hide();
                    $('.error-message').html(json.message);
                    $('.error-message').fadeIn('fast', function(){
                        $('.subscribe form').addClass('animated shake').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
                            $(this).removeClass('animated shake');
                        });
                    });
                }
                else {
                    $('.error-message').hide();
                    $('.success-message').hide();
                    $('.subscribe form').hide();
                    $('.success-message').html(json.message);
                    $('.success-message').fadeIn('fast', function(){
                        $('.top-content').backstretch("resize");
                    });
                }
            }
        });
    });
    /* ==========================================================================
        Menu click scroll
        ========================================================================== */

        var $navItem = $('.right-nav a, .demo a');
        if($navItem.length > 0 ){
            $navItem.on('click', function (e) {
                $(document).off("scroll");
                if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') 
                    || location.hostname == this.hostname) {

                    var target = $(this.hash),
                headerHeight = $(".navbar").height()-2; // Get fixed header height

                target = target.length ? target : $('[name=' + this.hash.slice(1) +']');

                if (target.length) {
                    $('html,body').animate({
                      scrollTop: target.offset().top - headerHeight
                  }, 1000);
                    return false;
                }
            }
        });
        }
    /* ==========================================================================
       Type effect
       ========================================================================== */ 
       if(document.querySelectorAll(".type").length > 0){
        var options = {
            strings: ['your app', 'your product', 'your device'],
            typeSpeed: 40,
            backSpeed: 10,
            loop: true,
            loopCount: Infinity,
        }
        var typed = new Typed(".type", options)
    }
})(jQuery); 