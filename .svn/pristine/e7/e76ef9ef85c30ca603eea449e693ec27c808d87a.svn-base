<@override name="jsfile">
<script type="text/javascript" src="https://webapi.amap.com/maps?v=1.3&key=${gd.mapapi.key}"></script>
</@override>
<@override name="jstext">
<script>
    function addAssociationInfo() {
        var shopcode = $('#shopcode').val();
        var provincename = $('#provinceid option:selected').text();
        var cityname = $('#cityid option:selected').text()
        var districtname = $('#districtid option:selected').text()
        var servercode = $('#servercode').val();
        if (shopcode == '') {
            AlertMsg('请先查询商户信息！');
            return;
        }
        var url = '${ctxPath}/srv/association/addAssociationInfo.action';
        var params = {
            shopcode: shopcode,
            provincename: provincename,
            cityname: cityname,
            districtname: districtname,
            servercode:servercode
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                AlertMsg("关联成功!", function () {
                    window.location.href="${ctxPath}/srv/manage.action";
                });
            }
        })
    }

    function getShopInfo() {
        var shopcode = $('#shopcodekey').val();
        var dutypersonnum = $('#dutypersonnum').val();
        if (shopcode == '' && dutypersonnum == '') {
            AlertMsg('请输入正确的商户ID或商户联系人手机号！');
            return;
        }
        var url = '${ctxPath}/srv/association/getShopInfo.action';
        var params = {
            shopcode: shopcode,
            dutypersonnum:dutypersonnum
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            var data = result.data;
            if (result.success) {
                $('#shopname').val(data.shopname);
                $('#shopcode').val(data.shopcode);
                $('#contact').val(data.contact);
                $('#tel').val(data.tel);
                $('#provinceid').attr("val", data.provinceid);
                $('#cityid').attr("val", data.cityid);
                $('#districtid').attr("val", data.districtid);
                $('#contactaddress').val(data.contactaddress);
                $('#telyzm').html(data.tel);
                //初始化区划三级联动
                initAreaComponent('provinceid', 'cityid', 'districtid');
                $('#shopdetail').show();
            }else{
                AlertMsg('请输入正确的商户ID或商户联系人手机号！');
                return;
            }
        })
    }
</script>
</@override>
<@override name="right">
<form action="#" method="post" class="form-horizontal" role="form" id="stepForm">
    <input hidden type="text" value="${servercode!''}" id="servercode">
    <div class="modal-header">
       <font style="font-weight: bolder;font-size: 15px">商户关联-新增</font>
    </div>
    <div class="tab-content" style="padding-top: 20px">
        <div class="tab-pane active in" style="height: 200px">
            <div class="form-body">
                <div class="row">
                    <div class="form-group">
                        <label class="control-label col-md-1">商户ID:
                        </label>
                        <div class="col-md-2">
                            <input id="shopcodekey" name="shopcodekey" type="text" class="form-control"
                                   value="">
                        </div>
                        <label class="control-label col-md-2">商户联系人手机号:
                        </label>
                        <div class="col-md-2">
                            <input id="dutypersonnum" name="dutypersonnum" type="text" class="form-control"
                                   value="">
                        </div>
                        <div class="col-md-5">
                            <input type="button" value="查找商户" class="btn btn-primary col-lg-3" onclick="getShopInfo()">
                        </div>
                    </div>
                </div>
                <div class="row" id="shopdetail" style="display: none;">
                    <div class="form-group">
                        <label class="control-label col-md-1">商户ID:</label>
                        <div class="col-md-2">
                            <input id="shopcode" name="shopcode" type="text" class="form-control" readonly="readonly"
                                   value="">
                        </div>
                        <label class="control-label col-md-1">商户名称:</label>
                        <div class="col-md-2">
                            <input id="shopname" name="shopname" type="text" class="form-control" readonly="readonly"
                                   value="">
                        </div>
                        <label class="control-label col-md-1">联系人:</label>
                        <div class="col-md-2">
                            <input id="contact" name="contact" type="text" class="form-control" readonly="readonly"
                                   value="">
                        </div>
                        <label class="control-label col-md-1">联系电话:</label>
                        <div class="col-md-2">
                            <input id="tel" name="tel" type="text" class="form-control" readonly="readonly" value="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-1">所在省:
                        </label>
                        <div class="col-md-2">
                            <select class="form-control" name="provinceid" id="provinceid" disabled val="">
                                <option value="">请选择</option>
                            </select>
                        </div>
                        <label class="control-label col-md-1">所在市:
                        </label>
                        <div class="col-md-2">
                            <select class="form-control" name="cityid" id="cityid" disabled val="">
                                <option value="">请选择</option>
                            </select>
                        </div>
                        <label class="control-label col-md-1">所在区:
                        </label>
                        <div class="col-md-2">
                            <select class="form-control" name="districtid" id="districtid" disabled val="">
                                <option value="">请选择</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-1">详细地址:
                        </label>
                        <div class="col-md-4">
                            <input id="contactaddress" name="contactaddress" type="text" class="form-control"
                                   readonly="readonly" value="">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="complete" style="padding-left: 550px;height: 200px" >
            <a href="#" class="btn btn-primary" onclick="addAssociationInfo()">确定关联</a>
        </div>
</form>
</@override>
<@extends name="../base_main.ftl"/>
