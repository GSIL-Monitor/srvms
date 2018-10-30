<#include "../default_cfg.ftl"/>
<div class="table-scrollable">
    <table class="table table-hover table-bordered">
        <thead>
        <tr>
            <th width="48px"> 序号</th>
            <th> 商户id</th>
            <th> 商户名称</th>
            <th> 商户联系人</th>
            <th> 商户电话</th>
            <th> 关联状态</th>
            <th> 申请时间</th>
        </tr>
        </thead>
        <tbody>
        <#if pageInfo?? && pageInfo.list??>
            <#import "../rownum.ftl" as q>
            <#list pageInfo.list as srv>
            <tr class="odd gradeX">
                <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=srv_index /></td>
                <td> ${srv.shopcode!''}</td>
                <td> ${srv.shopname!''}</td>
                <td> ${srv.shopusername!''}</td>
                <td> ${srv.shoptel!''}</td>
                <td>
                    <#if srv.status == 0>
                        待审核
                    <#elseif srv.status == 1>
                        审核通过
                    <#elseif srv.status == 2>
                        审核不通过
                    </#if>
                <td> ${srv.createtime!''}</td>
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