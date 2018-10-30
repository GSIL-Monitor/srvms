<#include "../default_cfg.ftl"/>
<script>

</script>
<table class="table table-hover table-bordered" >

    <thead>
    <tr style="border: 1px solid #eee">
        <th width="48px"> 序号</th>
        <th> 设备型号</th>
        <th> 设备号</th>
        <th> 出错部件</th>
        <th> 处理状态</th>
        <th> 报错时间</th>
    </tr>
    </thead>
    <tbody>
    <#if pageInfo?? && pageInfo.list??>
        <#import "../rownum.ftl" as q>
        <#list pageInfo.list as equip>
        <tr class="odd gradeX" style="border: 1px solid #eee">
            <td><@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=equip_index /> </td>
            <td> ${equip.systemmodel!''}</td>
            <td> ${equip.deviceuniquecode!''}</td>
            <td> ${equip.errortype!''}</td>
            <td>
                <#if equip.repairstate == 0>
                    暂不处理
                <#elseif equip.repairstate == 1>
                    待处理
                <#elseif equip.repairstate == 2>
                    处理中
                <#elseif equip.repairstate == 3>
                    已处理
                </#if>
            </td>
            <td> ${equip.createtime!''}</td>
        </tr>
        </#list>
    </#if>
    </tbody>
</table>

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