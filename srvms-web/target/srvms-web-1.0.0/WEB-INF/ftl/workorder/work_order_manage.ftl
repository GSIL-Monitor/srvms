<@override name="jstext">
<script>
    zlf.common.initSearchUrl('${ctxPath}/workorder/workOrderTable.action');
    $(function () {
        zlf.common.search();
    })

     // 重置
    function queryReset() {
        $("#workordercode").val("");
        $("#componentcode").val("");
        $("#workorderstatus").val("");
        $("#showtime").val("");
        $("#starttime").val("");
        $("#endtime").val("");
        zlf.common.search();
    }

    // 跳转新增页面
    function toSaveWorkOrder() {
        var url = '${ctxPath}/workorder/toSaveWorkOrder.action'
        window.location.href=url;
    }
    
    // 跳转详情页面
    function toWorkOrderDetail(workordercode) {
        var url = '${ctxPath}/workorder/queryWorkOrderDetail.action?workordercode=' + workordercode
        window.location.href=url;
    }
    function toServerHandle(workordercode ,type) {
        var url = '${ctxPath}/workorder/toServerHandle.action?workordercode=' + workordercode + '&type='+ type
        window.location.href=url;
    }
    
    function finishService(workordercode) {
        ConfirmMsg("您确定该工单待返修的设备已经返修完成？", function (yes) {
            if (yes) {
                var url = '${ctxPath}/workorder/finishService.action';
                var params = {
                    workordercode:workordercode,
                    workorderstatus:'9'
                };
                ajaxSyncInSameDomain(url, params, function (result) {
                    if (result) {
                        AlertMsg(result, function () {
                            zlf.common.search();
                        });
                    } else {
                        AlertMsg("完成返修!", function () {
                            zlf.common.search();
                        });
                    }
                });
            }
        });
    }
    
    function deleteWorkOrder(workordercode) {
        ConfirmMsg("确定要删除此工单？", function (yes) {
            if (yes) {
                var url = '${ctxPath}/workorder/deleteWorkOrder.action';
                var params = {
                    workordercode:workordercode
                };
                ajaxSyncInSameDomain(url, params, function (result) {
                    if (result) {
                        AlertMsg(result, function () {
                            zlf.common.search();
                        });
                    } else {
                        AlertMsg("删除成功!", function () {
                            zlf.common.search();
                        });
                    }
                });
            }
        });
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
                    <div class="col-md-12">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label col-md-3">工单编号</label>
                                <div class="col-md-9">
                                    <input type="text" id="workordercode" name="workordercode"
                                           value="${RequestParameters.workordercode!''}" class="form-control"
                                           placeholder="请输入工单编号">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label col-md-3">工单类型</label>
                                <div class="col-md-9">
                                    <select id="workordertype" name="workordertype" value="" class="form-control">
                                        <option value="">全部</option>
                                        <option value="0">软件工单</option>
                                        <option value="1">硬件工单</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                    <label class="control-label col-md-3">处理状态</label>
                                <div class="col-md-9">
                                    <select class="form-control" id="workorderstatus" name="workorderstatus" value="">
                                        <option value="">全部</option>
                                        <option value="0">待处理</option>
                                        <option value="1">处理中</option>
                                        <option value="2">运营待处理</option>
                                        <option value="3,4">运营处理中</option>
                                        <option value="5">待返修</option>
                                        <option value="9">返修完成</option>
                                        <option value="6,7,8">已完成</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                   <div class="col-md-12">
                       <div class="col-md-4">
                           <div class="form-group">
                               <label class="control-label col-md-3">创建时间</label>
                               <div class="col-md-9">
                                   <input class="form-control daterange daterange-time active" placeholder="选择日期"
                                          id="showtime" name="showtime" readonly value="">
                                   <input name="starttime" id="starttime" type="hidden" value="">
                                   <input name="endtime" id="endtime" type="hidden" value="">
                               </div>
                           </div>
                       </div>
                        <div class="col-md-4">
                            <button type="button" class="btn btn-default " onclick="zlf.common.search()">
                                <i class="fa fa-search"></i> 搜索
                            </button>
                            <button type="button" class="btn btn-default " onclick="window.location.href = '${ctxPath}/workorder/workOrderManage.action'">
                                <i class="fa"></i> 重置
                            </button>
                        </div>
                   </div>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body">
        <a class="btn btn-default" href="javascript:toSaveWorkOrder()"><i
                class="fa fa-plus"></i> 新增</a>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body table-responsive zl-content-container">
        <#include "work_order_table.ftl" />
    </div>
</div>

</@override>
<@override name="window">
<div id="user_modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" style="width: 600px">
        <div class="modal-content">
        </div>
    </div>
</div>
</@override>
<@extends name="../base_main.ftl"/>