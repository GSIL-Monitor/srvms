<@override name="jsfile">
<script type="text/javascript" src="https://webapi.amap.com/maps?v=1.3&key=${gd.mapapi.key}"></script>
</@override>
<@override name="jstext">
<script>
    var yzmMaxInterval = 60;
    var yzmInterval;
    var yzmIntervalIndex;

    function addRegShop() {
        var shopname = $('#shopname').val().trim();
        var provinceid = $("#provinceid").val();
        var cityid = $("#cityid").val();
        var districtid = $("#districtid").val();
        var area = $('#provinceid option:selected').text().replace("请选择", "") + " " + $('#cityid option:selected').text().replace("请选择", "") + " " + $('#districtid option:selected').text().replace("请选择", "");
        var industryid = $('#industry').val();
        var industryname = $('#industry option:selected').text();
        var contact = $('#contact').val().trim();
        var tel = $('#tel').val();
        var yzm = $('#yzm').val();
        var email = $('#email').val();
        var contactaddress = $('#contactaddress').val();
        var phone = /^1[1,2,3,4,5,6,7,8,9,0][\d]{9}$/;

        if (shopname == '') {
            AlertMsg('请输入商户名称！');
            return;
        }

        if (!/^([\u4E00-\uFA29]|[\uE7C7-\uE7F3]|[a-zA-Z0-9_-]){1,20}$/.test(shopname)) {
            AlertMsg('商户名称不能超过20个字符且不能有空格与中文特殊字符!');
            return;
        }

        if (contact == '') {
            AlertMsg('请输入联系人！');
            return;
        }

        if (!/^([\u4E00-\uFA29]|[\uE7C7-\uE7F3]|[a-zA-Z0-9_-]){1,20}$/.test(contact)) {
            AlertMsg('联系人不能超过20个字符且不能有空格与中文特殊字符!');
            return;
        }

        if (industryid == '') {
            AlertMsg('请选择行业', $('#industryType'));
            return;
        }

        if (!phone.test(tel)) {
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
        if (districtid == '') {
            AlertMsg('请选择区县！');
            return;
        }
        if (!checkEmpty(email)) {
            var checkemail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            if (!checkemail.test(email)) {
                AlertMsg('请输入有效的邮箱！');
                return false;
            }
        }

        var url = '${ctxPath}/srv/shop/addReg.action';
        var params = {
            shopname: shopname,
            provinceid: provinceid,
            cityid: cityid,
            districtid: districtid,
            area: area,
            industryid: industryid,
            industryname: industryname,
            contact: contact,
            tel: tel,
            yzm: yzm,
            email: email,
            contactaddress: contactaddress
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {

                AlertMsg(result);
            } else {
                AlertMsg("商户账号已生成!账号密码已发送至商户手机!", function () {
                    window.location.href = "${ctxPath}/srv/shop/manage.action";
                });
            }
        })
    }

    var industrys = [
        [
            {
                id: '1',
                name: '便利店'
            },
            {
                id: '2',
                name: '小型超市'
            },
            {
                id: '3',
                name: '休闲食品'
            },
            {
                id: '4',
                name: '烟酒糖茶'
            },
            {
                id: '5',
                name: '母婴用品'
            },
            {
                id: '6',
                name: '化妆品'
            },
            {
                id: '7',
                name: '饰品礼品'
            },
            {
                id: '8',
                name: '家居家纺'
            },
            {
                id: '9',
                name: '保健食品'
            },
            {
                id: '10',
                name: '办公用品'
            },
            {
                id: '11',
                name: '体育用品'
            },
            {
                id: '12',
                name: '服装鞋帽'
            },
            {
                id: '13',
                name: '皮具箱包'
            },
            {
                id: '14',
                name: '家电数码'
            },
            {
                id: '15',
                name: '户外用品'
            },
            {
                id: '16',
                name: '汽车用品'
            },
            {
                id: '17',
                name: '农资用品'
            },
            {
                id: '18',
                name: '农副产品'
            },
            {
                id: '19',
                name: '宠物店'
            },
            {
                id: '20',
                name: '其他'
            }
        ]
    ]

    $(function () {
        $('#industryType').change(function () {
            var type = $(this).val();
            if (type && type != '') {
                var arr = industrys[type];
                var options = '<option value="">请选择经营分类</option>';

                for (var index in arr) {
                    options += '<option value="' + arr[index].id + '">' + arr[index].name + '</option>';
                }
                $('#industry').html(options);
            }
        })

        //初始化区划三级联动
        initAreaComponent('provinceid', 'cityid', 'districtid');
    })

    function sendYzm() {
        var account = $('#tel').val();
        var phone = /^1[1,2,3,4,5,6,7,8,9,0][\d]{9}$/;
        if (account == '') {
            AlertMsg('请输入手机号');
            return;
        } else if (!phone.test(account)) {
            AlertMsg('请输入正确的手机号');
            return;
        }

        var url = '${ctxPath}/srv/shop/reg/sendYzm.action';
        var params = {
            account: account
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

</script>
<style>
    .if_select {
        height: 33px;
        border: 1px solid #bac6dd;
        color: gray;
        font-size: 14px;
    }

    .if_select_first {
        width: 120px;
        float: left;
    }

    .if_select_second {
        width: 155px;
        float: right;
    }

    .lf_div {
        position: relative;
        width: 100%;
    }

</style>
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
                        <input id="shopname" name="shopname" type="text" class="form-control" value=""
                               data-val-required="商户名称是必须的." data-val="true"
                               data-val-length="字段 商户名称 必须是最大长度为 64 的字符串。"
                               data-val-length-max="64">
                    </div>
                    <label class="control-label col-md-1">联系人
                        <span class="required" aria-required="true"> * </span></label>

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

                    <label class="control-label col-md-1">验证码
                        <span class="required" aria-required="true"> * </span></label>

                    <div class="col-md-2">
                        <div class="input-group">
                            <input id="yzm" name="yzm" type="text" class="form-control"
                                   aria-label="Text input with multiple buttons" value="">

                            <div class="input-group-btn">
                                <button type="button" class="btn btn-default" id="sendYzmBtn" onclick="sendYzm()">
                                    获取验证码
                                </button>
                            </div>
                        </div>
                    </div>


                    <label class="control-label col-md-1">经营行业
                        <span class="required" aria-required="true"> * </span></label>

                    <div class="col-md-2">
                        <select id="industryType" class="form-control">
                            <option value="">请选择行业</option>
                            <option value="0">零售</option>
                        </select>
                    </div>

                    <label class="control-label col-md-1">经营类目
                        <span class="required" aria-required="true"> * </span></label>

                    <div class="col-md-2">
                        <select id="industry" class="form-control">
                            <option value="">请选择经营分类</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">

                    <label class="control-label col-md-1">
                        省<span class="required" aria-required="true"> * </span>
                    </label>

                    <div class="col-md-2">
                        <select class="form-control" name="provinceid" id="provinceid" val="">
                            <option value="">请选择</option>
                        </select>
                    </div>

                    <label class="control-label col-md-1">
                        市<span class="required" aria-required="true"> * </span>
                    </label>

                    <div class="col-md-2">
                        <select class="form-control" name="cityid" id="cityid"
                                val="">
                            <option value="">请选择</option>
                        </select>
                    </div>

                    <label class="control-label col-md-1">区县
                        <span class="required" aria-required="true"> * </span>
                    </label>

                    <div class="col-md-2">
                        <select class="form-control" name="districtid" id="districtid"
                                val="">
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">

                    <label class="control-label col-md-1">地址
                    </label>

                    <div class="col-md-2">
                        <input id="contactaddress" name="contactaddress" type="text" class="form-control" value="">
                    </div>

                    <label class="control-label col-md-1">邮箱
                    </label>

                    <div class="col-md-2">
                        <input id="email" name="email" type="text" class="form-control" value="">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="form-group col-sm-12">
        <input type="button" value="生成商户账号" class="btn btn-primary col-lg-2" onclick="addRegShop()">
    </div>
</form>

</@override>
<@override name="window">
<div id="show_error" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" style="width: 600px">
        <div class="modal-content">

            <div class="modal-body">
                <form action="#" class="form-horizontal" method="post">
                    <div class="form-body">
                        <div class="form-group">
                            <label class="control-label col-md-3">跟进标注 :
                            </label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <a href="#" class="btn btn-primary" onclick="updateShopfollow()">确定</a>
                <a href="#" class="btn btn-default" data-dismiss="modal" aria-hidden="true">关闭</a>
            </div>
        </div>
    </div>
</div>
</@override>
<@extends name="../base_main.ftl"/>
