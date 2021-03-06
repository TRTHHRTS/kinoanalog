var oldValueObj = null;

function findList(obj) {
    var nameObj=obj.name;
    var valueObj=obj.value;
    var jsListId=obj.list.id;

    if (valueObj.length >= 3 && oldValueObj != valueObj)
    {
        oldValueObj = valueObj;
        $("#"+jsListId).empty();
        var dataList = document.getElementById(jsListId);
        $.ajax({
            type: "POST",
            url: "/findList",
            data: {
                authenticity_token: window._token,
                name: nameObj,
                value: valueObj
            },
            success: function(data){
                if (data["success"]) {
                    data['object'].forEach(function(item_response) {
                        var option = document.createElement('option');
                        option.value = item_response;
                        dataList.appendChild(option);
                    });
                }
            }
        });
    }
}