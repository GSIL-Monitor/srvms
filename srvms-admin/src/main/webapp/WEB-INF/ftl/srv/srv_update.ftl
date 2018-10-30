<@override name="jsfile">
<script type="text/javascript" src="https://webapi.amap.com/maps?v=1.3&key=${gd.mapapi.key}"></script>
</@override>
<@override name="jstext">
<script>

    function updateSrv() {
        var servercode = $('#servercode').val();
        var servername = $('#servername').val();
        var provinceid = $("#provinceid").val();
        var cityid = $("#cityid").val();
        var districtid = $("#districtid").val();
        var area = $('#provinceid option:selected').text().replace("请选择", "") + " " + $('#cityid option:selected').text().replace("请选择", "") + " " + $('#districtid option:selected').text().replace("请选择", "");
        var contact = $('#contact').val();
        var tel = $('#tel').val();
        var yzm = $('#yzm').val();
        var contactaddress = $('#contactaddress').val();
        var salerid = $("#saler").val();
        var salername = $('#saler option:selected').text()
        var flag = $("#flag").val();
        var bankcard = $("#bankcard").val();
        var bankcardname = $("#bankcardname").val();
        var bankcardno = $("#bankcardno").val();
        var subordinatebranch = $("#subordinatebranch").val();
        var obligatetel = $("#obligatetel").val();
        var alirevenuescale = $("#alirevenuescale").val();
        var weixirevenuescale = $("#weixirevenuescale").val();
        var appdiscountratio = $("#appdiscountratio").val();

        var sp = /^([\u4E00-\uFA29]|[\x21-\x7e]|[\uE7C7-\uE7F3]|[a-zA-Z0-9_-]){1,20}$/;
        if (servername == '') {
            AlertMsg('请输入服务商名称！');
            return;
        }
        if (!sp.test(servername)) {
            AlertMsg('服务商不能超过20个字符且不能有空格与中文特殊字符！');
            return false;
        }

        if (contact == '') {
            AlertMsg('请输入联系人！');
            return;
        }
        if (!sp.test(contact)) {
            AlertMsg('联系人不能超过20个字符且不能有空格与中文特殊字符！');
            return false;
        }
        if (salerid == '') {
            AlertMsg('请选择售后！');
            return;
        }


        if (tel == '') {
            AlertMsg('请输入手机号！');
            return;
        }
        var reg = /^1[0-9][\d]{9}$/;
        if (!reg.test(tel)) {
            AlertMsg('请输入有效的手机号！');
            return false;
        }
        if (provinceid == '') {
            AlertMsg('请选择省！');
            return;
        }
        if (cityid == '') {
            AlertMsg('请选择市！');
            return;
        }

        if (flag == '') {
            AlertMsg('请选择状态！');
            return;
        }

        if (bankcard == '') {
            AlertMsg('请输入结算银行卡！');
            return;
        }
        if (bankcardname == '') {
            AlertMsg('请输入卡主姓名！');
            return;
        }
        if (bankcardno == '') {
            AlertMsg('请输入结算卡卡号！');
            return;
        }
        if (!/^[1-9]\d*$/.test(bankcardno)) {
            AlertMsg('请输入正确的结算卡卡号！');
            return;
        }
        if (subordinatebranch == '') {
            AlertMsg('请输入所属支行！');
            return;
        }
        if (obligatetel == '') {
            AlertMsg('请输入预留手机号！');
            return;
        }
        if (!reg.test(obligatetel)) {
            AlertMsg('预留手机号输入有误！');
            return false;
        }

        if (alirevenuescale == '') {
            AlertMsg('请输入比例支付宝收益！');
            return;
        }
        if (!/^100$|^(\d|[1-9]\d)$/.test(alirevenuescale)) {
            AlertMsg('支付宝收益请输入0-100！');
            return;
        }

        if (weixirevenuescale == '') {
            AlertMsg('请输入微信收益比例！');
            return;
        }

        if (!/^100$|^(\d|[1-9]\d)$/.test(weixirevenuescale)) {
            AlertMsg('微信收益请输入0-100！');
            return;
        }

        if (!/^100$|^(\d|[1-9]\d)$/.test(appdiscountratio)) {
            AlertMsg('折扣比例请输入0-100！');
            return;
        }

        var url = '${ctxPath}/srv/updateSrv.action';
        var params = {
            servername: servername,
            servercode: servercode,
            provinceid: provinceid,
            cityid: cityid,
            districtid: districtid,
            area: area,
            contact: contact,
            tel: tel,
            yzm: yzm,
            contactaddress: contactaddress,
            aftersales: salerid,
            aftersalesname: salername,
            flag: flag,
            bankcard: bankcard,
            bankcardname: bankcardname,
            bankcardno: bankcardno,
            subordinatebranch: subordinatebranch,
            obligatetel: obligatetel,
            alirevenuescale: alirevenuescale,
            weixirevenuescale: weixirevenuescale,
            appdiscountratio:appdiscountratio
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                AlertMsg("修改成功!", function () {
                    window.history.back()
                });
            }
        })
    }

    function redirect() {
        window.location.href = "${ctxPath}/srv/manage.action";
    }

    $(function () {
        //初始化区划三级联动
        initAreaComponent('provinceid', 'cityid', 'districtid');
    })

</script>
</@override>
<@override name="right">
<form action="#" method="post" class="form-horizontal" role="form" id="addForm">
    <div class="panel panel-default">
        <div class="panel-heading main-content-title">基本信息</div>
        <div class="panel-body">

            <div class="form-body">
                <div class="form-group">
                    <label class="control-label col-md-2">服务商名称
                        <span class="required" aria-required="true"> * </span></label>

                    <div class="col-md-2">
                        <input id="servername" name="servername" type="text" class="form-control" value="${data.servername!""}">
                        <input type="hidden" id="servercode" name="servercode" value="${data.servercode!''}"/>
                    </div>
                    <label class="control-label col-md-2">联系人
                        <span class="required" aria-required="true"> * </span></label>

                    <div class="col-md-2">
                        <input id="contact" name="contact" type="text" class="form-control" value="${data.contact!""}">
                    </div>

                    <label class="control-label col-md-2">联系手机
                        <span class="required" aria-required="true"> * </span></label>

                    <div class="col-md-2">
                        <input id="tel" maxlength="11" name="tel" type="text" class="form-control" value="${data.tel!""}">
                    </div>

                </div>

                <div class="form-group">
                    <label class="control-label col-md-2">所属售后
                        <span class="required" aria-required="true"> * </span></label>
                    </label>

                    <div class="col-md-2">
                        <select class="form-control" name="saler" id="saler" val="">
                            <option value="">请选择</option>
                            <#if salers?? &&salers?size gt 0>
                                <#list salers as salers>
                                    <option value="${salers.userid}" <#if data.aftersales==salers.userid>selected</#if>>${salers.username}</option>
                                </#list>
                            </#if>
                        </select>
                    </div>

                    <label class="control-label col-md-2">所属区域
                        <span class="required" aria-required="true"> * </span></label>
                    </label>

                    <div class="col-md-5">
                        <div class="col-md-4" style="padding-left: 0px;">
                            <select  class="form-control" name="provinceid" id="provinceid" style="width: 126px;" val="${data.provinceid!""}">
                                <option value="">请选择省</option>
                            </select>
                        </div>
                        <div class="col-md-4" style="padding-left: 0px;">
                            <select  class="form-control" name="cityid" id="cityid" style="width: 126px;" val="${data.cityid!""}">
                                <option value="">请选择市</option>
                            </select>
                        </div>
                        <div class="col-md-4" style="padding-left: 0px;">
                            <select  class="form-control" name="districtid" id="districtid" style="width: 126px;" val="${data.districtid!""}">
                                <option value="">请选择区</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-group">

                    <label class="control-label col-md-2">状态
                        <span class="required" aria-required="true"> * </span>
                    </label>

                    <div class="col-md-2">
                        <select class="form-control" name="flag" id="flag" val="${data.flag!""}">
                            <option value="">请选择</option>
                            <option value="1"<#if data.flag == 1>selected</#if>>正常</option>
                            <option value="0"<#if data.flag == 0>selected</#if>>禁用</option>
                        </select>
                    </div>

                    <label class="control-label col-md-2">应用最低折扣(%)
                        <span class="required" aria-required="true"> * </span>
                    </label>
                    <div class="col-md-2">
                        <input id="appdiscountratio" maxlength="3" name="appdiscountratio" type="text" class="form-control" value="${data.appdiscountratio!""}">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading main-content-title">结算信息</div>
        <div class="panel-body">
            <div class="form-group">
                <label class="control-label col-md-2">结算银行卡
                    <span class="required" aria-required="true"> * </span></label>

                <div class="col-md-2">
                    <input id="bankcard" name="bankcard" type="text" class="form-control" value="${data.bankcard!""}">
                </div>
                <label class="control-label col-md-2">卡主姓名
                    <span class="required" aria-required="true"> * </span></label>

                <div class="col-md-2">
                    <input id="bankcardname" name="bankcardname" type="text" class="form-control" value="${data.bankcardname!""}">
                </div>

                <label class="control-label col-md-2">结算卡卡号
                    <span class="required" aria-required="true"> * </span></label>

                <div class="col-md-2">
                    <input id="bankcardno" name="bankcardno" type="text" class="form-control" value="${data.bankcardno!""}">
                </div>

            </div>
            <div class="form-group">
                <label class="control-label col-md-2">所属支行
                    <span class="required" aria-required="true"> * </span></label>

                <div class="col-md-2">
                    <input id="subordinatebranch" name="subordinatebranch" type="text" class="form-control" value="${data.subordinatebranch!""}">
                </div>
                <label class="control-label col-md-2">预留手机号
                    <span class="required" aria-required="true"> * </span></label>

                <div class="col-md-2">
                    <input id="obligatetel" name="obligatetel" type="text" class="form-control" value="${data.obligatetel!""}">
                </div>
            </div>

        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">收益内容</div>
        <div class="panel-body">
            <div class="form-group">
                <div class="col-md-12">
                    <div class="table-scrollable">
                        <table class="table table-hover table-bordered">
                            <thead>
                            <tr>
                                <th> 收单类型</th>
                                <th> 收单内容</th>
                                <th> 收益比例(%) <span class="required" aria-required="true"> * </span></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr class="odd gradeX">
                                <td>收单收益</td>
                                <td>支付宝收单</td>
                                <td><input style="width: 126px;" id="alirevenuescale" name="alirevenuescale" type="text"
                                           class="form-control" value="${data.alirevenuescale!""}"></td>
                            </tr>
                            <tr class="odd gradeX">
                                <td>收单收益</td>
                                <td>微信收单</td>
                                <td><input style="width: 126px;" id="weixirevenuescale" name="weixirevenuescale" type="text"
                                           class="form-control" value="${data.weixirevenuescale!""}"></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="form-group col-sm-12">
        <input type="button" value="更新服务商信息" class="btn btn-primary col-lg-2" onclick="updateSrv()">
        <input type="button" onclick="back()" style="margin-left:10px;" value="返回" class="btn btn-default">
    </div>
</form>
</@override>
<@override name="window">
</@override>
<@extends name="../base_main.ftl"/>
