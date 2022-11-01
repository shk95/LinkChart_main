function getMethod(url, keyword) {
    $.ajax({
        url: url,
        data: keyword,
        type: 'GET',
        dataType: 'json',
        async: false,
        success: function (data) {
            console.log('getData : ' + data);
            return data;
        }
    });
}