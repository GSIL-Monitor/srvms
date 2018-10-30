package com.wgb.controller.industry;

import com.wgb.bean.ZLResult;
import com.wgb.controller.BaseController;
import com.wgb.exception.BusinessException;
import com.wgb.service.IndustryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * 〈〉<br>
 * 〈功能详细描述〉
 *
 * @author wgb
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@Controller
@RequestMapping("industry")
public class IndustryController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(IndustryController.class);
    @Autowired
    private IndustryService industryService;

    @RequestMapping("/getList")
    @ResponseBody
    public List<Map<String, Object>> getList(HttpServletRequest request) {
        Map<String, Object> params = getParams();
        return industryService.getIndustryList(params);
    }

}
