<@override name="jstext">
<script>
    zlf.common.initSearchUrl('${ctxPath}/branchRenew/showOrderTableToView.action');

    function delOrder(id) {
        ConfirmMsg("确定要删除此订单？", function (yes) {
            if (yes) {
                var url = '${ctxPath}/branchRenew/deleteOrder.action';
                var params = {
                    orderid: id
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
        });
    }
    //打开订单详情弹框
    function openRenewDetail(id) {
        $('#user_modal').modal({
            remote: "${ctxPath}/branchRenew/toRenewDetail.action?orderid=" + id
        })
        $("#user_modal").on("hidden.bs.modal", function () {
            $(this).removeData("bs.modal");
            $(this).find('.modal-content').empty()
        });
    }
    
    function queryReset() {
        $("#orderid").val("");
        $("#paystatus").val("");
        zlf.common.search();
    }

    function payRenew(orderid) {
        // 支付订单
        $("#orderidRenew").val(orderid);
        $("#payForm").submit();
    }

    $(function () {
        zlf.common.search();
    })
</script>
</@override>
<@override name="right">
<div class="panel panel-info">
    <form action="${ctxPath}/branchRenew/rePayRenew.action" method="post" id="payForm">
        <input type="text" hidden="hidden" name="orderid" id = "orderidRenew" />
    </form>
    <div class="panel-heading">筛选</div>
    <div class="panel-body">
        <form action="#" method="post" class="form-horizontal" role="form" id="searchForm">
            <div class="form-body">
                <div class="row">
                    <div class="col-md-10">
                        <div class="form-group">
                            <div class="row"  style="padding: 0px">
                                <table>
                                            <input type="text" id="shopcode" name="shopcode"
                                                   value="${RequestParameters.shopcode!''}" hidden="hidden"
                                                   placeholder="">
                                    <tr>
                                        <label class="control-label col-md-1">订单编号</label>
                                        <div class="col-md-2">
                                            <input type="text" id="orderid" name="orderid"
                                                   value="${RequestParameters.orderid!''}" class="form-control"
                                                   placeholder="">
                                        </div>
                                    </tr>
                                    <tr>
                                        <label class="control-label col-md-1">订单状态</label>
                                        <div class="col-md-2">
                                            <select class="form-control" name="paystatus" id="paystatus"  val="">
                                                <option value="">请选择</option>
                                                <option value="0">待支付</option>
                                                <option value="5">已完成</option>
                                                <option value="8">已失效</option>
                                            </select>
                                        </div>
                                    </tr>
                                    <tr>
                                        <label class="control-label col-md-1">下单日期</label>

                                        <div class="col-md-2">
                                            <input class="form-control daterange daterange-time active" placeholder="选择日期"
                                                   id="showtime" name="showtime" readonly value="">
                                            <input name="starttime" id="starttime" type="hidden" value="">
                                            <input name="endtime" id="endtime" type="hidden" value="">
                                        </div>
                                    </tr>
                                </table>
                             </div>

                        </div>
                    </div>
                    <div class="col-md-1">
                        <button type="button" class="btn btn-default " onclick="zlf.common.search()">
                            <i class="fa fa-search"></i> 搜索
                        </button>
                    </div>
                    <div class="col-md-1">
                        <button type="button" class="btn btn-default " onclick="queryReset()">
                            <i class="fa"></i> 重置
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body table-responsive zl-content-container">
        <#include "renew_table_detail.ftl" />
    </div>
</div>
</@override>
<@override name="window">
<div id="user_modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false" >
    <div class="modal-dialog" style="width: 800px">
        <div class="modal-content">
        </div>
    </div>
</div>
</@override>
<@extends name="../base_main.ftl" />