<@override name="content">
<div class="gw-container" style="min-height: 667px;">
    <#include "./header.ftl"/>
    <div class="navbar navbar-static-top" role="navigation" style="padding-top:20px;">
        <div class="container-fluid">
            <a class="navbar-brand gw-logo" href="${ctxPath}/index.action"></a>
            <ul class="nav navbar-nav pull-right" style="padding-top:10px;">
                <a href="${ctxPath}/index.action" class="tile img-rounded">
                    <i class="fa fa-puzzle-piece"></i>
                    <span>业务功能</span>
                </a>
                <a href="${ctxPath}/sys_index.action" class="tile img-rounded active">
                    <i class="fa fa-sitemap"></i>
                    <span>系统功能</span>
                </a>
                <a href="${ctxPath}/login/entry/logout.action" class="tile img-rounded">
                    <i class="fa fa-sign-out"></i>
                    <span>退出</span>
                </a>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <div class="well">
            <script>
                var h = document.documentElement.clientHeight;
                $(".gw-container").css('min-height', h);
            </script>
            <ol class="breadcrumb" id="breadcrumb">
                <li><a href="${ctxPath}/sys_index.action"><i class="fa fa-home"></i></a></li>
                <li class="active">系统功能</li>
            </ol>
            <script>
                showBreadCrumb();
            </script>
            <div class="clearfix" style="margin-bottom:5em;">
                <ul class="nav nav-tabs" style="display: none;" id="funtitle"></ul>
                <script>
                    showFuncNav();
                </script>
                <@block name="right"></@block>
            </div>
        </div>
    </div>
</div>
</@override>
<@extends name="./base_page.ftl"/>