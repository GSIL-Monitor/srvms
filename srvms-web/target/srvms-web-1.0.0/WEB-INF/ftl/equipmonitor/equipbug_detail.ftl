<@override name="jstext">
<script>

    zlf.common.initSearchUrl('${ctxPath}/equipmonitor/pagedetails.action?errortypeid='+'${analysis.errortypeid!''}'+'&deviceuniquecode='+'${analysis.deviceuniquecode!''}'+'&shopcode='+'${analysis.shopcode!''}');
    //跳转添加弹窗
    function showModel(event,repairstate) {
        $('#repairstate').val(repairstate);
        $('#oldstatus').val(repairstate);
        $('#repair_update').modal('show');
        event.preventDefault();
    }

    function insertRepairRecord() {
        var deviceuniquecode = $('#deviceuniquecode').val();
        var errortype = $('#errortype').val();
        var shopcode = $('#shopcode').val();
        var remark = $('#remark').val();
        var repairstate = $('#repairstate').val();
        var oldstatus = $('#oldstatus').val();

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
                window.location.reload();
            }
        })
    }

    function redirect() {
        window.location.href = '${ctxPath}/equipmonitor/toManage.action';
    }
    $(function () {
        zlf.common.search();
    })
</script>
</@override>
<@override name="right">
<form action="#" method="post" class="form-horizontal" role="form" id="addForm">
    <div class="panel panel-info">
        <div class="panel-body">
            <div class="row" style="font-size: 18px;padding: 5px 0;margin-bottom: 10px">
                <div class="col-md-4" style="font-weight: 600">处理状态：
                    <#if analysis.repairstate == 0>
                        <span style="color:red">暂不处理</span>
                    <#elseif analysis.repairstate == 1>
                        <span style="color:red">待处理</span>
                    <#elseif analysis.repairstate == 2>
                        <span style="color:red">处理中</span>
                    <#elseif analysis.repairstate == 3>
                        <span style="color:red">已处理</span>
                    </#if>
                    <button style="margin-left: 15px;font-size: 12px"
                            onclick="showModel(event,'${analysis.repairstate!''}')">
                        更改
                    </button>
                </div>
            </div>
            <div class="form-body">
                <div class="form-group">
                    <label class="control-label col-md-1">设备型号 :
                    </label>

                    <div class="col-md-3">
                        <div class="form-control-static">${analysis.systemmodel!''}</div>
                        <input id="deviceuniquecode" name="deviceuniquecode" type="hidden"
                               value="${analysis.deviceuniquecode!''}">
                        <input id="shopcode" name="shopcode" type="hidden" value="${analysis.shopcode!''}">
                        <input id="errortype" name="errortype" type="hidden" value="${analysis.errortype!''}">
                        <input id="oldstatus" name="oldstatus" type="hidden" value="">
                    </div>
                    <label class="control-label col-md-1">设备编号 :
                    </label>

                    <div class="col-md-3">
                        <div class="form-control-static">${analysis.deviceuniquecode!''}</div>
                    </div>
                    <label class="control-label col-md-1">商户编码 :
                    </label>

                    <div class="col-md-3">
                        <div class="form-control-static">${analysis.shopcode!''}</div>
                    </div>

                </div>

                <div class="form-group">

                    <label class="control-label col-md-1">商户名称 :
                    </label>

                    <div class="col-md-3">
                        <div class="form-control-static">${analysis.shopname!''}</div>
                    </div>

                    <label class="control-label col-md-1">门店编码 :
                    </label>

                    <div class="col-md-3">
                        <div class="form-control-static">${analysis.branchcode!''}</div>
                    </div>

                    <label class="control-label col-md-1">门店名称 :
                    </label>

                    <div class="col-md-3">
                        <div class="form-control-static">${analysis.branchname!''}</div>
                    </div>

                </div>

                <div class="form-group">

                    <label class="control-label col-md-1">故障部件 :
                    </label>

                    <div class="col-md-3">
                        <div class="form-control-static">${analysis.errortype!''}</div>
                    </div>

                    <label class="control-label col-md-1">报错时间 :
                    </label>

                    <div class="col-md-3">
                        <div class="form-control-static">${analysis.createtime!''}</div>
                    </div>

                    <label class="control-label col-md-1">报错次数 :
                    </label>

                    <div class="col-md-3">
                        <div class="form-control-static">${analysis.count!''}</div>
                    </div>

                </div>

                <div class="form-group">

                    <label class="control-label col-md-1">备注 :
                    </label>

                    <div class="col-md-3">
                        <div class="form-control-static">${analysis.errorremark!''}</div>
                    </div>

                </div>
            </div>


        </div>
        <p style="font-size: large">历史上报信息</p>

        <div class="panel panel-default">
            <div class="panel-body table-responsive zl-content-container">
                <#include "equipbug_page.ftl"/>
            </div>
        </div>
        <div class="footer">
            <button type="button" class="btn green" style="margin-left: 45%" onclick="redirect()">返回</button>
        </div>
    </div>
</form>
</@override>
<@override name="window">
<div id="repair_update" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" style="width: 600px">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                <h3>修改状态</h3>
            </div>
            <div class="modal-body">
                <form action="#" class="form-horizontal" method="post" id="addForm">
                    <div class="form-body">

                        <div class="form-group">
                            <label class="control-label col-md-3">操作人</label>

                            <div class="col-md-3">
                                <div class="form-control-static">${analysis.loginusername!''}</div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3">处理状态
                            </label>

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