<#include "../default_cfg.ftl"/>
<div class="table-scrollable">
    <table class="table table-hover table-bordered">
        <thead>
        <tr>
            <th width="48px"> 序号</th>
            <th width="160px"> 编码</th>
            <th> 角色名称</th>
            <th> 操作</th>
        </tr>
        </thead>
        <tbody>
        <#if pageInfo?? && pageInfo.list??>
            <#import "../rownum.ftl" as q>
            <#list pageInfo.list as role>
            <tr class="odd gradeX">
                <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=role_index /></td>
                <td> ${role.rolecode!''}</td>
                <td> ${role.rolename!''}</td>
                <td>
                 <#if role.rolecode != '0001'>
                        <a class="btn btn-default  btn-sm tooltips"
                           href="javascript:openUpdateRole('${role.id!''}')"
                           data-original-title="修改">修改<i class="fa fa-edit"></i>
                        </a>

                        <a href="javascript:goto('${ctxPath}/auth/toUpdate.action?roleid=${role.id}','searchForm');"
                           class="btn btn-default  btn-sm tooltips" data-original-title="修改"> 授权
                            <i class="fa fa-edit"></i>
                        </a>

                        <a class="btn btn-default  btn-sm tooltips"
                           href="javascript:delRole(${role.id});" data-original-title="删除">删除<i
                                class="fa fa-times"></i>
                        </a>
                 </#if>
                </td>
            </tr>
            </#list>
        <#else>
        <tr>
            <td valign="top" colspan="4" class="dataTables_empty">暂无数据</td>
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

