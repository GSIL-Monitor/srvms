<@override name="right">
    <#assign menuTreeList = Session["menuTreeList"]>
    <#if menuTreeList?? &&  menuTreeList?size gt 0>
        <#list menuTreeList as menuItem>
            <#if menuItem.childList?? && menuItem.childList?size gt 0 && (menuItem.type!'') == 'sys'>
            <h5 class="page-header" <#if menuItem_index == 0>style="margin-top:0px;"</#if>>${menuItem.name!''}</h5>
            <div class="clearfix">
                <#list menuItem.childList as  childItem>
                <a href="${ctxPath}${childItem.url!''}" class="tile img-rounded">
                    <i class="${childItem.icon!''}"></i>
                    <span>${childItem.name!''}</span>
                </a>
                </#list>
            </div>
            </#if>
        </#list>
    </#if>
</@override>
<@override name="window">
</@override>
<@extends name="./base_sys.ftl"/>