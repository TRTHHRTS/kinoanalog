// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
function addCountry() {
    var currentCountry = $( "select#country_select option:selected" );
    var cName;
    var cId;
    if (currentCountry.length > 0) {
        var countryList = $("ul#selected_countries");
        cName = currentCountry.text();
        cId = countryList.children().length + 1;
        countryList.append($('<li id="' + cId + '">' + cName + ' <a class="btn" href="javascript:deleteCountry(' + cId + ')">X</a></li>'));
        countryList.append($('<input id="' + cId + '" type="hidden" value="' + cName + '" name="countries[]" readonly/>'));
        currentCountry.remove();
    }
}

function deleteCountry(id) {
    var removingItem = $("ul#selected_countries");
    removingItem.children().remove("#" + id);
}

function addItem(itemName) {
    var item = $( "#" + itemName + "_select" );
    var item_url = $( "#" + itemName + "_url_select" );
    var item_list =  $( "ul#selected_" + itemName + "s");
    if (item.val().length > 0) {
        if (item_url.val().length > 0) {
            item_list.append($('<a target="_blank" href="' + item_url.val() + '"><li>'+ item.val() +'</li></a>'));
            item_url.val("");
            item_list.append($('<input type="hidden" value="' + item.val() + '" name="' + itemName + 's[]" readonly/>'));
            item_list.append($('<input type="hidden" value="' + item.val() + '" name="' + itemName + '_urls[]" readonly/>'));
        } else {
            item_list.append($('<li>'+ item.val() +'</li>'));
            item_url.val("");
            item_list.append($('<input type="hidden" value="' + item.val() + '" name="' + itemName + 's[]" readonly/>'));
            item_list.append($('<input type="hidden" value="-1" name="' + itemName + '_urls[]" readonly/>'));
        }
        item.val("").focus();
    }
}