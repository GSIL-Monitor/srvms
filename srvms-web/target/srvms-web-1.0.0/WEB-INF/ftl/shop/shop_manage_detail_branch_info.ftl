<#include "../default_cfg.ftl"/>
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
        <tr>
            <th width="48px"> 序号</th>
            <th> 分店编码</th>
            <th> 分店名称</th>
            <th> 负责人</th>
            <th> 联系电话</th>
            <th> 门店面积</th>
            <th> 到期时间</th>
            <th> 注册时间</th>
            <th> 操作</th>
        </tr>
        </thead>
        <tbody>
        <#if pageInfo?? && pageInfo.list??>
            <#import "../rownum.ftl" as q>
            <#list pageInfo.list as branch>
            <tr>
                <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=branch_index /></td>
                <td> ${branch.branchcode!''}</td>
                <td> ${branch.branchname!''}</td>
                <td> ${branch.dutyperson!''}</td>
                <td> ${branch.dutypersonnum!''}</td>
                <td> ${branch.aresize!''}</td>
                <td> ${branch.expirestime!''}</td>
                <td> ${branch.createtime!''}</td>
                <td>
                    <a href="javascript:void(0)" onclick="showPayRecord('${branch.branchcode!''}','${shopInfo.shopcode!''}')"
                       class="primary-link">购买记录
                    </a>

                </td>
            </tr>
            </#list>
        <#else>
        <tr>
            <td valign="top" colspan="9" class="dataTables_empty">暂无数据</td>
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