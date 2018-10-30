<#assign menuUrls = ''>
<#list Session["menuList"] as  menuItem>
    <#if menuItem.url?? && menuItem.url != ''>
        <#assign menuUrls = menuUrls + '[' + (menuItem.url!'') + ']'>
    </#if>
</#list>