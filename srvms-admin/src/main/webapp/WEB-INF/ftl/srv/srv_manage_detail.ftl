<#include "../default_cfg.ftl"/>
<div class="table-scrollable">
<table class="table table-hover table-bordered">
    <thead>
    <tr>
        <th width="48px"> 序号</th>
        <th> 服务商ID</th>
        <th> 服务商名称</th>
        <th> 注册码</th>
        <th> 联系人</th>
        <th> 联系方式</th>
        <th> 所在区域</th>
        <th> 所属售后</th>
        <th> 创建时间</th>
        <th> 操作</th>
    </tr>
    </thead>
    <tbody>
    <#if pageInfo?? && pageInfo.list??>
        <#import "../rownum.ftl" as q>
        <#list pageInfo.list as srv>
        <tr class="odd gradeX">
            <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=srv_index /></td>
            <td> ${srv.servercode!''}</td>
            <td> <a href="${ctxPath}/srv/shop/toSrvShopManage.action?servercode=${srv.servercode!''}">${srv.servername!''}</a></td>
            <td> ${srv.regservercode!''}</td>
            <td> ${srv.contact!''}</td>
            <td> ${srv.tel!''}</td>
            <td> ${srv.area!''}</td>
            <td> ${srv.aftersalesname!''}</td>
            <td > ${srv.createtime!''}</td>
            <td>
                <a href="javascript:update(${srv.servercode});"
                   class="btn btn-default btn-sm tooltips" title="编辑">
                    <i class="fa fa-edit"></i>
                </a>
                <a href="javascript:undatePassword(${srv.tel});"
                   class="btn btn-default btn-sm tooltips" title="重置密码">
                    <i class="fa fa-refresh"></i>
                </a>
                <a href="javascript:toAssociationView(${srv.servercode});"
                   class="btn btn-default btn-sm tooltips" title="关联商户">
                    <i class="fa fa-plus"></i>
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