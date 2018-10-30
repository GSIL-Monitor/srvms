<#include "../default_cfg.ftl"/>
<script>
    //分页
    function jumpPage(pageid, no, url) {
        var pageCount = 0;
    <#if pageInfo??>
        pageCount = ${((pageInfo.totalRecords+pageInfo.pageSize -1)/pageInfo.pageSize)?int};
    </#if>
        if (no > pageCount) {
            no = pageCount;
        }
        if (no < 1) {
            no = 1;
        }

        $("#" + pageid).find("input[name='page']").attr("value", no);

        refreshShopList($('#' + pageid).serialize());
    }
</script>
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead class="navbar-inner">
        <tr>
            <th>商户名称</th>
            <th>商户ID</th>
            <th>行业</th>
            <th>联系人</th>
            <th>联系电话</th>
            <th>联系地址</th>
            <th>关联时间</th>
        </tr>
        </thead>
        <tbody>
        <#if pageInfo?? && pageInfo.list??>
            <#list pageInfo.list as shop>
            <tr>
                <td>${shop.shopname!''}</td>
                <td>${shop.shopcode!''}</td>
                <td>${shop.industryname!''}</td>
                <td>${shop.contact!''}</td>
                <td>${shop.tel!''}</td>
                <td>${shop.contactaddress!''}</td>
                <td>${shop.associationtime!''}</td>
            </tr>
            </#list>
        <#else>
        <tr>
            <td valign="top" colspan="8" class="dataTables_empty">暂无数据</td>
        </tr>
        </#if>
        </tbody>
    </table>
</div>
<#if pageInfo?? && pageInfo.totalRecords gt 0>
<form id="shop_list_form" method="post">
    <#import "../pager.ftl" as q>
			                    <@q.pager page=pageInfo.page pageSize=pageInfo.pageSize totalRecords=pageInfo.totalRecords toURL="${ctxPath}/shop/list.action" pageid="shop_list_form"/>
</form>
</#if>