<@override name="content">
    <#include "./header.ftl"/>
<div class="container-fluid">

    <div class="topmenu">
        <ul class="nav navbar-nav">
            <li>
                <a href="${ctxPath}/index.action"><i class="fa fa-home"></i>
                    系统首页</a>
            </li>

            <#assign menuTreeList = Session["menuTreeList"]>
            <#if menuTreeList?? &&  menuTreeList?size gt 0>
                <#list menuTreeList as menuItem>
                    <#if menuItem.childList?? && menuItem.childList?size gt 0 && (menuItem.type!'') != 'sys'>

                        <li class="dropdown">
                            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown"><i
                                    class="${menuItem.icon!''}"></i> ${menuItem.name!''} <i
                                    class="fa fa-angle-down"></i></a>

                            <ul class="dropdown-menu">
                                <#list menuItem.childList as  childItem>
                                    <#if childItem.temp == 0>
                                        <li>
                                            <a href="${ctxPath}${childItem.url!''}">${childItem.name!''}</a>
                                        </li>
                                    </#if>
                                </#list>
                            </ul>

                        </li>
                    </#if>
                </#list>
            </#if>
        </ul>
    </div>

    <ul class="nav nav-tabs" id="bas_nav">
    </ul>
    <script>
        showBasNav();
    </script>

    <@block name="right"></@block>
</div>
</@override>
<@extends name="./base_page.ftl"/>