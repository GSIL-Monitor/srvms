<#include "../default_cfg.ftl"/>
<div class="table-scrollable">
<table class="table table-hover table-bordered">
    <thead>
    <tr>
        <th width="48px"> 序号</th>
        <th> 用户名</th>
        <th> 姓名</th>
        <th> 角色</th>
        <th> 权限</th>
        <th width="150px"> 创建时间</th>
        <th> 操作</th>
    </tr>
    </thead>
    <tbody>
    <#if pageInfo?? && pageInfo.list??>
        <#import "../rownum.ftl" as q>
        <#list pageInfo.list as user>
        <tr class="odd gradeX">
            <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=user_index /></td>
            <td> ${user.username!''}</td>
            <td>${user.fullname!''}</td>
            <td>${user.rolenames!''}</td>
            <td>
                <#if (user.flag!0) == 1>
                    <span class="label label-success">正常</span>
                <#else>
                    <span class="label label-danger">被禁用</span>
                </#if>
            </td>
            <td class="center">${user.createtime!''}</td>
            <td>
                <a href="javascript:openUpdateUser('${user.id!''}')"
                   class="btn btn-default  btn-sm tooltips"
                   data-original-title="修改"><i class="fa fa-edit"></i>
                </a>

                <a href="javascript:delUser(${user.id});"
                   class="btn btn-default  btn-sm tooltips"
                   data-original-title="删除"><i class="fa fa-times"></i>
                </a>

                <a href="javascript:resetUserPassword(${user.id});"
                   class="btn btn-default  btn-sm tooltips"
                   data-original-title="重置"><i class="fa fa-refresh"></i>
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