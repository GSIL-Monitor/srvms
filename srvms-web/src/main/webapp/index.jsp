<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>中仑服务商管理后台</title>
    <meta name="description" content="">
    <meta name="Keywords" content="">
    <link rel="icon" href="https://041001.zhonglunnet.com/images/favicon.png"
          type="image/x-icon"/>
    <link rel="stylesheet" href="<c:url value="/css/login.css" />">
    <script type="text/javascript" src="<c:url value="/js/jquery-1.9.1.min.js" />"></script>
    <style>
        .error {
            font-size: 14px;
            color: #ff9800;
            margin-left: 42px;
        }
    </style>
    <script>

        $(function () {
            $('.lf_title ul li').click(function () {
                $('.lf_title ul li').removeClass('focus');
                $(this).addClass('focus');
                $('#login_tab tr[role]').hide();
                $('#login_tab tr[role="' + $(this).attr('role') + '"]').show();
                $('#password').val('');
                $('.error').hide();
            })
            $('input').focus(function () {
                $('.error').hide();
            })
            if (error && error != '') {
                showError(error);
            }
        })

        function showError(msg, e) {
            if (e) {
                $(e).parent().next().html(msg);
                $(e).parent().next().show();
            } else {
                $('.error :last').html(msg);
                $('.error :last').show();
            }
        }

        function checkForm() {
            //快捷登录
            var username = $('#username').val();
            var password = $('#password').val();
            if (username == '') {
                showError('请输入账号', $('#username'));
                return false;
            }
            if (password == '') {
                showError('请输入密码', $('#password'));
                return false;
            }

            if (!/^(\w){6,20}$/.test(password)) {
                showError('密码必须为6-20位数字、字符、符号', $('#password'));
                return false;
            }

            var validate = false;
            $.ajax({
                url: 'login/entry/login.action',
                data: {
                    username: $('#username').val(),
                    password: $('#password').val(),
                },
                type: 'post',
                cache: false,
                dataType: 'json',
                async: false,
                success: function (result) {
                    debugger;
                    if (result) {
                        debugger;
                        var success = result.success;
                        //验证成功
                        if (success == '1') {
                            window.location.href = "index.action";
                        } else {
                            var errorMsg = result.errorMsg;
                            showError(errorMsg);
                        }

                    }
                },
                error: function (a, b, c) {
                    showError('登录异常，请重试或与系统管理员联系');
                }
            });
            return validate;
        }

    </script>
</head>
<body>
<div id="subject">
    <div id="header">
        <div class="header_div">
            <h1 id="logo"><a href="#" title="中仑零售/餐饮"><img
                    src="https://041001.zhonglunnet.com/images/pc/public/logo.png"
                    alt="中仑零售/餐饮" title="中仑零售/餐饮"/></a></h1>

            <div class="user_state"><a href="https://ls.zhonglunnet.com/dcms-web/about.html" title="联系我们">联系我们</a></div>
        </div>
    </div>
    <div class="login">
        <div class="login_div">
            <form:form method="post" id="fm1" cssClass="login_form" onsubmit="return checkForm();"
                       commandName="${commandName}" role="form">
                <script>
                    var error = '<form:errors path="*" id="msg" cssClass="errors" element="div"/>'
                </script>
                <div class="lf_title">
                    <ul>
                        <li class="focus" role="username">快捷登录</li>
                        <li class="focus" role="username"> &nbsp;</li>
                    </ul>
                </div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="login_tab">
                    <tr role="username">
                        <td>
                            <div class="lf_div"><i class="lf_username"></i></id><input id="username" type="text"
                                                                                       value="" autocomplete="off"
                                                                                       placeholder="已绑定的手机"
                                                                                       name="username"/></div>
                            <div class="error"></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="lf_div"><i class="lf_password"></i><input id="password" type="password" value=""
                                                                                  autocomplete="off"
                                                                                  placeholder="请输入用户密码"
                                                                                  name="password"/></div>
                            <div class="error"></div>

                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="hidden" name="lt" value="${loginTicket}"/>
                            <input type="hidden" name="execution" value="${flowExecutionKey}"/>
                            <input type="hidden" name="_eventId" value="submit"/>
                            <input type="submit" name="submit" value="登录" class="lf_button"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><a href="http://localhost:8086/getpwd.html"
                                             title="忘记密码">忘记密码</a></td>
                    </tr>
                </table>
            </form:form>
        </div>
    </div>
</div>
</body>
</html>