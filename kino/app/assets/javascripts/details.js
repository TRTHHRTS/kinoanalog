/**
 * Created by root on 17.04.15.
 */
$(document).ready(function() {
    var starsCount = $("#stars_count");
    $("#rating" + starsCount.text()).prop("checked", true);
});

function submitForm(id) {
    $("#close_modal")[0].click();
    var form = $( "#add_rating_form" );
    form.append('<input type="hidden" value="' + id + '" name="rating_value" readonly/>')
    form.submit();
}