<#include "../default_cfg.ftl"/>
<div class="table-scrollable">
    <table class="table table-hover table-bordered">
        <thead>
        <tr>
            <th width="48px"> 序号</th>
            <th> 产品名称</th>
            <th> 单价</th>
            <th> 产品描述</th>
            <th> 销售状态</th>
            <th> 操作</th>
        </tr>
        </thead>
        <tbody>
        <#if pageInfo?? && pageInfo.list??>
            <#import "../rownum.ftl" as q>
            <#list pageInfo.list as product>
            <tr class="odd gradeX">
                <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=product_index /></td>
                <td> ${product.componentname!''}</td>
                <td> ${product.componentprice!''}元/${product.smstype!''}</td>
                <td> ${product.serverremark!''}</td>
                <td>
                    <#if (product.salestatus == '1' )>
                        正常
                    </#if>
                    <#if (product.salestatus == '0' )>
                        停止销售
                    </#if>
                </td>
                <td>
                  <#if (product.salestatus == '1' )>
                       <a href="${ctxPath}${product.url!''}&productcode=${product.componentcode!''}">续费</a>
                      <#elseif (product.salestatus == '0' )>
                        <a href="javascript:void(0)" style="cursor: default;color:gray">续费</a>
                  </#if>
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
