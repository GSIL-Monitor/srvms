<#include "../default_cfg.ftl"/>
<div class="table-scrollable">
<table class="table table-hover table-bordered">
    <thead>
    <tr>
        <th width="48px"> 序号</th>
        <th> 返修单号</th>
        <th> 设备类型</th>
        <th> 设备型号</th>
        <th> 设备唯一码</th>
        <th> 申请人</th>
        <th> 处理状态</th>
        <th> 创建时间</th>
        <th> 操作</th>
    </tr>
    </thead>
    <tbody>
    <#if pageInfo?? && pageInfo.list??>
        <#import "../rownum.ftl" as q>
        <#list pageInfo.list as serviceBill>
        <tr class="odd gradeX">
            <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=serviceBill_index /></td>
            <td>${serviceBill.servicebillcode!''}</td>
            <td>
                <#if (serviceBill.productcategory!'') == '1'>
                    收银机
                    <#elseif (serviceBill.productcategory!'') =='2'>
                        广告机
                </#if>
            </td>
            <td>${serviceBill.productmodel!''}</td>
            <td>${serviceBill.devicecode!''}</td>
            <td>${serviceBill.createuser!''}</td>
            <td>
                <#if (serviceBill.servicebillstatus!'') == "0">
                    待工厂收货
                    <#elseif (serviceBill.servicebillstatus!'') == "1">
                    检测中
                    <#elseif (serviceBill.servicebillstatus!'') == "2">
                    待付款
                    <#elseif (serviceBill.servicebillstatus!'') == "3">
                    待收款
                    <#elseif (serviceBill.servicebillstatus!'') == "4">
                    维修中
                    <#elseif (serviceBill.servicebillstatus!'') == "5">
                    待工厂发货
                    <#elseif (serviceBill.servicebillstatus!'') == "6">
                    待收货
                    <#elseif (serviceBill.servicebillstatus!'') == "7">
                    已完成
                </#if>
            </td>
            <td>${serviceBill.createtime!''}</td>
            <td>
            <#if (serviceBill.servicebillstatus!'') == "2">
                <a href="javascript:comfirmPayment('${serviceBill.servicebillcode!''}','0')"
                   class="btn btn-default  btn-sm tooltips"
                   data-original-title="确认付款"><i class="fa fa-edit">确认付款</i>
                </a>
                 <a href="javascript:cancelService('${serviceBill.servicebillcode!''}','0')"
                    class="btn btn-default  btn-sm tooltips"
                    data-original-title="取消返修"><i class="fa fa-edit">取消返修</i>
                 </a>
                <#elseif (serviceBill.servicebillstatus!'') == "6">
                <button   class="btn btn-default"
                          onclick="openConfirmReceiptWindow('${serviceBill.servicebillcode!''}','${serviceBill.companycourier!''}')"
                          type="button">
                    确认收货
                </button>
            </#if>
                <a href="javascript:toServiceDetail('${serviceBill.servicebillcode!''}')"
                   class="btn btn-default  btn-sm tooltips"
                   data-original-title="详情"><i class="fa fa-edit">详情</i>
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