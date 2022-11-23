package com.fourward.linkchart.controller;

import com.fourward.linkchart.dto.StockDTO;
import com.fourward.linkchart.service.IChartService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Slf4j
@RestController
@RequestMapping(value = "/chart")
@RequiredArgsConstructor
public class ChartController {
    private final IChartService chartService;

    @PostMapping(value = "/getStockData")
    public List<StockDTO> getStockData(HttpServletRequest request) {
        log.info("{}.getStockData start", this.getClass().getName());

        StockDTO pDTO = new StockDTO();

        // 종목명 & 검색 날짜범위 입력. 날짜 Null 일때 기본값 = {시작날짜 : 오늘-2년, 종료날짜 : 오늘}
        pDTO.setName(request.getParameter("stockName"));
        pDTO.setStartDate_req(request.getParameter("startDate_req"));
        pDTO.setEndDate_req(request.getParameter("endDate_req"));
        log.info("requested stockName : [{}]", pDTO.getName());
        log.info("requested startDate : [{}]", pDTO.getStartDate_req());
        log.info("requested endDate : [{}]", pDTO.getEndDate_req());

        // name 을 code 로 변환.
        pDTO.setCode((chartService.getStockCodeByName(pDTO)));
        log.info("requested code : [{}]", pDTO.getCode());
        if (pDTO.getCode().equals("")) {
            log.info("invalid stock name. return null.");
            log.info(this.getClass().getName() + ".getStockData end");

            return null;
        }
        try {
            chartService.insertStockData(pDTO);
        } catch (Exception ignored) {

            return null;
        }

        List<StockDTO> rDTO = chartService.getStockData(pDTO);

        log.info("{}.getStockData end", this.getClass().getName());

        return rDTO;
    }
}
