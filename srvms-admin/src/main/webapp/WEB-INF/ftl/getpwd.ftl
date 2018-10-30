<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>中仑零售</title>
    <meta name="description" content="">
    <meta name="Keywords" content="">
<#include "default_cfg.ftl"/>
    <link href="${zl.admin.resource.address}/assets/global/plugins/bootstrap/css/bootstrap.min.css?version=${zl.admin.resource.version}" rel="stylesheet" type="text/css" />
    <link href="${zl.admin.resource.address}/assets/global/css/components.min.css?version=${zl.admin.resource.version}" rel="stylesheet" id="style_components" type="text/css" />
    <link rel="stylesheet" href="${zl.admin.resource.address}/css/login.css?version=${zl.admin.resource.version}">
    <script src="${zl.admin.resource.address}/assets/global/plugins/jquery.min.js?version=${zl.admin.resource.version}" type="text/javascript"></script>
    <script src="${zl.admin.resource.address}/js/common.js?version=${zl.admin.resource.version}" type="text/javascript"></script>
    <script src="${zl.admin.resource.address}/js/util.js?version=${zl.admin.resource.version}" type="text/javascript"></script>
</head>
<body>
<div id="subject">
    <div id="header">
        <div class="header_div">
            <h1 id="logo"><a href="#" title="中仑收银管理员"><img src="${zl.admin.resource.address}/images/pc/public/logo.png" alt="中仑收银管理员"
                                                           title="中仑收银管理员"/></a></h1>

            <#--<div class="user_state"><a href="#" title="登录">登录</a>　|　<a href="#" title="免费注册">免费注册</a></div>-->
            <div class="user_state"><a href="#" title="联系我们">联系我们</a></div>
            <!--登录前-->
            <div class="user_state" style="display:none;">欢迎 <span>赵子龙</span>　|　<span class="cancellation">注销</span>
            </div>
            <!--登录后-->
        </div>
    </div>
    <div class="main">
        <div class="form_div">
            <div class="form_step"><img src="${zl.admin.resource.address}/images/pc/login/back_step1.jpg" alt=""/></div>
            <form class="back_username" method="post">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="100" align="right">账号　</td>
                        <td>
                            <div class="bu_div"><input type="text" id="account" value="" placeholder="手机/邮箱" name="account"
                                                       class="bu_user"/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <div class="back_button">
                                <input type="button" onclick="goto(1)" value="下一步" class="back_button_yes"/>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="form_div" style="display: none;">
            <div class="form_step"><img src="${zl.admin.resource.address}/images/pc/login/back_step2.jpg" alt=""/></div>
            <form class="back_email" method="post">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="100" align="right">验证码　</td>
                        <td>
                            <div class="be_div">
                                <div class="be_prompt">系统已发送一条信息到<span id="accountSpan"></span>，请输入收到到验证码</div>
                                <input type="text" value="" placeholder="输入验证码" name="yzm" id="yzm" class="be_email"/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <div class="back_button">
                                <input type="button" onclick="goto(2)" value="下一步" class="back_button_yes"/>
                            </div>
                        </td>
                    </tr>
                </table>

            </form>
        </div>
        <div class="form_div" style="display: none;">
            <div class="form_step"><img src="${zl.admin.resource.address}/images/pc/login/back_step3.jpg" alt=""/></div>
            <form class="back_password">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="100" align="right">新密码　</td>
                        <td>
                            <div class="bp_div">
                                <input type="password" value="" placeholder="请输入您的新密码" name="password"
                                       id="password" class="bp_password"/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">重复新密码　</td>
                        <td>
                            <div class="bp_div"><input type="password" value="" placeholder="请输入您的新密码" name="repassword"
                                                       id="repassword" class="bp_password"/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <div class="back_button">
                                <input type="button" value="完成" onclick="updatePwd()" class="back_button_yes"/>
                            </div>
                        </td>
                    </tr>
                </table>

            </form>
        </div>
    </div>
</div>
</body>
<script src="${zl.admin.resource.address}/assets/global/plugins/bootstrap/js/bootstrap.min.js?version=${zl.admin.resource.version}" type="text/javascript"></script>
<script src="${zl.admin.resource.address}/assets/global/plugins/bootbox/bootbox.min.js?version=${zl.admin.resource.version}" type="text/javascript"></script>
<script>
    function goto(idx) {

        if(idx == 1){

            var account = $('#account').val();
            if (!checkPhone(account) && !checkEmail(account)) {
                AlertMsg("请输入正确的手机号码或邮箱！");
                return;
            }

            var url = '${ctxPath}/getpwd/entry/checkAccount.action';
            var params = {
                account: account
            };

            $.ajax({
                url: url,
                data: params,
                type: 'post',
                cache: false,
                dataType: 'json',
                async: false,
                success: function (result) {
                    if (result && result != '') {
                        AlertMsg(result);
                    } else {
                        sendYzm(idx);
                    }
                },
                error: function () {
                    AlertMsg("请求异常，请重试或与系统管理员联系");
                }
            });

        } else if(idx == 2){

            var yzm = $('#yzm').val();
            var account = $('#account').val();
            if (checkEmpty(yzm)) {
                AlertMsg("请输入验证码！");
                return;
            }

            var url = '${ctxPath}/getpwd/entry/checkYzm.action';
            var params = {
                account: account,
                yzm: yzm
            };

            $.ajax({
                url: url,
                data: params,
                type: 'post',
                cache: false,
                dataType: 'json',
                async: false,
                success: function (result) {
                    if (result && result != '') {
                        AlertMsg(result);
                    } else {
                        showFormDiv(idx);
                    }
                },
                error: function () {
                    AlertMsg("请求异常，请重试或与系统管理员联系");
                }
            });

        }
    }

    function sendYzm(idx){

        var account = $('#account').val();
        if (!checkPhone(account) && !checkEmail(account)) {
            AlertMsg("请输入正确的手机号码或邮箱！");
            return;
        }

        var url = '${ctxPath}/getpwd/entry/sendYzm.action';
        var params = {
            account: account
        };

        $.ajax({
            url: url,
            data: params,
            type: 'post',
            cache: false,
            dataType: 'json',
            async: false,
            success: function (result) {
                if (result && result != '') {
                    AlertMsg(result);
                } else {
                    showFormDiv(idx);
                }
            },
            error: function () {
                AlertMsg("请求异常，请重试或与系统管理员联系");
            }
        });
    }

    function showFormDiv(idx) {
        var account = $('#account').val();
        if(idx == 1){
            $('#accountSpan').html(account);
        }

        $('.form_div').hide();
        $('.form_div').eq(idx).show();
    }

    function updatePwd() {

        var yzm = $('#yzm').val();
        var account = $('#account').val();
        var password = $('#password').val();
        var repassword = $('#repassword').val();

        if (checkEmpty(password)) {
            AlertMsg("请输入密码！");
            return;
        }

        if (checkEmpty(repassword)) {
            AlertMsg("请输入重复密码！");
            return;
        }

        if (password != repassword) {
            AlertMsg("请输入重复密码！");
            return;
        }

        var url = '${ctxPath}/getpwd/entry/updatePassword.action';
        var params = {
            account: account,
            yzm: yzm,
            password: password
        };

        $.ajax({
            url: url,
            data: params,
            type: 'post',
            cache: false,
            dataType: 'json',
            async: false,
            success: function (result) {
                if (result && result != '') {
                    AlertMsg(result);
                } else {
                    AlertMsg("密码已修改",function(){
                        window.location.href = "http://passport.marvel3d.cn/login";
                    });
                }
            },
            error: function () {
                alert("登录异常，请重试或与系统管理员联系");
            }
        });
    }
</script>
</html>