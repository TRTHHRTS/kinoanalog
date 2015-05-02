$(document).ready(function(){
    var list = $("ul#selected_stars");
    var inputs = list.find('input');
    $.each(inputs, function(index, value){
        var starName = value.name.slice(6, -1);
        var starUrl = $(value).val();
        var starId = value.id;
        if (starUrl == '-1') {
            list.append($('<li class="selected-item" id="' + starId + '">' + starName +
                '<a href="javascript:deleteItem(\'stars\',' + starId + ')">' +
                '<img src="/assets/remove-orange.png"/></a></li>'));
        } else {
            list.append($('<li class="selected-item" id="' + starId + '"><a target="_blank" href="' + starUrl + '">'+ starName +'</a>' +
                '<a href="javascript:deleteItem(\'stars\',' + starId + ')">' +
                '<img src="/assets/remove-orange.png"/></a></li>'));
        }
    });

    list = $("ul#selected_directors");
    inputs = list.find('input');
    $.each(inputs, function(index, value){
        var dirName = value.name.slice(10, -1);
        var dirUrl = $(value).val();
        var dirId = value.id;
        if (dirUrl == '-1') {
            list.append($('<li class="selected-item" id="' + dirId + '">' + dirName +
                '<a href="javascript:deleteItem(\'directors\',' + dirId + ')">' +
                '<img src="/assets/remove-orange.png"/></a></li>'));
        } else {
            list.append($('<li class="selected-item" id="' + dirId + '"><a target="_blank" href="' + dirUrl + '">'+ dirName +'</a>' +
                '<a href="javascript:deleteItem(\'directors\',' + dirId + ')">' +
                '<img src="/assets/remove-orange.png"/></a></li>'));
        }
    });

    list = $("ul#selected_producers");
    inputs = list.find('input');
    $.each(inputs, function(index, value){
        var prodName = value.name.slice(10, -1);
        var prodUrl = $(value).val();
        var prodId = value.id;
        if (prodUrl == '-1') {
            list.append($('<li class="selected-item" id="' + prodId + '">' + prodName +
                '<a href="javascript:deleteItem(\'producers\',' + prodId + ')">' +
                '<img src="/assets/remove-orange.png"/></a></li>'));
        } else {
            list.append($('<li class="selected-item" id="' + prodId + '"><a target="_blank" href="' + prodUrl + '">'+ prodName +'</a>' +
                '<a href="javascript:deleteItem(\'producers\',' + prodId + ')">' +
                '<img src="/assets/remove-orange.png"/></a></li>'));
        }
    });

    list = $("ul#selected_writers");
    inputs = list.find('input');
    $.each(inputs, function(index, value){
        var writerName = value.name.slice(8, -1);
        var writerUrl = $(value).val();
        var writerId = value.id;
        if (writerUrl == '-1') {
            list.append($('<li class="selected-item" id="' + writerId + '">' + writerName +
                '<a href="javascript:deleteItem(\'writers\',' + writerId + ')">' +
                '<img src="/assets/remove-orange.png"/></a></li>'));
        } else {
            list.append($('<li class="selected-item" id="' + writerId + '"><a target="_blank" href="' + writerUrl + '">'+ writerName +'</a>' +
                '<a href="javascript:deleteItem(\'writers\',' + writerId + ')">' +
                '<img src="/assets/remove-orange.png"/></a></li>'));
        }
    });

    var items = 'countries';
    list = $("ul#selected_countries");
    inputs = list.find('input');
    $.each(inputs, function(index, value){
        var cName = $(value).val();
        var cId = value.id;
        list.append($('<li class="selected-item" id="' + cId + '">' + cName +
            '<a href="javascript:deleteItem(\'' + items + '\',' + cId + ')">' +
            '<img src="/assets/remove-orange.png"/></a></li>'));
        $('select#country_select option:contains('+ cName + ')').remove();
    });

    items = 'genres';
    list = $("ul#selected_genres");
    inputs = list.find('input');
    $.each(inputs, function(index, value){
        var cName = $(value).val();
        var cId = value.id;
        list.append($('<li class="selected-item" id="' + cId + '">' + cName +
            '<a href="javascript:deleteItem(\'' + items + '\',' + cId + ')">' +
            '<img src="/assets/remove-orange.png"/></a></li>'));
        $('select#genre_select option:contains('+ cName + ')').remove();
    });
})


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
            '<a href="javascript:deleteItem(\'' + items + '\',' + cId + ')">' +
            '<img src="/assets/remove-orange.png"/></a></li>'));
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
                '<a href="javascript:deleteItem(\'' + itemName + 's\',' + cId + ')">' +
                '<img src="/assets/remove-orange.png"/></a></li>'));
        } else {
            item_list.append($('<li class="selected-item" id="' + cId + '">' + item.val() +
                '<a href="javascript:deleteItem(\'' + itemName + 's\',' + cId + ')">' +
                '<img src="/assets/remove-orange.png"/></a></li>'));
        }
        item_url.val("");
        item_list.append('<input id="' + cId + '" type="hidden" value="' + url + '" name="' + itemName + 's[' + item.val() + ']" readonly/>');
        item.val("").focus();
    }
}

function deleteItem(c, id) {
    var removingItem = $("ul#selected_"+c);
    var itemName = removingItem.find("li#" + id);
    removingItem.children().remove("#" + id);
    if (c == 'countries') {
        c = 'country'
    } else {
        c = c.substr(0, c.length - 1)
    }
    var select = $("select#" + c + "_select");
    select.append('<option>' + itemName.text() + '</option>')
}