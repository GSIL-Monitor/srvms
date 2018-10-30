package com.wgb.freemarker;

import com.wgb.freemarker.service.MenuDataService;
import com.wgb.freemarker.service.MenuDataServiceImpl;
import freemarker.core.Environment;
import freemarker.ext.servlet.HttpRequestHashModel;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Map;

/**
 * Created by wgb on 2017/1/24.
 */
public class Menu implements TemplateDirectiveModel {

    private static MenuDataService menuDataService = MenuDataServiceImpl.getInstance();

    public Menu() {
    }

    public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
        HttpServletRequest request = ((HttpRequestHashModel) env.getDataModel().get("Request")).getRequest();
        body.render(env.getOut().append("<script type=\'text/javascript\'>").append("var menuNodes=").append(menuDataService.getMenuJsonData(request, params)).append(";").append("</script>"));
    }
}
