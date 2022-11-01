function getNewsData(date, keyword) {
    console.log('getNewsData_keyword : ' + keyword);
    console.log('getNewsData_date : ' + date);

    $.ajax({
        url: "/news/getNewsData",
        data: {keyword, date},
        type: 'GET',
        dataType: 'json',
        async: false,
        success: function (data) {
            console.log('getStockData_success_data : ' + data);
            return loadNews(data);
        }
    });
}

function loadNews(data) {

}