<@override name="jsfile">
<script type="text/javascript" src="https://webapi.amap.com/maps?v=1.2&key=${gd.mapapi.key}"></script>
</@override>
<@override name="jstext">
<script>

    function addRegSrv() {
        var servername = $('#servername').val();
        var provinceid = $("#provinceid").val();
        var cityid = $("#cityid").val();
        var districtid = $("#districtid").val();
        var area = $('#provinceid option:selected').text().replace("请选择", "") + " " + $('#cityid option:selected').text().replace("请选择", "") + " " + $('#districtid option:selected').text().replace("请选择", "");
        var contact = $('#contact').val();
        var tel = $('#tel').val();
        var yzm = $('#yzm').val();
        var email = $('#email').val();
        var contactaddress = $('#contactaddress').val();
        var salerid = $("#saler").val();
        var salername =$('#saler option:selected').text()
        if (servername == '') {
            AlertMsg('请输入服务商名称！');
            return;
        }
        if (salerid == '') {
            AlertMsg('请选择售后！');
            return;
        }
        if (contact.length > 6) {
            AlertMsg('联系人名称过长！');
            return;
        }
        if (contact == '') {
            AlertMsg('请输入联系人！');
            return;
        }
        if (tel == '') {
            AlertMsg('请输入手机号！');
            return;
        }
        if (!checkEmpty(tel)) {
            if (!((checkPhone(tel)))) {
                AlertMsg('请输入有效的手机号！');
                return false;
            }
        }
        if (provinceid == '') {
            AlertMsg('请选择省！');
            return;
        }
        if (cityid == '') {
            AlertMsg('请选择市！');
            return;
        }
        if (!checkEmpty(email)) {
            var reg = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            if (!reg.test(email)) {
                AlertMsg('请输入有效的邮箱！');
                return false;
            }
        }
        var url = '${ctxPath}/srv/addReg.action';
        var params = {
            servername: servername,
            provinceid: provinceid,
            cityid: cityid,
            districtid: districtid,
            area: area,
            contact: contact,
            tel: tel,
            yzm: yzm,
            email: email,
            contactaddress: contactaddress,
            aftersales: salerid,
            aftersalesname: salername
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            var json = eval(result);
            $('#memberlevel_add0').modal('show');
            $('#servercodes').val(json.servercode);
            $('#passwords').val('122456');

        })
    }

</script>
</@override>
<@override name="right">
<form action="#" method="post" class="form-horizontal" role="form" id="addForm">
    <div class="panel panel-default">
        <div class="panel-heading main-content-title"></div>
        <div class="panel-body">

            <div class="form-body">
                <div class="form-group">
                    <label class="control-label col-md-1">商户名称
                        <span class="required" aria-required="true"> * </span></label>

                    <div class="col-md-2">
                        <input id="shopname" name="shopname" type="text" class="form-control" value="">
                    </div>

                    <label class="control-label col-md-1">联系人
                        <span class="required" aria-required="true"> * </span></label>
                    </label>

                    <div class="col-md-2">
                        <input id="contact" name="contact" type="text" class="form-control" value="">
                    </div>

                    <label class="control-label col-md-1">联系电话
                        <span class="required" aria-required="true"> * </span></label>

                    <div class="col-md-2">
                        <input id="tel" name="tel" type="text" class="form-control" value="">
                    </div>
                </div>

                <div class="form-group">

                    <label class="control-label col-md-1">设备型号
                        <span class="required" aria-required="true"> * </span></label>
                    </label>

                    <div class="col-md-2">
                        <select class="form-control" name="devicemodel" id="devicemodel" val="">
                            <option value="">请选择</option>
                        </select>
                    </div>

                    <label class="control-label col-md-1">设备编号
                        <span class="required" aria-required="true"> * </span></label>

                    <div class="col-md-2">
                        <input id="devicecode" name="devicecode" type="text" class="form-control" value="">
                    </div>

                    <label class="control-label col-md-1">故障部件
                        <span class="required" aria-required="true"> * </span></label>
                    </label>

                    <div class="col-md-2">
                        <select class="form-control" name="errorpart" id="errorpart" val="">
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">

                    <label class="control-label col-md-1">处理状态
                        <span class="required" aria-required="true"> * </span></label>
                    </label>

                    <div class="col-md-2">
                        <select class="form-control" name="status" id="status" val="">
                            <option value="">请选择</option>
                        </select>
                    </div>

                    <label class="control-label col-md-1">处理办法
                        <span class="required" aria-required="true"> * </span></label>
                    </label>

                    <div class="col-md-2">
                        <select class="form-control" name="status" id="status" val="">
                            <option value="">请选择</option>
                        </select>
                    </div>
                    <label class="control-label col-md-1">是否反修
                        <span class="required" aria-required="true"> * </span></label>
                    </label>

                    <div class="col-md-2">
                        <select class="form-control" name="isrepair" id="isrepair" val="">
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">

                    <label class="control-label col-md-1">维修费用
                    </label>

                    <div class="col-md-2">
                        <input id="repaircost" name="repaircost" type="text" class="form-control" value="">
                    </div>

                    <label class="control-label col-md-1">维修时间
                        <span class="required" aria-required="true"> * </span></label>
                    </label>

                    <div class="col-md-2">
                        <input id="repairtime" name="repairtime" type="text" class="form-control" value="">
                    </div>

                </div>

                <div class="form-group">
                    <label class="control-label col-md-1">备注
                    </label>

                    <div class="col-md-4">
                        <input id="remake" name="remake" type="text" class="form-control" value="">
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="form-group col-sm-12">
        <input type="button" value="提交" class="btn btn-primary col-lg-2" onclick="addRegSrv()">
    </div>
</form>
</@override>
<@override name="window">
</@override>
<@extends name="../base_main.ftl"/>
