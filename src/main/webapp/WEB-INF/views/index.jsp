<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>테스트 모델</title>
    <script src="https://www.gstatic.com/charts/loader.js" type="text/javascript"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script src="js/doChart.js" type="text/javascript">
        // getChartData
        // loadChart
    </script>
    <script src="js/dateUtil.js" type="text/javascript">
        // date formatter
    </script>

    <script type="text/javascript">
        // 초기 로딩시 보여줄 차트
        $(document).ready(function () {
            getStockData('코스피');
            getNewsData('증시', dateToString(new Date));
        });
    </script>

    <script src="js/doNews.js" type="text/javascript">
        // getNewsData
        // loadNews
    </script>


</head>

<body>
<h1>테스트</h1>
<div style="text-align: right">
    <a href="chart/searchStockData" target="_self">종목 가져오기 페이지</a>
    <br>
    <a href="chart/viewStockChart" target="_self">차트 페이지</a>
</div>

<div style="text-align: center;">

    <div style="display:inline-flex;text-align: center;width: 47%;">
        <div style="width: 100%;">
            <div>
                <h2>차트 부분</h2>
            </div>

            <%--    ajax 적용 방식 차트--%>
            <div>
                <div style="text-align: center;">
                    <div id="chart_div" style="text-align: center; width: 100%; height: 500px;"></div>
                    <label for="stockName">종목명 :
                        <input type="text" id="stockName"/>
                    </label>
                    <button onclick="getStockData();">전송</button>
                    <br/>
                    <a href="/chart/searchStockData" target="_blank">데이터 가져오기</a>
                </div>
            </div>

        </div>
    </div>


    <div style="display:inline-flex;text-align: center;width: 47%;">
        <div style="width: 100%;">
            <div>
                <h2>뉴스 부분</h2>
            </div>
            <div>
                <form action="news/getNewsData" method="get" target="fNews">
                    키워드 : <input type="text" name="name">
                    날짜 : <input type="text" name="date">
                    <input type="submit">
                </form>

                <div id="newsMain">
                    <%-- 기존 ifrmae 뉴스 표시 영역
                    기본값 : 현재 날짜와 증시로 뉴스를 검색--%>
                    <iframe name="fNews" src="news/getNewsData?name=증시&date=<%=request.getAttribute("nowDate")%>"
                            width="100%"
                            height="1200px"></iframe>


                    <%--    ajax 적용 뉴스 표시--%>


<%--
                    <div class="main_section">
                        <div class="container">
                            <div class="container table_container">
                                <table class="table">
                                    <tbody>
                                    <%
                                        //                        바깥 반복문. tr(기사목록) 을 반복 생성
                                        for (HashMap<String, Object> newsGroup_map : newsGroup_list) {
                                            NewsDTO rNewsDTO = (NewsDTO) newsGroup_map.get("news");
                                    %>

                                    <tr>
                                        <td>
                                            &lt;%&ndash;                            "#" 내용은 가이드라인        &ndash;%&gt;
                                            #썸네일이미지 & 링크#
                                            <div>
                                                <%
                                                    if (rNewsDTO.getThumb() != null) {
                                                %><a href="<%=rNewsDTO.getLink()%>"><img width="100" height="90"
                                                                                         src="<%=rNewsDTO.getThumb()%>"
                                                                                         alt="썸네일 없음"></a>
                                                <%}%>
                                            </div>
                                        </td>
                                        <td>
                                            #기사 내용#
                                            <ul>
                                                <li>
                                                    <div>
                                                        #기사 헤드 & 링크#
                                                        <br/>
                                                        <a href="<%=rNewsDTO.getLink()%>">
                                                            <strong><%=rNewsDTO.getHead()%>
                                                            </strong>
                                                        </a>
                                                    </div>
                                                </li>
                                                <li>
                                                    <div>
                                                        #기사 본문 텍스트 & 날짜 & 작성 언론사명#
                                                        <br/>
                                                        <%=rNewsDTO.getSummary()%>
                                                        <br/>
                                                        <hr/>
                                                        <%=rNewsDTO.getDate()%>
                                                        <br/>
                                                        <hr/>
                                                        <%=rNewsDTO.getPublisher()%>
                                                    </div>
                                                </li>
                                            </ul>
                                        </td>
                                        <td>
                                            #연관기사 목록#
                                            <ol>
                                                <%
                                                    //                                    안쪽 반복문. 연관기사 목록(li)을 생성
                                                    ArrayList<NewsRelatedDTO> rNewsRelated_list = (ArrayList<NewsRelatedDTO>) newsGroup_map.get("newsGroup_related_list");
                                                    for (NewsRelatedDTO rNewsRelatedDTO : rNewsRelated_list) {
                                                %>
                                                <li>
                                                    <div>
                                                        #연관기사 텍스트 & 링크 & 언론사명 & 날짜#
                                                        <br/>
                                                        <a href="<%=rNewsRelatedDTO.getLink_related()%>"><%=rNewsRelatedDTO.getHead_related()%>
                                                        </a>
                                                        <br/>
                                                        <hr/>
                                                        <%=rNewsRelatedDTO.getPublisher_related()%>
                                                        <br/>
                                                        <hr/>
                                                        <%=rNewsRelatedDTO.getDate_related()%>
                                                        <br/>
                                                        <hr/>
                                                    </div>
                                                </li>
                                                <%
                                                    }
                                                %>
                                            </ol>
                                        </td>
                                        <td>
                                            <a href="#">
                                                <i class="fa-solid fa-share"></i>
                                            </a>
                                        </td>
                                        <td>
                                            <a href="#">
                                                <i class="fa-regular fa-heart"></i>
                                            </a>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
--%>


                </div>
            </div>
        </div>

    </div>


</body>
</html>