/**
 * Created by root on 17.04.15.
 */
$(document).ready(function() {
    var starsCount = $("#stars_count");
    $("#rating" + starsCount.text()).prop("checked", true);
});