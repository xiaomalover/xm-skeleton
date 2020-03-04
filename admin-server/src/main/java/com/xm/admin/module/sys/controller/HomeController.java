package com.xm.admin.module.sys.controller;

import com.alibaba.fastjson.JSONObject;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 首页示例
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@RestController
@RequestMapping("/skeleton/home")
public class HomeController {

    @GetMapping("statistics")
    public Result getStatistics() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("preProfitCount", 10);
        jsonObject.put("completeProfitCount", 100);
        jsonObject.put("canceledProfitCount", 200);
        jsonObject.put("completeProfitAmount", 53);
        jsonObject.put("profitAmountData", JSONObject.parse(" {\n" +
                "\t\t\t\"completeProfitAmount\": [\"1807.47\", \"0.00\", \"1053.36\", \"0.00\", \"586.53\", \"586.53\", \"0.00\", \"0.00\", \"712.23\", \"24997.41\", \"93148.86\", \"2280.29\", \"1771.56\", \"319.20\", \"4229.86\", \"1783.53\"],\n" +
                "\t\t\t\"canceledProfitAmount\": [\"359.10\", \"1432.41\", \"590.52\", \"1500.25\", \"502.74\", \"929.67\", \"175.56\", \"796.60\", \"167.58\", \"1981.91\", \"0.00\", \"0.00\", \"0.00\", \"0.00\", \"3856.34\", \"0.00\"],\n" +
                "\t\t\t\"preProfitAmount\": [\"0.00\", \"8883.80\", \"5191.04\", \"4025.93\", \"6254.35\", \"8504.74\", \"6138.63\", \"3880.31\", \"6009.61\", \"8369.35\", \"18590.69\", \"5454.34\", \"7713.34\", \"3096.91\", \"8582.51\", \"4772.47\"],\n" +
                "\t\t\t\"dates\": [\"2018-12-19\", \"2018-12-20\", \"2018-12-21\", \"2018-12-22\", \"2018-12-23\", \"2018-12-24\", \"2018-12-25\", \"2018-12-26\", \"2018-12-27\", \"2018-12-28\", \"2018-12-29\", \"2018-12-30\", \"2018-12-31\", \"2019-01-01\", \"2019-01-02\", \"2019-01-03\"]\n" +
                "\t\t}"));

        return new ResultUtil<>().setData(jsonObject);
    }
}
