package com.wgb.freemarker;

import com.wgb.freemarker.service.UserDataService;
import com.wgb.freemarker.service.UserDataServiceImpl;
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
 * Created by wgb on 2017/2/4.
 */
public class User implements TemplateDirectiveModel {

    private static UserDataService userDataService = UserDataServiceImpl.getInstance();

    public User() {
    }

    public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
        HttpServletRequest request = ((HttpRequestHashModel) env.getDataModel().get("Request")).getRequest();
        body.render(env.getOut().append("<script type=\'text/javascript\'>").append("var userNodes=").append(userDataService.getUserJsonData(request, params)).append(";").append("</script>"));
    }
}
