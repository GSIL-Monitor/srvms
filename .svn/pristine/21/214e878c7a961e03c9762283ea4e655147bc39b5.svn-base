package com.wgb.freemarker;

import com.wgb.util.DateUtils;
import freemarker.core.Environment;
import freemarker.ext.servlet.HttpRequestHashModel;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
import net.sf.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2017/5/6 0006.
 */
public class Time implements TemplateDirectiveModel {

    public Time() {
    }

    public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
        HttpServletRequest request = ((HttpRequestHashModel) env.getDataModel().get("Request")).getRequest();
        body.render(env.getOut().append("<script type=\'text/javascript\'>").append("var timeNodes=").append(getTimeNodes()).append(";").append("</script>"));
    }

    private String getTimeNodes() {

        Date now = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(now);
        calendar.add(Calendar.DAY_OF_MONTH, 1);

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("monthstart", DateUtils.formatDate2Str(now, "yyyy-MM-dd HH:mm"));
        result.put("monthend", DateUtils.formatDate2Str(now, "yyyy-MM-dd HH:mm"));

        JSONObject jsonData = JSONObject.fromObject(result);
        return jsonData.toString();
    }
}
