<@override name="jsfile">
    <script src="../assets/layer/layer.js" type="text/javascript"></script>
    <script src="../js/jquery.form.js" type="text/javascript"></script>
</@override>
<@override name="cssfile">
</@override>
<@override name="jstext">
<script>
    zlf.common.initSearchUrl('${ctxPath}/serviceBill/serviceBillTable.action');
    $(function () {
        zlf.common.search();
    })
    
    function toSaveServiceBill() {
        window.location.href = '${ctxPath}/serviceBill/toSaveServiceBill.action'
    }
     // 重置
    function queryReset() {
        $("#servicebillstatus").val("");
        $("#servicebillcode").val("");
        $("#showtime").val("");
        $("#starttime").val("");
        $("#endtime").val("");
        zlf.common.search();
    }

    // 跳转至详情页
    function toServiceDetail(servicebillcode) {
        window.location.href =  '${ctxPath}/serviceBill/toServiceBillDetail.action?servicebillcode=' + servicebillcode;
    }

    /**
     * 确认付款
     */
    function comfirmPayment(servicebillcode){
        window.location.href =  '${ctxPath}/serviceBill/findPaymentDetail.action?servicebillcode=' + servicebillcode;
    }
    /**
     * 取消返修
     * */
    function cancelService(servicebillcode){
        ConfirmMsg("确定要取消返修？", function (yes) {
            if (yes) {
                var url = '${ctxPath}/serviceBill/cancelService.action';
                var params = {
                    servicebillcode:servicebillcode
                }
                ajaxSyncInSameDomain(url, params, function (result) {
                    if (result) {
                        AlertMsg(result, function () {
                            zlf.common.search();
                        });
                    } else {
                        AlertMsg("取消成功!", function () {
                            zlf.common.search();
                        });
                    }
                });
            }
        });
    }

    function openConfirmReceiptWindow(servicebillcode ,companycourier) {
        $("#confirm_receipt").find("input[name=servicebillcode]").val(servicebillcode);
        $("#confirm_receipt").find("#companycourier").val(companycourier);
        $("#confirm_receipt").modal("show");
    }

    function saveConfirmReceipt() {
        var formtFlag = false;
        // 校验文件是否上传
        $("#confirmReceiptFrom").find("input[name=file]").each(function () {
            var filePath = $(this).val();
            var fileType = getFileType(filePath);
            //console.log(fileType);
            //判断上传的附件是否为图片
            if("jpg" != fileType && "jpeg" != fileType  && "png" != fileType) {
                $("#image").val("");
                AlertMsg("请上传JPG,JPEG,PNG格式的图片");
                formtFlag = false;
                return false;
            }
            //获取附件大小（单位：KB）
            var fileSize = this.files[0].size / 1024;
            if(fileSize > 5120) {
                AlertMsg("图片大小不能超过5MB");
                formtFlag = false;
                return false;
            }
            formtFlag = true;
        });
        if (!formtFlag){
            return false;
        }
        var companybillremake = $("#companybillremake").val();
        if(companybillremake.length > 200){
            AlertMsg("请输入200字以内的备注");
        }
        var ajax_option={
            success:function(data){
                var result = eval(data);
                if (result.success) {
                    AlertMsg(result.data, function () {
                        window.location.href = '${ctxPath}/serviceBill/toServiceBillManage.action'
                    });
                }
            }
        };
        $('#confirmReceiptFrom').ajaxSubmit(ajax_option);
    }

    function getFileType(filePath) {
        var startIndex = filePath.lastIndexOf(".");
        if(startIndex != -1)
            return filePath.substring(startIndex + 1, filePath.length).toLowerCase();
        else return "";
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
                                <label class="control-label col-md-3">返修单号</label>
                                <div class="col-md-9">
                                    <input type="text" id="servicebillcode" name="servicebillcode"
                                           value="${RequestParameters.servicebillcode!''}" class="form-control"
                                           placeholder="请输入返修单号">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label col-md-3">返修状态</label>
                                <div class="col-md-9">
                                   <select id="servicebillstatus" name="servicebillstatus" value="" class="form-control">
                                       <option value="">全部</option>
                                       <option value="0">待工厂收货</option>
                                       <option value="1">检测中</option>
                                       <option value="2">待付款</option>
                                       <option value="3">待收款</option>
                                       <option value="4">维修中</option>
                                       <option value="5">待工厂发货</option>
                                       <option value="6">待收货</option>
                                       <option value="7">已完成</option>
                                   </select>
                                </div>
                            </div>
                        </div>
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
                            <button type="button" class="btn btn-default " onclick="window.location.href = '${ctxPath}/serviceBill/toServiceBillManage.action'">
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
        <a class="btn btn-default" href="javascript:toSaveServiceBill()"><i
                class="fa fa-plus"></i> 新增</a>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body table-responsive zl-content-container">
        <#include "service_bill_table.ftl" />
    </div>
</div>

</@override>
<@override name="window">
        <div id="confirm_receipt" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
            <div class="modal-dialog" style="width: 600px">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4>确认收货</h4>
                    </div>
                    <form action="${ctxPath}/serviceBill/confirmReceipt.action" method="post"  enctype="multipart/form-data" class="form-horizontal" role="form" id="confirmReceiptFrom">
                        <input hidden name="servicebillcode" id="servicebillcode" value=""/>
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="control-label col-md-4">工厂发货快递单号</label>
                                <div class="col-md-8">
                                    <input disabled type="text" class="form-control"
                                           name="companycourier" id="companycourier" value="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4"><span style="color: red;">*</span>收货凭证</label>
                                <div class="col-md-8">
                                    <div class="col-md-8">
                                        <input type="file" hidden name="file" id="file" value="" accept="image/png, image/jpeg, image/gif, image/jpg"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4">备注</label>
                                <div class="col-md-8">
                                    <input placeholder="最多输入200字符" type="text" class="form-control"
                                           name="companybillremake" id="companybillremake" value="">
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="modal-footer">
                        <a href="#" class="btn btn-primary" onclick="saveConfirmReceipt()">确定</a>
                        <a href="#" class="btn btn-default" data-dismiss="modal" aria-hidden="true">取消</a>
                    </div>
                </div>
            </div>
        </div>
</@override>
<@extends name="../base_main.ftl"/>