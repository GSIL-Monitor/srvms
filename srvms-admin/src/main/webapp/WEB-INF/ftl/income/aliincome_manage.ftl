<#include "../default_cfg.ftl"/>
<div class="table-scrollable">
    <table class="table table-hover table-bordered">
        <thead>
        <tr>
            <th style="width:48px;"> 序号</th>
            <th> 结算月份</th>
            <th> 服务商名称</th>
            <th> 收单方式</th>
            <th> 有效收单金额（元）</th>
            <th> 笔数有效（笔）</th>
            <th> 有效退款金额（元）</th>
            <th>有效退款笔数（笔）（元）</th>
            <th> 有效收益基数（元）</th>
            <th> 有效交易净笔数（笔）</th>
            <th>收益比例（%）</th>
            <th>收益金额（元）</th>
            <th>结算状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <#if pageInfo?? && pageInfo.list??>
            <#import "../rownum.ftl" as q>
            <#list pageInfo.list as user>
            <tr class="odd gradeX">
                <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=user_index /></td>
                <td>${user.month!''}</td>
                <td>${user.servername!''}</td>
                <td>${user.paymethod!''}</td>
                <td>${user.relpayamount!""}</td>
                <td>${user.Transactionno!""}</td>
                <td>
                    ${user.returnamount!""}
                </td>
                <td>${user.relpayamount!""}</td>
                <td>${user.Transactionno!""}</td>
                <td>${user.settlerate!""}</td>
                <td>${user.shouldpayamount!""}</td>
                <td>${user.settlestatus!""}</td>
                <td>
                    <a href="javascript:undoPassword(${user.id});"
                       class="btn btn-default btn-sm tooltips" data-original-title="重置密码">
                        <i class="fa fa-refresh"></i>
                    </a>
                    <a href="javascript:goto('${ctxPath}/admin/user/toUpdate.action?id=${user.id}','searchForm');"
                       class="btn btn-default  btn-sm tooltips" data-original-title="修改">
                        <i class="fa fa-edit"></i>
                    </a>
                    <a href="javascript:delUser(${user.id});"
                       class="btn btn-default  btn-sm tooltips" data-original-title="删除">
                        <i class="fa fa-times"></i>
                    </a>
                </td>
            </tr>
            </#list>
        <#else>
        <tr>
            <td valign="top" colspan="10" class="dataTables_empty">暂无数据</td>
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
