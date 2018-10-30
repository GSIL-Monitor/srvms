<#include "../default_cfg.ftl"/>
<div class="table-scrollable">
<table class="table table-hover table-bordered">
    <thead>
    <tr>
        <th width="48px"> 序号</th>
        <th> 工单编号</th>
        <th> 工单标题</th>
        <th> 工单类型</th>
        <th> 申请人</th>
        <th> 处理状态</th>
        <th> 创建时间</th>
        <th> 操作</th>
    </tr>
    </thead>
    <tbody>
    <#if pageInfo?? && pageInfo.list??>
        <#import "../rownum.ftl" as q>
        <#list pageInfo.list as workOrder>
        <tr class="odd gradeX">
            <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=workOrder_index /></td>
            <td>${workOrder.workordercode!''}</td>
            <td>${workOrder.workordertitle!''}</td>
            <td>
                <#if (workOrder.workordertype!'') == "0">
                        软件工单
                    <#elseif (workOrder.workordertype!'') == "1">
                        硬件工单
                </#if>
            </td>
            <td>${workOrder.createuser!''}</td>
            <td>
                <#if (workOrder.workorderstatus!'') == "0">
                    待处理
                    <#elseif (workOrder.workorderstatus!'') == "1">
                        处理中
                    <#elseif (workOrder.workorderstatus!'') == "2">
                         运营待处理
                    <#elseif (workOrder.workorderstatus!'') == "3" || (workOrder.workorderstatus!'') == "4">
                        运营处理中
                    <#elseif (workOrder.workorderstatus!'') == "5">
                                   待返修
                    <#elseif (workOrder.workorderstatus!'') == "9">
                                   返修完成
                    <#elseif (workOrder.workorderstatus!'') == "6" || (workOrder.workorderstatus!'') == "7" || (workOrder.workorderstatus!'') == "8">
                                   已完成
                </#if>
            </td>
            <td>${workOrder.createtime!''}</td>
            <td>
            <#if (workOrder.workorderstatus!'') == "0">
                <a href="javascript:toServerHandle('${workOrder.workordercode!''}','1')"
                   class="btn btn-default  btn-sm tooltips"
                   data-original-title="立即处理"><i class="fa fa-edit">立即处理</i>
                </a>
                <#elseif (workOrder.workorderstatus!'') == "1">
                <a href="javascript:toServerHandle('${workOrder.workordercode!''}','0')"
                   class="btn btn-default  btn-sm tooltips"
                   data-original-title="继续处理"><i class="fa fa-edit">继续处理</i>
                </a>
                <#elseif (workOrder.workorderstatus!'') == "2" && (workOrder.feedbackplatform!'') == '1'>
                <a href="javascript:deleteWorkOrder('${workOrder.workordercode!''}')"
                   class="btn btn-default  btn-sm tooltips"
                   data-original-title="删除"><i class="fa fa-edit">删除</i>
                </a>
                <#elseif (workOrder.workorderstatus!'') == "5">
                <a href="javascript:finishService('${workOrder.workordercode!''}','0')"
                   class="btn btn-default  btn-sm tooltips"
                   data-original-title="确认返修"><i class="fa fa-edit">返修完成</i>
                </a>
            </#if>
                <a href="javascript:toWorkOrderDetail('${workOrder.workordercode!''}')"
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