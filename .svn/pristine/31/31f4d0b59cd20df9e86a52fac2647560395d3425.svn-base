<#include "../default_cfg.ftl"/>
<div class="table-scrollable">
    <table class="table table-hover table-bordered">
        <thead>
        <tr>
            <th width="48px"> 序号</th>
            <th> 订单编号</th>
            <th> 商户编号</th>
            <th> 商户名称</th>
            <th> 订单总额（元）</th>
            <th> 支付方式</th>
            <th> 状态</th>
            <th> 下单时间</th>
            <th width="48px"> 操作</th>
        </tr>
        </thead>
        <tbody>
        <#if pageInfo?? && pageInfo.list??>
            <#import "../rownum.ftl" as q>
            <#list pageInfo.list as renew>
            <tr class="odd gradeX">
                <td style=" vertical-align: middle;"> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=renew_index /></td>
                <td style=" vertical-align: middle;"> ${renew.id!''}</td>
                <td style=" vertical-align: middle;"> ${renew.shopcode!''}</td>
                <td style=" vertical-align: middle;"> ${renew.shopname!''}</td>
                <td style=" vertical-align: middle;"> ${renew.totalamount!''}</td>
                <td style=" vertical-align: middle;">
                    <#if (renew.payfunction!'') == '0'>
                        支付宝
                    <#elseif (renew.payfunction!'') == '1'>
                        微信
                    <#elseif (renew.payfunction!'') == ''>
                    </#if>
                </td>
                <td style=" vertical-align: middle;">
                    <#if (renew.paystatus!'') == '0'>
                        待支付
                    <#elseif (renew.paystatus!'') == '4'>
                        支付失败
                    <#elseif (renew.paystatus!'') == '5'>
                        已完成
                    <#elseif (renew.paystatus!'') == '8'>
                        已失效
                    </#if>
                </td>
                <td>
                    ${renew.createtime!''}
                </td>
                <td>
                <#if (renew.paystatus!'') == '0'>
                    <a href="javascript:void(0)"
                       class="btn btn-default btn-sm tooltips" data-original-title="立即支付"
                       onclick="payRenew('${renew.id}')">
                        立即支付
                    </a>
                </#if>
                    <a href="javascript:openRenewDetail('${renew.id!''}')"
                       class="btn btn-default  btn-sm tooltips"
                       data-original-title="详情">详情
                    </a>
                <#if (renew.paystatus!'') != '5'>
                    <a href="javascript:delOrder('${renew.id}');"
                       class="btn btn-default  btn-sm tooltips"
                       data-original-title="删除">删除
                    </a>
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