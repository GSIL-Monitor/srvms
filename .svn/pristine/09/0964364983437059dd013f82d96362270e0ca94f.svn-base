<@override name="jstext">
<script>
    zlf.common.initSearchUrl('${ctxPath}/adminMesssage/queryAdminMessage.action');
    $(function () {
        zlf.common.search();
    });

    function sendMessage(id) {
        var url = '${ctxPath}/adminMesssage/sendMessage.action';
        var params = {
            id:id
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                AlertMsg("发送成功!", function () {
                    zlf.common.search();
                });
            }
        })

    }

    function delMessage(id) {

        var url = '${ctxPath}/adminMesssage/delMessage.action';
        var params = {
            id:id
        };

        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                AlertMsg("删除成功!", function () {
                    zlf.common.search();
                });
            }
        })

    }
</script>
</@override>
<@override name="right">
<div class="panel panel-info">
    <div class="panel-heading">筛选</div>
    <div class="panel-body">
        <form action="#" method="post" class="form-horizontal" role="form" id="searchForm">
            <div class="form-body">
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="control-label col-md-3">创建日期</label>
                            <div class="col-md-9">
                                <input class="form-control daterange daterange-time active" placeholder="选择日期"
                                       readonly="readonly" id="showtime" name="showtime" value="" >
                                <input name="starttime" id="starttime" type="hidden" value="">
                                <input name="endtime" id="endtime" type="hidden" value="">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-1">
                        <button type="button" class="btn btn-default " onclick="zlf.common.search()">
                            <i class="fa fa-search"></i> 搜索
                        </button>
                    </div>
                    <div class="col-md-1">
                        <button type="button" class="btn btn-default " onclick="window.location.href = '${ctxPath}/adminMesssage/toAdminMessage.action'">
                            <i class="fa"></i> 重置
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body">
        <a class="btn btn-default" href="${ctxPath}/adminMesssage/toAdminMessageAdd.action"><i
                class="fa fa-plus"></i>新增通知</a>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body table-responsive zl-content-container">
        <#include "system_message_table.ftl" />
    </div>
</div>
</@override>

<@extends name="../base_main.ftl"/>