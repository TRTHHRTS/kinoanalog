/**
 * Created by root on 17.04.15.
 */
$( document ).ready(function() {
    stars_count = $("#stars_count");
    $("#rating" + stars_count.text()).prop("checked", true);
});