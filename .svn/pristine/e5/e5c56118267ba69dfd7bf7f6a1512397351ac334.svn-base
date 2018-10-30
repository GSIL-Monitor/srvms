<#include "../default_cfg.ftl"/>
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
        <tr>
            <th width="48px"> 序号</th>
            <th> 订单编号</th>
            <th> 产品名称</th>
            <th> 商户ID</th>
            <th> 商户名称</th>
            <th> 门店编号</th>
            <th> 门店名称</th>
            <th> 延长天数（天）</th>
            <th> 操作时间</th>
            <th> 操作</th>
        </tr>
        </thead>
        <tbody>
                <#if pageInfo??  && pageInfo.list??>
                    <#import "../rownum.ftl" as q>
                    <#list pageInfo.list as extendInfo>
                    <tr>
                        <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=extendInfo_index /></td>
                        <td> ${extendInfo.billcode!''}</td>
                        <td> ${extendInfo.productname!''}</td>
                        <td> ${extendInfo.shopcode!''}</td>
                        <td> ${extendInfo.shopname!''}</td>
                        <td> ${extendInfo.branchcode!''}</td>
                        <td> ${extendInfo.branchname!''}</td>
                        <td> ${extendInfo.renewtime!''}</td>
                        <td> ${extendInfo.createtime!''}</td>
                        <td>
                            <a href="${ctxPath}/renew/extend/queryExtendDetail.action?billcode=${extendInfo.billcode}&shopcode=${extendInfo.shopcode}&branchcode=${extendInfo.branchcode}">详情</a>
                        </td>
                    </tr>
                    </#list>
                <#else>
                <tr>
                    <td valign="top" colspan="10" class="dataTables_empty">暂无数据</td>
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