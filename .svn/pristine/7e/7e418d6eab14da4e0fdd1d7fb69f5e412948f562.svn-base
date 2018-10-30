<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<html lang="zh-cn">
<!-- BEGIN HEAD -->
<head>
    <title>中仑运维</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <meta content="中仑运维" name="description"/>
    <meta content="中仑运维" name="author"/>
    <link rel="shortcut icon" href="${zl.admin.resource.address}/images/favicon.png?version=${zl.admin.resource.version}"/>
<#include "./default_cfg.ftl"/>
<#include "./base_css.ftl"/>
<@block name="cssfile"></@block>
<@block name="csstext"></@block>
<@block name="menu">
    <@menu> </@menu>
</@block>
<@block name="user">
    <@user> </@user>
</@block>
    <script src="${zl.admin.resource.address}/assets/global/plugins/jquery.min.js?version=${zl.admin.resource.version}" type="text/javascript"></script>
    <script src="${zl.admin.resource.address}/js/leftmenu.js?version=${zl.admin.resource.version}" type="text/javascript"></script>
    <script src="${zl.admin.resource.address}/js/websocket/websocket.js?version=${zl.admin.resource.version}"
            type="text/javascript"></script>
    <script src="${zl.admin.resource.address}/js/common.js?version=${zl.admin.resource.version}" type="text/javascript"></script>
    <script src="${zl.admin.resource.address}/js/websocket/reconnecting-websocket.min.js?version=${zl.admin.resource.version}"
            type="text/javascript"></script>

    <script>
        $(function () {
            init_socket();
        })
    </script></head>
<!-- END HEAD -->
<body>

<div class="page-wrapper">
    <div class="page-wrapper-row">
        <div class="page-wrapper-top">
            <!-- BEGIN HEADER -->
            <div class="page-header">
                <!-- BEGIN HEADER TOP -->
                <div class="page-header-top">
                    <div class="container-fluid">
                        <!-- BEGIN LOGO -->
                        <div class="page-logo">
                                <img src="${zl.admin.resource.address}/images/pc/public/logo.png" alt="logo"
                                     class="logo-default">
                        </div>

                        <!-- BEGIN RESPONSIVE MENU TOGGLER -->
                        <a href="javascript:;" class="menu-toggler"></a>
                        <!-- END RESPONSIVE MENU TOGGLER -->

                        <!-- BEGIN TOP NAVIGATION MENU -->
                        <div class="top-menu">
                            <ul class="nav navbar-nav pull-right" id="userinfo">
                                <li class="dropdown dropdown-user dropdown-dark">
                                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown"
                                       data-hover="dropdown" data-close-others="true">
                                        <img alt="" id="user-headpic" class="img-circle" width="39" src="${zl.admin.resource.address}/images/headpic.png"/>
                                        <span class="username username-hide-on-mobile" id="username-label">&nbsp;</span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-default">
                                        <li>
                                            <a href="${zl.admin.urms.domain}/login/entry/logout.action">
                                                <i class="icon-key"></i> 退出 </a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <!-- END TOP NAVIGATION MENU -->
                    </div>
                </div>
                <!-- END HEADER TOP -->
                <!-- BEGIN HEADER MENU -->
            <#include "./top_menu.ftl"/>
                <!-- END HEADER MENU -->
            </div>
            <!-- END HEADER -->
        </div>
    </div>
    <!-- BEGIN CONTAINER -->
    <div class="page-wrapper-row full-height">
        <div class="page-wrapper-middle">
            <div class="page-container">
                <!-- BEGIN SIDEBAR -->
                <div class="page-sidebar-wrapper" style="display: none;">
                    <!-- END SIDEBAR -->
                    <div class="page-sidebar navbar-collapse collapse">
                        <!-- BEGIN SIDEBAR MENU -->
                    <#--<#include "./left_menu.ftl"/>-->
                        <!-- END SIDEBAR MENU -->
                        <script>
                            $.fn.hsMenu($('#t_m_menus'));
                        </script>
                    </div>
                    <!-- END SIDEBAR -->
                </div>
                <!-- END SIDEBAR -->
                <!-- BEGIN CONTENT -->
                <div class="page-content-wrapper">
                    <!-- BEGIN CONTENT BODY -->
                    <div class="page-content">
                        <div class="container-fluid">
                        <@block name="content">
                    </@block>
                        </div>
                    <@block name="window"></@block>
                    </div>
                    <!-- END CONTENT BODY -->
                </div>
                <!-- END CONTENT -->
            </div>
        </div>
    </div>
    <!-- END CONTAINER -->
</div>
<div class="clearfix"></div>
<!-- END HEADER & CONTENT DIVIDER -->
<#include "./footer.ftl"/>
</body>
<#include "./base_js.ftl"/>
<script>
    var user_headpic = userNodes.headpic;
    if (user_headpic && user_headpic != '') {
        $('#user-headpic').attr('src', '${attachUrl}/' + user_headpic);
    }
    $('#username-label').html(userNodes.fullname);
</script>
<#include "./jumpPage.ftl"/>
<@block name="jsfile"></@block>
<@block name="jstext"></@block>
</html>