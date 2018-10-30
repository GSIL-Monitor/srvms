<@override name="jstext">
<script>
    function search() {
        $("#searchForm").attr('action', UrlHelper.getSearchUrl('${ctxPath}/admin/feedback/manage.action'));
        $("#searchForm").submit();
    }

    function resetView(){
        $("#starttime").val("");
        $("#endtime").val("");
        $("#keyword").val("");
        $("#searchForm").attr('action', UrlHelper.getSearchUrl('${ctxPath}/admin/feedback/manage.action'));
        $("#searchForm").submit();
    }


</script>
</@override>
<@override name="right">
<div class="panel panel-info">
    <div class="panel-heading">筛选</div>
    <div class="panel-body">
                <form action="#" id="searchForm" class="form-horizontal" method="post">
                    <div class="form-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label col-md-3">关键字</label>

                                    <div class="col-md-9">
                                        <input type="text" id="keyword" name="keyword"
                                               value="${RequestParameters.keyword!''}" class="form-control"
                                               placeholder="可输入标题/反馈用户进行查询">
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label col-md-3">日期</label>

                                    <div class="input-group">
                                        <input type="text" name="starttime" id="starttime"
                                               placeholder="选择日期" value="${RequestParameters.starttime!''}"
                                               readonly="readonly" class="datetimepicker form-control"
                                               date-format="Y-m-d"
                                               style="padding-left:12px;z-index: 0;">
                                        <span class="input-group-addon">至</span>

                                        <input type="text" name="endtime" id="endtime"
                                               placeholder="选择日期" value="${RequestParameters.endtime!''}"
                                               readonly="readonly" class="datetimepicker form-control"
                                               date-format="Y-m-d"
                                               style="padding-left:12px;z-index: 8;">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default " onclick="search()">
                                    <i class="fa fa-search"></i> 搜索
                                </button>
                                <button type="button" class="btn btn-default " onclick="resetView()">
                                    <i class="fa"></i> 重置
                                </button>
                            </div>
                        </div>
                </form>
    </div>
</div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th width="48px"> 序号</th>
                            <th> 标题</th>
                            <th> 反馈服务商ID</th>
                            <th> 反馈服务商名称</th>
                            <th> 反馈用户</th>
                            <th> 反馈时间</th>
                        </tr>
                        </thead>
                        <tbody>
                            <#if pageInfo?? && pageInfo.list??>
                                <#import "../rownum.ftl" as q>
                                <#list pageInfo.list as feedback>
                                <tr>
                                    <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=feedback_index /></td>
                                    <td class="center">
                                            <a href="javascript:goto('${ctxPath}/admin/feedback/feedbackToView.action?id=${feedback.id}','searchForm');"
                                               class="primary-link">${feedback.title!''}
                                            </a>
                                    </td>
                                    <td> ${feedback.servercode!''}</td>
                                    <td> ${feedback.servername!''}</td>
                                    <td> ${feedback.submitter!''}</td>
                                    <td> ${feedback.committime!''}</td>
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
                        <form id="feedback_list_form" method="post">
                            <#import "../pager.ftl" as q>
			                    <@q.pager page=pageInfo.page pageSize=pageInfo.pageSize totalRecords=pageInfo.totalRecords toURL="${ctxPath}/admin/feedback/manage.action" pageid="feedback_list_form"/>
                        </form>
                    </div>
                </div>
            </#if>

</@override>
<@override name="window">
    <#include "../shop/choose-shop.ftl"/>
</@override>
<@extends name="../base_main.ftl"/>