<@override name="jsfile">
<script type="text/javascript" src="https://webapi.amap.com/maps?v=1.3&key=${gd.mapapi.key}"></script>
</@override>
<@override name="jstext">
<script>
    var yzmMaxInterval = 60;
    var yzmInterval;
    var yzmIntervalIndex;

    function addAssociationInfo() {
        var shopcode = $('#shopcode').val();
        var provincename = $('#provinceid option:selected').text();
        var cityname = $('#cityid option:selected').text()
        var districtname = $('#districtid option:selected').text()
        var yzm = $('#yzm').val();

        if (shopcode == '') {
            AlertMsg('请输入商户ID！');
            return;
        }

        if (yzm == '') {
            AlertMsg('请输入验证码！');
            return;
        }
        var url = '${ctxPath}/srv/shop/addAssociationInfo.action';
        var params = {
            shopcode: shopcode,
            yzm: yzm,
            provincename: provincename,
            cityname: cityname,
            districtname: districtname
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                AlertMsg("关联成功!", function () {
                    window.location.href="${ctxPath}/srv/shop/manage.action";
                });
            }
        })
    }

    function getShopInfo() {
        var shopcode = $('#shopcode').val();
        var dutypersonnum = $('#dutypersonnum').val();
        if (shopcode == '' && dutypersonnum == '') {
            AlertMsg('请输入正确的商户ID或商户联系人手机号！');
            return;
        }
        var url = '${ctxPath}/srv/shop/getShopInfo.action';
        var params = {
            shopcode: shopcode,
            dutypersonnum:dutypersonnum
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            var data = result.data;
            if (result.success) {
                $('#shopname').val(data.shopname);
                $('#contact').val(data.contact);
                $('#tel').val(data.tel);
                $('#email').val(data.email);
                $('#provinceid').attr("val", data.provinceid);
                $('#cityid').attr("val", data.cityid);
                $('#districtid').attr("val", data.districtid);
                $('#contactaddress').val(data.contactaddress);
                $('#telyzm').html(data.tel);
                //初始化区划三级联动
                initAreaComponent('provinceid', 'cityid', 'districtid');
                $('#shopdetail').show();
            }else{
                alert(222);
                AlertMsg('请输入正确的商户ID或商户联系人手机号！');
                return;
            }
        })
    }

    function sendYzm() {
        var shopcode = $('#shopcode').val();

        var url = '${ctxPath}/srv/shop/associationShop/sendYzm.action';
        var params = {
            shopcode: shopcode
        };

        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                $('#sendYzmBtn').attr('disabled', "true");
                yzmIntervalIndex = yzmMaxInterval;
                yzmInterval = window.setInterval(refreshSendYzmBtn, 1000);
            }
        })
    }

    function sumApply() {
        var shopcode = $('#shopcode').val();


        var url = '${ctxPath}/srv/shop/associationShop/sendYzm.action';
        var params = {
            shopcode: shopcode
        };

        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                $('#sendYzmBtn').attr('disabled', "true");
                yzmIntervalIndex = yzmMaxInterval;
                yzmInterval = window.setInterval(refreshSendYzmBtn, 1000);
            }
        })
    }

    function refreshSendYzmBtn() {
        $('#sendYzmBtn').html(yzmIntervalIndex + "秒后重新获取");
        yzmIntervalIndex--;
        if (yzmIntervalIndex == 0) {
            window.clearInterval(yzmInterval);
            $('#sendYzmBtn').removeAttr("disabled");
            $('#sendYzmBtn').html("再次验证码");
        }
    }

    var curModalStepIndex = 0;

    function showStepBtn() {
        $('#step-modal .modal-footer a').eq(0).hide();
        $('#step-modal .modal-footer a').eq(1).hide();
        $('#step-modal .modal-footer a').eq(2).hide();
        if (curModalStepIndex == 0) {
            $('#step-modal .modal-footer a').eq(1).show();

        } else if (curModalStepIndex == 1) {
            $('#step-modal .modal-footer a').eq(1).show();
            $('#next').hide();
            $('#complete').show();
        } else if (curModalStepIndex == 2) {
            $('#step-modal .modal-footer a').eq(0).show();
            $('#step-modal .modal-footer a').eq(2).show();
        }
    }
    //下一步
    function gotoNext() {
        var shopcode = $('#shopcode').val();

        if (shopcode == '') {
            AlertMsg('请输入商户ID进行查询！');
            return;
        }

        curModalStepIndex++;
        $('#stepTab li:eq(' + curModalStepIndex + ') a').tab('show');
        showStepBtn();
    }

    function gotoPref() {
        curModalStepIndex--;
        $('#stepTab li:eq(' + curModalStepIndex + ') a').tab('show');
        showStepBtn();
    }

</script>
</@override>
<@override name="right">
<form action="#" method="post" class="form-horizontal" role="form" id="stepForm">
    <ul class="nav nav-arrow-next nav-tabs" id="stepTab">
        <li class="active">
            <a href="#step_1" class="btn disabled" data-toggle="tab" aria-expanded="true">
                第1步：查找商户 </a>
        </li>
        <li class="">
            <a href="#step_2" class="btn disabled" data-toggle="tab" aria-expanded="false">
                第2步：商户验证 </a>
        </li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane active in" id="step_1">
            <div class="form-body">
                <div class="row">

                    <div class="form-group">
                        <label class="control-label col-md-1">商户ID:
                        </label>

                        <div class="col-md-2">
                            <input id="shopcode" name="shopcode" type="text" class="form-control"
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

                        <div class="col-md-2">
                            <input id="contactaddress" name="contactaddress" type="text" class="form-control"
                                   readonly="readonly" value="">
                        </div>
                        <label class="control-label col-md-1">邮箱账号:
                        </label>

                        <div class="col-md-2">
                            <input id="email" name="email" type="text" class="form-control"
                                   readonly="readonly" value="">
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="tab-pane" id="step_2">

            <div class="form-body">

                <div class="row">
                    <div class="form-group">

                        <label class="control-label col-md-1">联系人:</label>

                        <div class="col-md-2">
                            <div id="telyzm" name="telyzm" readonly="readonly">

                            </div>
                            <span>用于接受验证码 </span>

                        </div>
                    </div>
                    <div class="form-group">

                        <label class="control-label col-md-1">验证码
                            <span class="required" aria-required="true"> * </span></label>

                        <div class="col-md-2">
                            <div class="input-group">
                                <input id="yzm" name="yzm" type="text" class="form-control"
                                       aria-label="Text input with multiple buttons" value="" style="width: 120px">

                                <div class="input-group-btn">
                                    <button type="button" class="btn btn-default" id="sendYzmBtn"
                                            onclick="sendYzm()">
                                        获取验证码
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="modal-footer" id="next">
            <a href="javascript:void(0)" onclick="gotoNext()" class="btn btn-primary">下一步</a>
        </div>
        <div class="modal-footer" id="complete" style="display: none;">
            <a href="#" class="btn btn-primary" onclick="addAssociationInfo()">完成</a>
        </div>
</form>

</@override>

<@extends name="../base_main.ftl"/>
