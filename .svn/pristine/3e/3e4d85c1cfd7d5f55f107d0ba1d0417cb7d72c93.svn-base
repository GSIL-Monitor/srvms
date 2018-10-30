<#include "../default_cfg.ftl"/>
<div class="table-scrollable">
    <table class="table table-hover table-bordered">
        <thead>
        <tr>
            <th width="48px"> 序号</th>
            <th> 商户ID</th>
            <th> 商户名称</th>
            <th> 联系人</th>
            <th> 联系电话</th>
            <th> 分店数</th>
            <th> 操作</th>
        </tr>
        </thead>
        <tbody>
        <#if pageInfo?? && pageInfo.list??>
            <#import "../rownum.ftl" as q>
            <#list pageInfo.list as shop>
            <tr class="odd gradeX">
                <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=shop_index /></td>
                <td> ${shop.shopcode!''}</td>
                <td> ${shop.shopname!''}</td>
                <td> ${shop.contact!''}</td>
                <td> ${shop.tel!''}</td>
                <td> ${shop.branchnums!''}</td>
                <td>
                   <#-- <a href="?shopcode=${shop.shopcode}">-->
                       <a href="javascript:void(0)" onclick="renew(${shop.shopcode});">
                        续费
                       </a>
                    <a href="${ctxPath}/branchRenew/showOrderTable.action?shopcode=${shop.shopcode}">
                        查看订单
                    </a>
                       <a href="javascript:void(0)" onclick="extendProbation(${shop.shopcode});">
                       延长试用期
                   </a>
                </td>
            </tr>
            </#list>
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