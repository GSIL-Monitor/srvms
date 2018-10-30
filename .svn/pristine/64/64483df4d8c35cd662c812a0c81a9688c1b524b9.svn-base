<@override name="jstext">
<script>
    zlf.common.initSearchUrl('${ctxPath}/equipmonitor/manage.action');

    //跳转添加弹窗
    function editEquipStaus(deviceuniquecode, shopcode, errortype, repairstate) {
        $('#repair_update form')[0].reset();
        $('#repair_update [name="deviceuniquecode"]').val(deviceuniquecode);
        $('#repair_update [name="errortype"]').val(errortype);
        $('#repair_update [name="shopcode"]').val(shopcode);
        $('#repair_update [name="repairstate"]').val(repairstate);
        $('#repair_update [name="oldstatus"]').val(repairstate);
        $('#repair_update').modal('show');
    }

    //添加 维修记录
    function insertRepairRecord() {
        var deviceuniquecode = $('#repair_update [name="deviceuniquecode"]').val();
        var errortype = $('#repair_update [name="errortype"]').val();
        var shopcode = $('#repair_update [name="shopcode"]').val();
        var remark = $('#remark').val();
        var repairstate = $('#repair_update [name="repairstate"]').val();
        var oldstatus = $('#repair_update [name="oldstatus"]').val();

        if (repairstate == '') {
            AlertMsg('请选择处理状态！');
            return;
        }

        var url = '${ctxPath}/equipmonitor/updateShopRepairStatus.action';
        var params = {
            deviceuniquecode: deviceuniquecode,
            errortype: errortype,
            shopcode: shopcode,
            remark: remark,
            repairstate: repairstate,
            oldstatus: oldstatus
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                $('#repair_update').modal('hide');
                zlf.common.search();
            }
        })
    }

    //报错记录详情
    function details(deviceuniquecode, errortypecode, shopcode) {
        window.location.href = '${ctxPath}/equipmonitor/details.action?shopcode=' + shopcode + '&deviceuniquecode=' + deviceuniquecode + '&errortype=' + errortypecode;
    }

    $(function () {
        zlf.common.search();
    })
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
                            <label class="control-label col-md-3">设备型号</label>

                            <div class="col-md-7">
                                <input type="text" id="systemmodel" name="systemmodel"
                                       value="${RequestParameters.systemmodel!''}" class="form-control"
                                       placeholder="请输入设备型号进行查询">
                            </div>
                        </div>

                    </div>

                    <div class="col-md-4">

                        <div class="form-group">
                            <label class="control-label col-md-3">设备号</label>

                            <div class="col-md-7">
                                <input type="text" id="deviceuniquecode" name="deviceuniquecode"
                                       value="${RequestParameters.deviceuniquecode!''}" class="form-control"
                                       placeholder="请输入设备号进行查询">
                            </div>
                        </div>

                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-default " onclick="zlf.common.search()">
                            <i class="fa fa-search"></i> 搜索
                        </button>

                        <button type="button" class="btn btn-default "
                                data-toggle="senior-search"
                                toggle-for="#senior-search">
                            <i class="fa fa-ellipsis-horizontal"></i> 高级搜索
                            <i class="fa fa-angle-down"></i>
                        </button>

                    </div>
                </div>
                <div class="row senior-search">
                    <div class="row ">
                        <div class="col-md-4">

                            <div class="form-group">
                                <label class="control-label col-md-3">报错时间</label>

                                <div class="col-md-7">
                                    <input class="form-control daterange daterange-time" placeholder="选择日期"
                                           readonly="readonly" id="showtime" name="expirationdate"
                                           value=""/>
                                    <input name="starttime" id="starttime" type="hidden"
                                           value="">
                                    <input name="endtime" id="endtime" type="hidden"
                                           value="">
                                </div>
                            </div>

                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label col-md-3">出错部件</label>

                                <div class="col-md-7">

                                    <select class="form-control" name="errortype" id="errortype">
                                        <option value="">请选择</option>
                                        <option value="触摸屏">触摸屏</option>
                                        <option value="摄像头">摄像头</option>
                                        <option value="4G模块">4G模块</option>
                                        <option value="网卡">网卡</option>
                                        <option value="重力感应">重力感应</option>
                                        <option value="声卡">声卡</option>
                                        <option value="WIFI蓝牙">WIFI蓝牙</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label col-md-3">设备类型</label>

                                <div class="col-md-7">

                                    <select class="form-control" name="devicetype" id="devicetype">
                                        <option value="">请选择</option>
                                        <option value="1">收银机</option>
                                        <option value="2">广告机</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label col-md-3">处理状态</label>

                                <div class="col-md-7">

                                    <select class="form-control" name="repairstate" id="repairstate">
                                        <option value="">请选择</option>
                                        <option value="1">待处理</option>
                                        <option value="2">处理中</option>
                                        <option value="3">已处理</option>
                                        <option value="0">暂不处理</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </form>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body table-responsive zl-content-container">
        <#include "equip_manage_detail.ftl"/>
    </div>
</div>
</@override>
<@override name="window">
<div id="repair_update" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" style="width: 600px">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                <h3>改变状态</h3>
            </div>
            <div class="modal-body">
                <form action="#" class="form-horizontal" method="post" id="addForm">
                    <div class="form-body">
                        <div class="form-group">
                            <label class="control-label col-md-3">操作人</label>

                            <div class="col-md-7">
                                <div class="form-control-static"> <#if analysis?? >${analysis.loginuserfullname}</#if></div>
                            </div>
                            <input name="deviceuniquecode" type="hidden" value="">
                            <input name="shopcode" type="hidden" value="">
                            <input name="errortype" type="hidden" value="">
                            <input name="oldstatus" type="hidden" value="">
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3">处理状态
                            </label>

                            <div class="col-md-7">
                                <select class="form-control" name="repairstate">
                                    <option value="">请选择</option>
                                    <option value="1">待处理</option>
                                    <option value="2">处理中</option>
                                    <option value="3">已处理</option>
                                    <option value="0">暂不处理</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3">备注</label>

                            <div class="col-md-7">

                                            <textarea id="remark" name="remark" style="height:80px;resize: none;"
                                                      class="form-control"></textarea>
                            </div>
                        </div>

                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <a href="#" class="btn btn-primary" onclick="insertRepairRecord()">确定</a>
                <a href="#" class="btn btn-default" data-dismiss="modal" aria-hidden="true">关闭</a>
            </div>
        </div>
    </div>
</div>
</@override>
<@extends name="../base_main.ftl"/>