function getNewsData(date, keyword) {
    console.log('getNewsData_keyword : ' + keyword);
    console.log('getNewsData_date : ' + date);//yyyyMMdd

    $.ajax({
        url: "/news/getNewsData",
        data: {keyword, date},
        type: 'GET',
        dataType: 'json',
        async: false,
        success: function (data) {
            console.log('getStockData_success_data : ' + JSON.stringify(data[0]));
            return loadNews(data);
        }
    });
}

// 데이터 구조 : List<Map<String,Object(== List<NewsRelatedDTO> || NewsDTO)>>
function loadNews(data) {
    let table = document.createElement('table');
    let tbody = document.createElement('tbody');
    table.appendChild(tbody);


    data.forEach(newsGroup_list => {
        console.log('newsGroup_list.news : ' + JSON.stringify(newsGroup_list.news));
        console.log('newsGroup_list.newsGroup_related_list' + JSON.stringify(newsGroup_list.newsGroup_related_list));
        let tr = document.createElement('tr');
        tbody.appendChild(tr);

        if (newsGroup_list.news.thumb != null) {
            let tdThumb = document.createElement('td');
            tr.appendChild(tdThumb);
            let divThumb = document.createElement('div');
            tdThumb.appendChild(divThumb);

            let aThumb = document.createElement('a');
            divThumb.appendChild(aThumb);
            aThumb.setAttribute('href', newsGroup_list.news.link.toString());

            let imgThumb = document.createElement('img');
            aThumb.appendChild(imgThumb);
            imgThumb.setAttribute('width', '100')
            imgThumb.setAttribute('height', '90')
            imgThumb.setAttribute('src', newsGroup_list.news.thumb);
            imgThumb.setAttribute('width', '100')

        }


    })

    document.getElementById('newsMain').appendChild(table);
}