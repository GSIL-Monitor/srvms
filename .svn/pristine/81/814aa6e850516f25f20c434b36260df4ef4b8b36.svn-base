<#include "../default_cfg.ftl"/>
<div class="table-scrollable">
    <table class="table table-hover table-bordered">
        <thead>
        <tr>
            <th width="48px"> 序号</th>
            <th> 商户ID</th>
            <th> 商户名称</th>
            <th> 区域地址</th>
            <th> 用户名</th>
            <th> 行业</th>
            <th> 注册日期</th>
            <th> 联系人</th>
            <th> 手机</th>
        </tr>
        </thead>
        <tbody>
        <#if pageInfo?? && pageInfo.list??>
            <#import "../rownum.ftl" as q>
            <#list pageInfo.list as shop>
            <tr class="odd gradeX">
                <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=shop_index /></td>
                <td> ${shop.shopcode!''}</td>
                <td> ${shop.shopname!''}</td>
                <td> ${shop.area!''}</td>
                <td> 1001</td>
                <td> ${shop.industryname!''}</td>
                <td> ${shop.createtime!''}</td>
                <td> ${shop.contact!''}</td>
                <td> ${shop.tel!''}</td>
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