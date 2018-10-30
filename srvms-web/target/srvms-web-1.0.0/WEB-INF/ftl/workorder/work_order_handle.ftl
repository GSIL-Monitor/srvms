<#include "../default_cfg.ftl"/>
<@override name="jsfile">
     <script src="../js/jquery.form.js" type="text/javascript"></script>
</@override>
<@override name="cssfile">
</@override>
<@override name="jstext">
</@override>
<@override name="right">
<form action="${ctxPath}/workorder/saveServerHandleInfo.action" method="post" class="form-horizontal" role="form" id="submitForm">
        <input hidden type="text" id="workordercode" name="workordercode" value="${workordercode}" />
    <div class="panel panel-default">
        <div class="col-md-9">
            <label class="control-label col-md-3">维修工单-立即处理</label>
        </div>
    </div>
    <div class="panel-body">
        <div class="form-body">
            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label col-md-3"><span style="color: red;">*</span>处理方式</label>
                    <div class="col-md-9">
                        <div class="col-md-12" id="workordertype">
                            <label class="radio-inline">
                                <input type="radio" name="resultcode" id="soft" value="0" checked> 自行处理
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="resultcode" id="hardware"  value="1"> 反馈上级
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label col-md-3"><span style="color: red;">*</span>反馈描述</label>
                    <div class="col-md-9">
                        <input  placeholder="" type="text" class="form-control" name="serverdescribe" id="serverdescribe" value="">
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group col-sm-12">
            <input type="button" value="提交" class="btn btn-primary col-lg-1" onclick="saveServerHandle()">
            <input type="button" onclick="returnWorkOrder()" style="margin-left:10px;" value="返回"
                   class="btn btn-default">
        </div>
    </div>
</form>
<script>
    function returnWorkOrder() {
        window.location.href = '${ctxPath}/workorder/workOrderManage.action';
    }

    function saveServerHandle() {
        var serverdescribe = $("#serverdescribe").val();
        if(!serverdescribe){
            AlertMsg("请完善工单反馈内容描述！");
            return;
        }
        if(serverdescribe.length > 500){
            AlertMsg("工单反馈内容描述不能超过500字！");
            return;
        }
        var ajax_option={
            success:function(data){
                var result = eval(data);
                if (result.success) {
                    AlertMsg(result.data, function () {
                        window.location.href = '${ctxPath}/workorder/workOrderManage.action'
                    });
                }
            }
        };
        $('#submitForm').ajaxSubmit(ajax_option);
    }

</script>
</@override>
<@override name="window">

</@override>
<@extends name="../base_main.ftl"/>