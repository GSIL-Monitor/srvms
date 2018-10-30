<@override name="jsfile">
<script type="text/javascript" src="https://webapi.amap.com/maps?v=1.3&key=${gd.mapapi.key}"></script>
</@override>
<@override name="jstext">
<script>
    function commit() {
        var associationid = $('#associationid').val();
        var servercode = $('#servercode').val();
        var shopcode = $('#shopcode').val();
        var status = $('input:radio[name="status"]:checked').val();
        var remark = $("#remark").val();

        if (status == '') {
            AlertMsg('请选择审核结果！');
            return;
        }
        var url = '${ctxPath}/srv/association/update.action';
        var params = {
            id: associationid,
            status: status,
            servercode: servercode,
            shopcode: shopcode,
            remark: remark
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                AlertMsg("提交成功!", function () {
                   back();
                });
            }
        })
    }


</script>
</@override>
<@override name="right">
<div class="row">
    <div class="col-lg-12 col-xs-12 col-sm-12">
        <!-- BEGIN PORTLET-->
        <div class="portlet light ">

            <form action="#" method="get" class="form-horizontal" role="form" id="searchForm">
                <div class="panel panel-default">
                    <div class="panel-heading main-content-title">申请服务商信息</div>
                    <div class="panel-body">

                        <div class="form-body">

                            <div class="form-group">
                                <label class="control-label col-md-1">服务商编码</label>

                                <div class="col-md-2">
                                    <div class="form-control-static">
                                    ${associationData.servercode!''}
                                    </div>
                                    <input id="associationid" name="associationid" type="hidden" value="${associationData.id!''}">
                                    <input id="servercode" name="servercode" type="hidden" value="${associationData.servercode!''}">
                                    <input id="shopcode" name="shopcode" type="hidden" value="${associationData.shopcode!''}">

                                </div>

                                <label class="control-label col-md-1">服务商联系人</label>

                                <div class="col-md-2">
                                    <div class="form-control-static">
                                    ${associationData.serverusername!''}
                                    </div>
                                </div>

                                <label class="control-label col-md-1">服务商联系电话</label>

                                <div class="col-md-2">
                                    <div class="form-control-static">
                                    ${associationData.servertel!''}
                                    </div>
                                </div>

                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-1">所在区域</label>

                                <div class="col-md-2">
                                    <div class="form-control-static">
                                    ${associationData.serverarea!''}
                                    </div>
                                </div>

                                <label class="control-label col-md-1">申请时间</label>

                                <div class="col-md-2">
                                    <div class="form-control-static">
                                    ${associationData.createtime!''}
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading main-content-title">关联商户信息</div>
                    <div class="panel-body">

                        <div class="form-body">

                            <div class="form-group">
                                <label class="control-label col-md-1">商户编码</label>

                                <div class="col-md-2">
                                    <div class="form-control-static" >
                                    ${associationData.shopcode!''}
                                    </div>
                                </div>

                                <label class="control-label col-md-1">商户名称</label>

                                <div class="col-md-2">
                                    <div class="form-control-static">
                                    ${associationData.shopname!''}
                                    </div>
                                </div>

                                <label class="control-label col-md-1">商户联系人</label>

                                <div class="col-md-2">
                                    <div class="form-control-static">
                                    ${associationData.shopusername!''}
                                    </div>
                                </div>


                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-1">商户联系电话</label>

                                <div class="col-md-2">
                                    <div class="form-control-static">
                                    ${associationData.shoptel!''}
                                    </div>
                                </div>

                                <label class="control-label col-md-1">商户所在区域</label>

                                <div class="col-md-2">
                                    <div class="form-control-static">
                                    ${associationData.shoparea!''}
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading main-content-title">审核状态</div>
                    <div class="panel-body">

                        <div class="form-body">

                            <div class="form-group">
                                <label class="control-label col-md-1">审核状态</label>

                                <div class="col-md-2">
                                    <div class="form-control-static">
                                        <#if associationData.status == 0>
                                            待审核
                                        <#elseif associationData.status == 1>
                                            审核通过
                                        <#elseif associationData.status == 2>
                                            审核不通过
                                        </#if>
                                    </div>
                                </div>

                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-1">审核结果
                                </label>

                                <div class="col-md-2">

                                    <label class="radio-inline">
                                        <input type="radio" name="status" value="1"> 通过
                                        <span></span>
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="status" value="2"> 不通过
                                        <span></span>
                                    </label>
                                </div>

                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-1">审核备注
                                </label>

                                <div class="col-md-2">

                                    <textarea class="form-control" id="remark" name="remark" rows="3" style="resize: none;"></textarea>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>

                <div class="form-group col-sm-12">
                    <input type="button" onclick="back()" value="返回列表" class="btn btn-default">
                    <input type="button" onclick="commit()" value="提交" class="btn btn-default">
                </div>
            </form>
        </div>
        <!-- END PORTLET-->
    </div>
</div>
</@override>
<@override name="window">
</@override>
<@extends name="../base_main.ftl"/>