
function findList(obj) {
    var nameObj=obj.name;
    var valueObj=obj.value;
    var jsListId=obj.list.id;
    $("#"+jsListId).empty();
    var dataList = document.getElementById(jsListId);
    if (valueObj.length >= 3)
    {
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
                    data['object'].forEach(function(item_request) {
                        var option = document.createElement('option');
                        option.value = item_request.name;
                        dataList.appendChild(option);
                    });
                }
            }
        });
    }
};