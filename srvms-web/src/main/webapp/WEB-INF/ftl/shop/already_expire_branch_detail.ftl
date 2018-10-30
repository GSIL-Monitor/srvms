<#include "../default_cfg.ftl"/>
<div class="table-scrollable">
    <table class="table table-hover table-bordered">
        <thead>
        <tr>
            <th width="48px"> 序号</th>
            <th> 商户名称</th>
            <th> 商户ID</th>
            <th> 门店名称</th>
            <th> 门店地址</th>
            <th> 门店联系人</th>
            <th> 门店联系方式</th>
            <th> 已到期天数</th>
        </tr>
        </thead>
        <tbody>
        <#if pageInfo?? && pageInfo.list??>
            <#import "../rownum.ftl" as q>
            <#list pageInfo.list as branch>
            <tr>
                <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=branch_index /></td>
                <td> ${branch.shopname!''}</td>
                <td> ${branch.shopcode!''}</td>
                <td> ${branch.branchname!''}</td>
                <td> ${branch.contactaddress!''}</td>
                <td> ${branch.contact!''}</td>
                <td> ${branch.contactnum!''}</td>
                <td> ${branch.expiredate!''}</td>
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
<div class="row">
    <div class="col-md-12 col-sm-12">
        <form class="zl-content-pager-form" method="post">
            <#import "../zlf_common_pager.ftl" as q>
			                    <@q.pager page=pageInfo.page pageSize=pageInfo.pageSize totalRecords=pageInfo.totalRecords/>
        </form>
    </div>
</div>
</#if>