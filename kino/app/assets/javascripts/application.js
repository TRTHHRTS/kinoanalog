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
function addItem(itemName) {
    var items;
    if (itemName == 'country') {
        items = 'countries';
    } else {
        items = 'genres';
    }
    var currentItem = $( "select#" + itemName + "_select option:selected" );
    var cName;
    var cId;
    if (currentItem.length > 0) {
        var itemList = $("ul#selected_" + items);
        cName = currentItem.text();
        cId = itemList.children().length + 1;
        itemList.append($('<li class="selected-item" id="' + cId + '">' + cName +
            '<a class="btn btn-xs" href="javascript:deleteItem(\'' + items + '\',' + cId + ')">' +
            '<img src="/assets/remove.png"/></a></li>'));
        itemList.append($('<input id="' + cId + '" type="hidden" value="' + cName + '" name="' + items + '[]" readonly/>'));
        currentItem.remove();
    }
}

function addItemWithUrl(itemName) {
    var item = $( "#" + itemName + "_select" );
    var item_url = $( "#" + itemName + "_url_select" );
    var item_list =  $( "ul#selected_" + itemName + "s");
    var url;
    var cId;
    if (item_url.val().length > 0) {
        url = item_url.val();
    } else {
        url = '-1';
    }
    if (item.val().length > 0) {
        cId = item_list.children().length + 1;
        if (url != '-1') {
            item_list.append($('<li class="selected-item" id="' + cId + '"><a target="_blank" href="' + item_url.val() + '">'+ item.val() +'</a>' +
                '<a class="btn btn-xs" href="javascript:deleteItem(\'' + itemName + 's\',' + cId + ')">' +
                '<img src="/assets/remove.png"/></a></li>'));
        } else {
            item_list.append($('<li class="selected-item" id="' + cId + '">' + item.val() +
                '<a class="btn btn-xs" href="javascript:deleteItem(\'' + itemName + 's\',' + cId + ')">' +
                '<img src="/assets/remove.png"/></a></li>'));
        }
        item_url.val("");
        item_list.append('<input id="' + cId + '" type="hidden" value="' + url + '" name="' + itemName + 's[' + item.val() + ']" readonly/>');
        item.val("").focus();
    }
}

function deleteItem(c, id) {
    var removingItem = $("ul#selected_"+c);
    removingItem.children().remove("#" + id);
}