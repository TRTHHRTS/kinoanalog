
function findItem(item) {
    $("#json-datalist").empty(); // Очичащем содержимое по id
    // Get the <datalist> and <input> elements.
    var dataList = document.getElementById('json-datalist');
    var input = document.getElementById('ajax');

    if (item.length >= 3)
    {
        $.ajax({
            type: "POST",
            url: "/findItem",
            data: ({name : item}),
            success: function(data){
                if (data["success"]) {
                    data['object'].forEach(function(item_request) {
                        var option = document.createElement('option');
                        option.value = item_request.title;
                        option.name='option';
                        dataList.appendChild(option);
                    });
                }
            }
        });
    }
};