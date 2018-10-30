<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="zh-cn">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>中仑零售</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <meta content="#1 selling multi-purpose bootstrap admin theme sold in themeforest marketplace packed with angularjs, material design, rtl support with over thausands of templates and ui elements and plugins to power any type of web applications including saas and admin dashboards. Preview page of Theme #2 for statistics, charts, recent events and reports"
          name="description"/>
    <meta content="" name="author"/>
<#include "./default_cfg.ftl"/>
    <script src="${zl.admin.resource.address}/assets/global/plugins/jquery.min.js?version=${zl.admin.resource.version}" type="text/javascript"></script>
<#include "./menu_list.ftl"/>
<#include "./jumpPage.ftl"/>
<#include "./base_css.ftl"/>
<@block name="cssfile"></@block>
<@block name="csstext"></@block>
</head>
<!-- END HEAD -->
<body class="page-500-full-page">
<@block name="content"></@block>
</body>
<#include "./base_js.ftl"/>
<@block name="jsfile"></@block>
<@block name="jstext"></@block>
</html>