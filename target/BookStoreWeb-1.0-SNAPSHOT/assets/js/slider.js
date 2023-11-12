$(document).ready(function () {
    $('#most-recent').lightSlider({
        autoWidth: true,
        loop: true,
        onSliderLoad: function () {
            $('#most-recent').removeClass('cs-hidden');
        }
    });
    $('#best-selling').lightSlider({
        autoWidth: true,
        loop: true,
        onSliderLoad: function () {
            $('#best-selling').removeClass('cs-hidden');
        }
    });
    $('#most-favored').lightSlider({
        autoWidth: true,
        loop: true,
        onSliderLoad: function () {
            $('#most-favored').removeClass('cs-hidden');
        }
    });
});