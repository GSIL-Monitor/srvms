<#include "../default_cfg.ftl"/>
<div class="table-scrollable">
    <table class="table table-bordered table-hover">
        <thead>
        <tr>
            <th width="48px"> 序号</th>
            <th> 订单编号</th>
            <th> 产品名称</th>
            <th> 订单总额（元）</th>
            <th> 支付方式</th>
            <th> 状态</th>
            <th> 下单时间</th>
            <th> 操作</th>
        </tr>
        </thead>
        <tbody>
            <#if pageInfo?? && pageInfo.list??>
                <#import "../rownum.ftl" as q>
                <#list pageInfo.list as orderInfo>
                <tr>
                    <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=orderInfo_index /></td>
                    <td> ${orderInfo.billcode!''}</td>
                    <td> ${orderInfo.productname!''}</td>
                    <td> ${orderInfo.totalamount!''}</td>
                    <td>
                        <#if ((orderInfo.paytype!'') == '0' )>
                            支付宝
                        <#elseif ((orderInfo.paytype!'') == '1' )>
                            微信
                        </#if>
                    </td>
                    <td>
                            <#if (orderInfo.status == '0' )>
                                待支付
                            <#elseif (orderInfo.status == '1' )>
                                已完成
                            <#elseif (orderInfo.status == '2' )>
                                已失效
                            <#elseif (orderInfo.status == '3' )>
                                支付失败
                            <#elseif (orderInfo.status == '4' )>
                                已删除
                            </#if>
                    </td>
                    <td> ${orderInfo.createtime!''}</td>
                    <td>
                        <#if (orderInfo.status!'') == '0'>
                            <a href="${ctxPath}/renew/order/toPayView.action?billcode=${orderInfo.billcode!''}">
                                立即支付</a>   &nbsp;&nbsp;
                        </#if>
                        <a href="${ctxPath}/renew/order/merchantStandardDetail.action?billcode=${orderInfo.billcode!''}">
                            详情</a>
                        <#if (orderInfo.status!'') == '0' || (orderInfo.status!'') == '2'>
                            &nbsp;&nbsp;
                            <a href='javascript:void(0)' onclick="deleteOrder('${orderInfo.billcode}')">删除</a>
                        </#if>
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
