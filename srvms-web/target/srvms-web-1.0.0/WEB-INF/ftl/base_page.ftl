<!DOCTYPE html>
<html lang="zh-cn">
<!-- BEGIN HEAD -->
<head>
    <title>中仑服务商后台系统</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="中仑服务商后台系统" name="description"/>
    <meta content="中仑服务商后台系统" name="author"/>
    <link rel="shortcut icon" href="http://091801.zhonglunnet.com/web/images/favicon.png?version=1.0.0"/>
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
    <script src="http://091801.zhonglunnet.com/web/assets/global/plugins/jquery.min.js?version=1.0.0"
            type="text/javascript"></script>
    <script src="http://091801.zhonglunnet.com/web/js/leftmenu.js?version=1.0.0"
            type="text/javascript"></script>
    <script>
        var _hmt = _hmt || [];
        (function () {
            var hm = document.createElement("script");
            hm.src = "https://hm.baidu.com/hm.js?7eff8c09baec59b1c506e9314f43c1a0";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
</head>
<!-- END HEAD -->
<body class="page-container-bg-solid">

<div class="page-wrapper">
    <div class="page-wrapper-row">
        <div class="page-wrapper-top">
            <!-- BEGIN HEADER -->
            <div class="page-header">
                <!-- BEGIN HEADER TOP -->
                <div class="page-header-top">
                    <div class="container">
                        <!-- BEGIN LOGO -->
                        <div class="page-logo">
                            <a href="javascript:void(0)">
                                <img src="http://091801.zhonglunnet.com/web/images/pc/public/logo.png" alt="logo"
                                     class="logo-default">
                            </a>
                        </div>
                        <!-- BEGIN RESPONSIVE MENU TOGGLER -->
                        <a href="javascript:;" class="menu-toggler"></a>
                        <!-- END RESPONSIVE MENU TOGGLER -->
                        <!-- BEGIN TOP NAVIGATION MENU -->
                        <div class="top-menu">
                            <ul class="nav navbar-nav pull-right">
                                <li class="dropdown dropdown-extended header-shopinfo">
                                    <a href="javascript:;" style="cursor: default" id="logo-serverinfo"
                                       class="dropdown-toggle">
                                    </a>
                                </li>
                                <li class="dropdown dropdown-extended">
                                    <a href="javascript:;" style="cursor: default" id="logo-servercode"
                                       class="dropdown-toggle">
                                    </a>
                                </li>

                                <li class="droddown dropdown-separator">
                                    <span class="separator"></span>
                                </li>
                                <li class="dropdown dropdown-user dropdown-dark" id="head-pic-li">

                                </li>
                            </ul>
                        </div>
                        <!-- END TOP NAVIGATION MENU -->
                    </div>
                </div>
                <script>

                    var user_namelabel = userNodes.fullname;
                    var headlihtml = '<ul class="dropdown-menu dropdown-menu-default"><li></li><li><a href="${ctxPath}/login/loginout.action"><i class="icon-key"></i> 退出 </a></li></ul><a href="javascript:;"class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true" onclick="clickExit(this)"><span class="username username-hide-on-mobile">' + user_namelabel + '</span></a>';
                    $('#head-pic-li').html(headlihtml);

                    var logoNextLabel = userNodes.servername || '';
                    $('#logo-serverinfo').html(logoNextLabel);
                    $('#logo-servercode').html("服务商ID：" + (userNodes.servercode || ''));
                    function clickExit(e){
                        var check = $(e).attr("check_open");
                        if(!check){
                            $(e).attr("check_open",true);
                            $("#head-pic-li").removeClass("open");
                            $("#head-pic-li").addClass("open");
                        }else{
                            $("#head-pic-li").removeClass("open");
                            $(e).removeAttr("check_open");
                        }
                    }
                </script>
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
<!-- BEGIN HEADER & CONTENT DIVIDER -->
<div class="clearfix"></div>
<!-- END HEADER & CONTENT DIVIDER -->
<#include "./footer.ftl"/>
</body>
<#include "./base_js.ftl"/>
<#include "./jumpPage.ftl"/>
<@block name="jsfile"></@block>
<@block name="jstext"></@block>
</html>