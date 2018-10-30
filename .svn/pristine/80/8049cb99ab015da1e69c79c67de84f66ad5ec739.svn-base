<@override name="jstext">
<script>
    zlf.common.initSearchUrl('${ctxPath}/renew/order/queryOrderInfoList.action');

    $(function(){
        zlf.common.search();
    });
    function deleteOrder(billcode) {
        ConfirmMsg("您确定要删除该订单吗？", function (yes) {
            if (yes) {
                var url = '${ctxPath}/renew/order/deleteOrderInfo.action';
                var params = {
                    billcode:billcode
                };
                ajaxSyncInSameDomain(url, params, function (result) {
                    var json = eval(result);
                    if (json.success) {
                        AlertMsg(result.data, function () {
                            zlf.common.search()
                        });
                    } else {
                        AlertMsg(result.errorMsg, function () {
                            zlf.common.search()
                        });
                    }
                });
            }
        })}

        function renewProcess() {
            window.location ="${ctxPath}/renew/order/productManage.action";
        }

        function restQuery(){
            $('#billcode').val("");
            $('#productcode').val("");
            $('#status').val("");
            zlf.common.search();
        }
</script>
</@override>
<@override name="right">
<div class="panel panel-info">
    <div class="panel-heading">筛选</div>
    <div class="panel-body">
        <div class="portlet-body form">
            <form action="#" id="searchForm" class="form-horizontal" method="post">
                <div class="form-body">
                    <div class="row">
                        <div class="col-md-3 col-sm-3">
                            <div class="form-group">
                                <label class="control-label col-md-4">订单编号</label>
                                <div class="col-md-7">
                                    <input type="text" id="billcode" name="billcode" class="form-control" value="${RequestParameters.billcode!''}">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-3">
                            <div class="form-group">
                                <label class="control-label col-md-4">产品名称</label>
                                <div class="col-md-7">
                                    <select style="width: 120px" class="form-control" name="productcode" id="productcode" value="${RequestParameters.productcode!''}">
                                        <option value="">全部产品</option>
                                        <#if productList??>
                                            <#list productList as product>
                                                <option value="${product.componentcode}">${product.componentname}</option>
                                            </#list>
                                        </#if>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-3">
                            <div class="form-group">
                                <label class="control-label col-md-4">订单状态</label>
                                <div class="col-md-7">
                                    <select style="width: 120px" class="form-control" name="status" id="status" value="${RequestParameters.status!''}">
                                        <option value="">全部</option>
                                        <option value="0">待支付</option>
                                        <option value="1">已完成</option>
                                        <option value="2">已失效</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-1 col-sm-1">
                            <button type="button" class="btn btn-default " onclick="zlf.common.search()">
                                <i class="fa fa-search"></i> 搜索
                            </button>
                        </div>
                        <div class="col-md-1 col-sm-1">
                            <button type="button" class="btn btn-default " onclick="restQuery()">重置
                            </button>
                        </div>
                    </div>
                </div>
            </form>
            <div>
                <button type="button" class="btn btn-primary" onclick="renewProcess()">续费</button>
            </div>
        </div>
    </div>
</div>
<div class="panel panel-default">
    <div class="panel-body table-responsive zl-content-container">
        <#include "order_manage_table.ftl" />
    </div>
</div>
</@override>
<@override name="window">
</@override>
<@extends name="../base_main.ftl"/>