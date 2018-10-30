<#include "../default_cfg.ftl"/>
<div class="table-scrollable">
    <table class="table table-hover table-bordered">
        <thead>
        <tr>
            <th width="48px"> 序号</th>
            <th> 通知标题</th>
            <th> 通知对象</th>
            <th> 发送状态</th>
            <th> 发送时间</th>
            <th> 创建时间</th>
            <th> 操作</th>
        </tr>
        </thead>
        <tbody>
        <#if pageInfo?? && pageInfo.list??>
            <#import "../rownum.ftl" as q>
            <#list pageInfo.list as message>
            <tr class="odd gradeX">
                <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=message_index /></td>
                <td> ${message.title!''}</td>
                <td>
                    <#if (message.sendobj!'') == '0'>
                        服务商
                        <#else >
                        商户
                    </#if>
                </td>
                <td>
                     <#if (message.status!'') == '0'>
                         未发送
                     <#else >
                         已发送
                     </#if>

                </td>
                <td> ${message.sendtime!''}</td>
                <td> ${message.createtime!''}</td>
                <td>
                <#-- <a href="?shopcode=${shop.shopcode}">-->
                    <a href="${ctxPath}/adminMesssage/queryMessageDetail.action?id=${message.id}">
                        详情
                    </a>

                    <#if (message.status!'') == '0'>
                        <a href="${ctxPath}/adminMesssage/toUpdateMessage.action?id=${message.id}">
                            编辑
                        </a>
                        <a href="javascript:void(0)" onclick="sendMessage(${message.id});">
                            发送
                        </a>
                        <a href="javascript:void(0)" onclick="delMessage(${message.id});">
                            删除
                        </a>
                    </#if>
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