/* =============================================================================
 *
 * Main javascript file
 *
 * ============================================================================= */

document.body.className += 'js-enabled'; //test if javascript is enabled

$(document).ready(function() {

    var cache = new Array();
    var isOpera = window.opera ? true : false;

    preloadImages('images/button-bkg-over.jpg', 'images/loading.gif' , 'images/sidebar-link-over-left.jpg', 'images/sidebar-link-over-right.jpg', 
        'images/more-button-arrow-over.gif', 'images/next-posts-over.png', 'images/prev-posts-over.png');

    /* ------------------------------------------------------------
     * CUFON REPLACEMENT
     * ------------------------------------------------------------ */

    Cufon.replace('#logo, ul#menu > li > a, ul#menu .pixel-mega-menu h4, '+
        '#content .mainarea h1:not(.nocufon), #content .mainarea h2:not(.nocufon), #content .mainarea h3:not(.nocufon), #content .mainarea h4:not(.nocufon), #content .mainarea h5:not(.nocufon), #content .mainarea h6:not(.nocufon), #footer h6,' +
        '#subheader-bar .site-description h4:not(.nocufon)'
        , {
            hover: true
        });    

    /* ------------------------------------------------------------
     * MAIN MENU INITIALIZATION
     * ------------------------------------------------------------ */

    var animSpeed = 400,
    animType = 1;

    if ( window.PX_ANIMATION_SPEED ) {
        animSpeed = window.PX_ANIMATION_SPEED;
    }
    if ( window.PX_ANIMATION_TYPE ) {
        animType = window.PX_ANIMATION_TYPE;
    }

    $('#menu').pixelMenu({
        moreText: '',
        animationSpeed: animSpeed,
        animationType: animType
    });


    $("#s").click(function() {
        $("#s").val('');
    });

    $("#s").focusout(function() {
        if ($("#s").val() == '' ) {
            $("#s").val('Search ...');
        }
    });
    
    $("#com_name").click(function() {
        $(this).val('');
    });
    $("#com_name").focusout(function() {
        if ($(this).val() == '' ) {
            $(this).val('Name *');
        }
    });
    $("#com_subject").click(function() {
        $(this).val('');
    });
    $("#com_subject").focusout(function() {
        if ($(this).val() == '' ) {
            $(this).val('Subject *');
        }
    });
    $("#com_email").click(function() {
        $(this).val('');
    });
    $("#com_email").focusout(function() {
        if ($(this).val() == '' ) {
            $(this).val('Email');
        }
    });
    $("#com_message").click(function() {
        $(this).val('');
    });
    $("#com_message").focusout(function() {
        if ($(this).val() == '' ) {
            $(this).val('Message *');
        }
    });
    
    
    $("#contact_name").click(function() {
        $(this).val('');
    });
    $("#contact_name").focusout(function() {
        if ($(this).val() == '' ) {
            $(this).val('Name *');
        }
    });
    $("#contact_website").click(function() {
        $(this).val('');
    });
    $("#contact_website").focusout(function() {
        if ($(this).val() == '' ) {
            $(this).val('Website');
        }
    });
    $("#contact_email").click(function() {
        $(this).val('');
    });
    $("#contact_email").focusout(function() {
        if ($(this).val() == '' ) {
            $(this).val('Email *');
        }
    });
    $("#contact_message").click(function() {
        $(this).val('');
    });
    $("#contact_message").focusout(function() {
        if ($(this).val() == '' ) {
            $(this).val('Message *');
        }
    });
    

    $('body .preload img').pixelImagePreloader();

    /* ------------------------------------------------------------
     * NIVO SLIDER INIT
     * ------------------------------------------------------------ */

    $('.px-slider.nivoSlider').nivoSlider({
        effect: 'random', // Specify sets like: 'fold,fade,sliceDown'
        slices: 15, // For slice animations
        boxCols: 10, // For box animations
        boxRows: 4, // For box animations
        animSpeed: 500, // Slide transition speed
        pauseTime: 60000, // How long each slide will show
        startSlide: 0, // Set starting Slide (0 index)
        directionNav: true, // Next & Prev navigation
        directionNavHide: false, // Only show on hover
        controlNav: true, // 1,2,3... navigation
        controlNavThumbs: false, // Use thumbnails for Control Nav
        controlNavThumbsFromRel: false, // Use image rel for thumbs
        controlNavThumbsSearch: '.jpg', // Replace this with...
        controlNavThumbsReplace: '_thumb.jpg', // ...this in thumb Image src
        keyboardNav: true, // Use left & right arrows
        pauseOnHover: true, // Stop animation while hovering
        manualAdvance: false, // Force manual transitions
        captionOpacity: 0.8, // Universal caption opacity
        prevText: 'Prev', // Prev directionNav text
        nextText: 'Next' // Next directionNav text
    });

    // WITH THUMBNAILS

    $('.px-slider.nivoSliderThumbs').nivoSlider({
        effect: 'random', // Specify sets like: 'fold,fade,sliceDown'
        slices: 15, // For slice animations
        boxCols: 10, // For box animations
        boxRows: 4, // For box animations
        animSpeed: 500, // Slide transition speed
        pauseTime: 60000, // How long each slide will show
        startSlide: 0, // Set starting Slide (0 index)
        directionNav: false, // Next & Prev navigation
        directionNavHide: false, // Only show on hover
        controlNav: true, // 1,2,3... navigation
        controlNavThumbs: true, // Use thumbnails for Control Nav
        controlNavThumbsFromRel: true, // Use image rel for thumbs
        controlNavThumbsSearch: '.jpg', // Replace this with...
        controlNavThumbsReplace: '_thumb.jpg', // ...this in thumb Image src
        keyboardNav: true, // Use left & right arrows
        pauseOnHover: true, // Stop animation while hovering
        manualAdvance: false, // Force manual transitions
        captionOpacity: 0.8, // Universal caption opacity
        prevText: 'Prev', // Prev directionNav text
        nextText: 'Next' // Next directionNav text
    });

    /* ------------------------------------------------------------
     * ROUNDABOUT SLIDER INIT
     * ------------------------------------------------------------ */

    $('#root .px-slider ul').roundabout({
        minOpacity: 1,
        minScale: 0.1,
        autoplay: true,
        autoplayDuration: 10000
    });

    $('#root ul.gallery.carousel').jcarousel({
        scroll: 1,
        easing: 'easeOutCubic'
    });

    /* ------------------------------------------------------------
     * PRETTYPHOTO INIT
     * ------------------------------------------------------------ */

    $("a[rel^='prettyPhoto']").prettyPhoto({
        overlay_gallery: false,
        social_tools: ''
    });

    /*
     * IMAGE ROLLOVER EFFECT */

    $('#root a.image-holder, #footer .widget.dribble-shots-widget li a, #root .nivo-controlNav a').hover(
        function() {
            $(this).find('img').stop().animate({
                opacity: 0.7
            }, 300);
        },
        function() {
            $(this).find('img').stop().animate({
                opacity: 1
            }, 300);
        }
        );

    $('#root ul.portfolio li a.image-holder').hover(
        function() {
            $(this).find('.description').stop().animate({
                opacity: 1
            }, 200);
        },
        function() {
            $(this).find('.description').stop().animate({
                opacity: 0
            }, 200);
        }
        );

    $('#root a.image-holder').hover(
        function() {
            var elem = $(this).find('span.image-zoom');
            var h = elem.height();
            elem.css({
                top: - h - 12 + 'px',
                height: '100%',
                display: 'block'
            }).stop().animate({
                top: '0px'
            }, 500, 'easeOutCubic');
        },
        function() {
            var elem = $(this).find('span.image-zoom');
            var h = elem.height();
            elem.stop().animate({
                top: h + 12 + 'px',
                height: '100%'
            }, 500, 'easeInCubic', function() {
                $(this).css({
                    top: '0px',
                    display: 'none'
                });
            });
        }
        );
            
            
    /* ------------------------------------------------------------
     * CONTACT FORM
     * ------------------------------------------------------------ */    
    
    $('#send-email-button').click(function(e) {
        e.preventDefault();
        $.post('email.php', {
            name: $('#contact_name').val(),
            email: $('#contact_email').val(),
            subject: $('#contact_subject').val(),
            message: $('#contact_message').val()
        }, function(data) {
            var response = '<div class="alert-box warning"><div class="icon"><p>'+ data +'</p></div></div>';
            $('#email-form div.alert-box').remove();
            $('#email-form').prepend(response);
            $('#email-form div.alert-box').hide().fadeIn(500);
        })
        return false;
    });


    /* ------------------------------------------------------------
     * IMAGE PRELOADING
     * ------------------------------------------------------------ */

    function preloadImages() {
        var img;
        var arg = arguments.length;
        for ( i = 0; i < arg ; i++ ) {
            img = document.createElement('img');
            img.src = arguments[i];
            cache.push(img);
        }
    }

});


/* =============================================================================
 *
 * PIXELMENU Plugin Definition - 2011
 * Author: Pixelcloth
 * Version: 1.3
 *
 * ============================================================================= */

(function ($) {

    // config object

    $.fn.pixelMenu = function(params) {


        var defaults = {
            moreText: '',
            animationSpeed: 500,
            animationType: 1,
            delay: 0,
            menuWidth: 940
        };

        var config = $.extend({}, defaults, params);

        /*
             * Element filtering */

        var allMenuElems = $(this).find('li');
        var megaMenuElems = $(this).find('.pixel-mega-menu li');
        var subMenuElems = allMenuElems.not(megaMenuElems);
        var megaSubmenus = $(this).find('.pixel-mega-menu ul.sub-menu');

        /*
             * Adding some extra css styling to point out which menu item has children */

        $(this).find('ul.sub-menu').not(megaSubmenus).each(function() {

            var html = $(this).parent().find('a:first').html();
            if ( html == '' || html == null ) {
                $(this).parent().find('a:first').append('<span class="drop"></span>');
            } else {
                $(this).parent().find('a:first').append('<span class="drop"></span>');
            }
            $(this).css('display', 'none');
        });

        /*
         * Megamenu position correction */

        $(this).find('.pixel-mega-menu').each(function(index) {

            var pos = $(this).parent().position();
            var menuW = $(this).parent().parent().width();
            var width = $(this).outerWidth() + 20;
            var posLeft = 960 - menuW + pos.left;
            var diff = config.menuWidth - posLeft;

            if ( width > (diff)  ) {
                var newLeft = width - diff;

                $(this).css({
                    left: - newLeft
                })
            }
        });

        /*
             * Hover action bind */

        subMenuElems.hover(

            function() {

                var selElem = $(this).find('ul.sub-menu:first');

                switch ( config.animationType ) {
                    case 1 :
                        selElem.css({
                            overflow: 'hidden',
                            height: 'auto',
                            display: 'none',
                            filter: ''
                        })
                        /*
                        .stop().animate({
                            top: '50px'
                        }, config.animationSpeed);*/

                        .stop().slideDown(config.animationSpeed, function() {
                            $(this).css('overflow', 'visible')
                        });
                        break;
                    case 2 :
                        selElem.css({
                            overflow: 'hidden',
                            height: 'auto',
                            display: 'none',
                            opacity: 1,
                            filter: ''
                        }).stop().fadeIn(config.animationSpeed, function() {
                            $(this).css('overflow', 'visible')
                        });
                        break;
                    default:
                        break;
                }
            },
            function() {
                $(this).find('ul.sub-menu').removeAttr('style');
            }
            );
    }
})(jQuery);



/* =============================================================================
 *
 * PIXEL IMAGE PRELOADER Plugin Definition - 2011
 * Author: Pixelcloth
 * Version: 1.0
 *
 * ============================================================================= */

(function($) {

    $.pixelImagePreloader = {
        defaults: {
            animSpeed: 500,
            loops: 20,
            delay: 100
        }
    };

    $.fn.extend({

        pixelImagePreloader: function(config) {

            var config = $.extend($.pixelImagePreloader.defaults, config);
            var images = $(this);
            var tmpImages = images;
            var noItems = images.length;
            var loadedItems = 0;
            var incr = 0;

            var methods = {

                init: function() {
                    images.each(function() {
                        $(this).parent().prepend('<div class="preloading"></div>');
                        $(this).parent().find('span.image-zoom').css('display', 'none');
                    })
                    methods.checkImages();
                },

                checkImages: function() {

                    incr++;

                    tmpImages.each(function() {
                        if ( this.complete == true ) {
                            loadedItems++;
                            tmpImages = tmpImages.not(this);
                        }
                    });

                    if ( loadedItems == noItems ) {
                        setTimeout(methods.displayImages, 500);
                    } else if ( incr <= config.loops ) {
                        setTimeout(methods.checkImages, 500);
                    }
                },

                displayImages: function() {

                    images.each(function(i) {

                        //                        var delay = 100;

                        var currentImage = $(this);

                        $(this).parent().find('.preloading').delay(i*config.delay).fadeOut(500, function() {
                            $(this).remove();
                        });

                        currentImage.css({
                            visibility: 'visible'
                        }).delay(i*config.delay).fadeIn(500, function() {
                            //                            $(this).parent().find('span.image-zoom').css('display', 'block');
                            });
                    });
                }
            }

            methods.init();

        }
    });


})(jQuery);