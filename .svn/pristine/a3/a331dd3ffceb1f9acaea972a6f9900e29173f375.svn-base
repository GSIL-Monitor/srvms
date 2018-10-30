<#include "../default_cfg.ftl"/>
<div class="panel panel-default">
        <table class="table table-hover"  align="center">
            <thead>
            <tr>
                <th width="48px"> 序号</th>
                <th> 标题</th>
                <th width="150"> 创建时间</th>
                <th width="150"> 操作</th>
            </tr>
            </thead>
            <tbody>
                <#if pageInfo?? && pageInfo.list??>
                    <#import "../rownum.ftl" as q>
                    <#list pageInfo.list as message>
                    <tr>
                        <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=message_index /></td>
                        <td width="350px" title="${message.title!''}"><span>【系统公告】</span>${message.title!''}</td>
                        <td> ${message.createtime!''}</td>
                        <td>
                            <a href="${ctxPath}/message/queryMessageDetail.action?id=${message.id}"
                               class="btn btn-default  btn-sm tooltips"
                               data-original-title="详情">详情
                            </a>
                        </td>
                    </tr>
                    </#list>
                <#else>
                <tr>
                    <td valign="top" colspan="3" class="dataTables_empty">暂无数据</td>
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
<@override name="window">
<div id="user_modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" style="width: 600px">
        <div class="modal-content">
        </div>
    </div>
</@override>
