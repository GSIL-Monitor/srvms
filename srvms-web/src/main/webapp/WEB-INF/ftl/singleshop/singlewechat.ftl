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

        refreshAdminUserList($('#' + pageid).serialize());
    }
</script>
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead class="navbar-inner">
        <tr>
            <th>全部<input type="checkbox" name="checkAll" id="checkAll" onclick="checkAll()"></th>
            <th>序号</th>
            <th>商户编号</th>
            <th>商户名称</th>

        </tr>
        </thead>
        <tbody>
    <#if pageInfo?? && pageInfo.list??>
        <#import "../rownum.ftl" as q>
        <#list pageInfo.list as singleShop>
        <tr>
            <td>
                <input type="checkbox" onclick="singleCheck()">
                <input type="text" hidden name="shopcode" value="${singleShop.shopcode!''}">
                <input type="text" hidden name="shopname" value="${singleShop.shopname!''}">
                <input type="text" hidden name="branchcode" value="${singleShop.branchcode!''}">
                <input type="text" hidden name="branchname" value="${singleShop.branchname!''}">
                <input type="text" hidden name="expiretime" value="${singleShop.expirestime!''}">
            </td>
            <td><@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=singleShop_index /></td>
            <td>${singleShop.shopcode!''}</td>
            <td>${singleShop.shopname!''}</td>
        </tr>
        </#list>
    <#else>
        <tr>
            <td valign="top" colspan="7" class="dataTables_empty">暂无数据</td>
        </tr>
    </#if>
        </tbody>
    </table>
</div>
<#if pageInfo?? && pageInfo.totalRecords gt 0>
<form id="single_shop_form" method="post">
    <#import "../pager.ftl" as q>
			                    <@q.pager page=pageInfo.page pageSize=pageInfo.pageSize totalRecords=pageInfo.totalRecords toURL="${ctxPath}/renew/chooseShop/findwechatallShop.action" pageid="single_shop_form"/>
</form>
</#if>