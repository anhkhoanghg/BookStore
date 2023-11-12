
<script src="/assets/library/jquery/dist/jquery.min.js"></script>
<script src="/assets/library/jquery-migrate/dist/jquery-migrate.min.js"></script>
<script src="/assets/library/popper.js/dist/umd/popper.min.js"></script>
<script src="/assets/library/bootstrap/bootstrap.min.js"></script>
<script src="/assets/library/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
<script src="/assets/library/multilevel-sliding-mobile-menu/dist/jquery.zeynep.js"></script>
<script src="/assets/library/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
<script src="/assets/library/slick-carousel/slick/slick.min.js"></script>

<script src="/assets/js/hs.core.js"></script>
<script src="/assets/js/components/hs.unfold.js"></script>
<script src="/assets/js/components/hs.malihu-scrollbar.js"></script>
<script src="/assets/js/components/hs.slick-carousel.js"></script>
<script src="/assets/js/components/hs.show-animation.js"></script>
<script src="/assets/js/components/hs.selectpicker.js"></script>



<script>
    window.onload = function() {
        var customDates = document.getElementsByClassName('customDate');
        for (var i=0; i<customDates.length; i++) {
            var customDate = new Date(customDates[i].innerHTML);
            var year = customDate.getFullYear();
            var month = (customDate.getMonth()+1).toString().padStart(2, '0');
            var day = customDate.getDate().toString().padStart(2, '0');
            document.getElementsByClassName('customDate')[i].innerHTML = day+"-"+month+"-"+year;
        }
    }

    $(document).on('ready', function () {
        $("button#form-write-review").click(function() {
            $([document.documentElement, document.body]).animate({
                scrollTop: $("input#inputCompanyName").offset().top
            }, 2000);
        });
        // initialization of unfold component
        $.HSCore.components.HSUnfold.init($('[data-unfold-target]'));

        // initialization of malihu scrollbar
        $.HSCore.components.HSMalihuScrollBar.init($('.js-scrollbar'));

        // initialization of slick carousel
        $.HSCore.components.HSSlickCarousel.init('.js-slick-carousel');

        // initialization of show animations
        $.HSCore.components.HSShowAnimation.init('.js-animation-link');

        // init zeynepjs
        var zeynep = $('.zeynep').zeynep({
            onClosed: function () {
                // enable main wrapper element clicks on any its children element
                $("body main").attr("style", "");

                console.log('the side menu is closed.');
            },
            onOpened: function () {
                // disable main wrapper element clicks on any its children element
                $("body main").attr("style", "pointer-events: none;");

                console.log('the side menu is opened.');
            }
        });

        // handle zeynep overlay click
        $(".zeynep-overlay").click(function () {
            zeynep.close();
        });

        // open side menu if the button is clicked
        $(".cat-menu").click(function () {
            if ($("html").hasClass("zeynep-opened")) {
                zeynep.close();
            } else {
                zeynep.open();
            }
        });
    });
</script>