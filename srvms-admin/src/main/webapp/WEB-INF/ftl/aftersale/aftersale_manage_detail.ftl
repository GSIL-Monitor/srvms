<#include "../default_cfg.ftl"/>
<div class="table-scrollable">
<table class="table table-hover table-bordered">
    <thead>
    <tr>
        <td width="48px"> 序号</td>
        <td> 售后人员编号</td>
        <td> 姓名</td>
        <td> 联系电话</td>
        <td > 售后区域</td>
        <td> 固定电话</td>
        <td> 邮箱</td>
        <td> 状态</td>
        <td> 创建时间</td>
        <td> 操作</td>
    </tr>
    </thead>
    <tbody>
    <#if pageInfo?? && pageInfo.list??>
        <#import "../rownum.ftl" as q>
        <#list pageInfo.list as aftersale>
        <tr class="odd gradeX">
            <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=aftersale_index /></td>
            <td> ${aftersale.userid!''}</td>
            <td> ${aftersale.username!''}</td>
            <td> ${aftersale.phone!''}</td>
            <td> ${aftersale.areaname!''}</td>
            <td> ${aftersale.telephone!''}</td>
            <td> ${aftersale.email!''}</td>
            <td>
                <#if aftersale.status == 0>
                    <label data="${aftersale.status}" class="label label-danger"
                           onclick="updateFlag(this,${aftersale.userid},'status')">已禁用</label>
                <#elseif aftersale.status == 1>
                    <label data="${aftersale.status}" class="label label-success"
                           onclick="updateFlag(this,${aftersale.userid},'status')">正常</label>
                </#if>
            </td>
            <td > ${aftersale.createtime!''}</td>
            <td>
                <a href="javascript:edit(${aftersale.userid});"
                   class="btn btn-default btn-sm tooltips" title="编辑">
                    <i class="fa fa-edit"></i>
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