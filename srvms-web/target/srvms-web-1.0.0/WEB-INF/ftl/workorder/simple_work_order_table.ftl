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

        refreshWorkOrderList($('#' + pageid).serialize());
    }
</script>
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead class="navbar-inner">
        <tr>
            <th>序号</th>
            <th>工单编号</th>
            <th>工单标题</th>
            <th width="80">操作</th>
        </tr>
        </thead>
        <tbody>
            <#if pageInfo?? && pageInfo.list??>
                <#import "../rownum.ftl" as q>
                <#list pageInfo.list as workOrder>
                <tr>
                    <td><@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=workOrder_index /></td>
                    <td>${workOrder.workordercode!''}</td>
                    <td>${workOrder.workordertitle!''}</td>
                    <td>
                        <a href="javascript:void(0);" style="color: blue"
                           onclick="ChooseWorkOrder.callback({id:'${workOrder.workordercode!''}'})">选择</a>
                    </td>
                </tr>
                </#list>
                <#else >
                    <tr>
                        <td colspan="4">暂无数据</td>
                    </tr>
            </#if>
        </tbody>
    </table>
</div>
<#if pageInfo?? && pageInfo.totalRecords gt 0>
<form id="work_order_list_form" method="post">
    <#import "../pager.ftl" as q>
			                    <@q.pager page=pageInfo.page pageSize=pageInfo.pageSize totalRecords=pageInfo.totalRecords toURL="${ctxPath}/workorder/findWorkOrderByWaitRepair.action" pageid="work_order_list_form"/>
</form>
</#if>