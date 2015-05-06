
function findItem(item) {
    // Get the <datalist> and <input> elements.
    var dataList = document.getElementById('json-datalist');
    var input = document.getElementById('ajax');
    //var option=document.getElementsByName('option');
    //dataList.remove
    //dataList.empty(option);

    // Create a new XMLHttpRequest.
    var request =
        ["html",
        item]


    request.forEach(function(item_request) {
        // Create a new <option> element.
        var option = document.createElement('option');
        // Set the value using the item in the JSON array.
        option.value = item_request;
        option.name='option';
        // Add the <option> element to the <datalist>.
        dataList.appendChild(option);
    });
};