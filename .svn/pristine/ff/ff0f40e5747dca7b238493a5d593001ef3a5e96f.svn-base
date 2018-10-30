<@override name="jstext">

<style>
    .cashier-title {
        font-weight: bold;
        color: #666;
    }

    .cashier_item {
        width: calc(100% - 40px);
        margin-left: 20px;
        padding: 0;
        float: left;
        border-bottom: 1px solid #dddddd;
    }

    .cashier_item img {
        float: left;
        height: 60px;
    }

    .cashier_item input {
        float: left;
        height: 20px;
        width: 20px;
        /* line-height: 31px; */
        margin: 20px;
    }

    .cashier_item .cashier_money {
        color: black;
        display: block;
        min-width: 100px;
        height: 100%;
        float: right;
        margin-top: 20px;
        margin-bottom: 0;
    }

    .cashier_item span {
        color: #ff5d5b;
        font-size: 17px;
        font-weight: bold;
    }

    .cashier_body .selecteditem {
        padding: 8px 0;
        border: 2px solid #b0c2e1;
    }

    .panel-foot {
        width: 100%;
        height: 100px;
    }

    .panel-foot .btn {
        float: right;
        margin-right: 35px;
        margin-top: 24px;
    }

    .disableitem {
        display: none;
    }
</style>
</@override>
<@override name="right">
        <div class="panel panel-default">
            <div class="panel-heading panel_heading cashier-title">
                <div class="panel-body">

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <div class="col-md-2">
                                    <label style="height: 30px;line-height: 35px;">订单编号</label>
                                </div>

                                <div class="col-md-4">
                                    <input class="form-control" readonly="" name="orderCode" id="orderCode" value="${inserOrderMain.orderCode!''}">
                                </div>

                                <div class="col-md-2">
                                    <lable style="height: 30px;line-height: 35px;">总价(元)</lable>
                                </div>

                                <div class="col-md-2">
                                    <input class="form-control" readonly="" name="totalprice" id="totalprice" value="${inserOrderMain.totalPrice!''}">
                                </div>

                                <div class="col-md-2">
                                    <a href="javascript:void(0);" id="p1" onclick="showOrHideDetail()" style="height: 30px;line-height: 35px;">查看详情</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body" style="display:none;" id="renewDetail">
                        <div class="row" style="margin-left: -30px;margin-right: -30px;margin-bottom: 20px;">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <div class="col-md-2">
                                        <lable style="height: 30px;line-height: 35px;">商户编号</lable>
                                    </div>

                                    <div class="col-md-4">
                                        <input class="form-control" readonly name="shopcode" id="shopcode" value="${inserOrderMain.shopCode!''}"/>
                                    </div>

                                    <div class="col-md-2">
                                        <lable style="height: 30px;line-height: 35px;">商户名称</lable>
                                    </div>

                                    <div class="col-md-4">
                                        <input class="form-control" readonly name="shopname" id="shopname" value="${inserOrderMain.shopName!''}"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-left: -60px;margin-right: -60px;margin-bottom: 20px;">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <div class="col-lg-6 col-xs-12 col-sm-12">
                                        <div class="panel panel-default" style="border-radius: 0px;">
                                            <div class="panel-body" style="padding: 0;">
                                                <div class="tab-pane active">
                                                    <div class="table-responsive">
                                                        <table class="table table-hover table-bordered" style="margin-bottom: 0;border: none;">
                                                            <thead>
                                                            <tr>
                                                                <th style="text-align: center;"> 分店编号</th>
                                                                <th style="text-align: center;"> 分店名称</th>
                                                                <th style="text-align: center;"> 产品名称</th>
                                                                <th style="text-align: center;"> 单价(元)</th>
                                                                <th style="text-align: center;"> 续费年限</th>
                                                                <th style="text-align: center;"> 小计(元)</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody id="branchTbody">
                                                            <#if inserOrderItem?? && inserOrderItem?size gt 0>
                                                                <#list inserOrderItem as branch>
                                                                <tr>
                                                                    <td> ${branch.branchcode!""}</td>
                                                                    <td> ${branch.branchname!""}</td>
                                                                    <td> ${branch.productname!""}</td>
                                                                    <td> ${branch.amount!""}</td>
                                                                    <td>${branch.renewtime!""}年</td>
                                                                    <td> ${branch.totalamount!""}</td>
                                                                </tr>
                                                                </#list>
                                                            </#if>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
            <div class="panel-body cashier_body">
                <div class="cashier_item selecteditem" onclick="select_cashier_item(this)">
                    <input type="checkbox" name="cashier_selection" class="cashier_selection" checked="checked"
                           value="alipay">
                    <img src="${zl.web.resource.address}/images/ali_pay.png">

                    <div class="cashier_money">支付<span>${inserOrderMain.totalPrice!''}</span>元</div>
                </div>
                <div class="cashier_item" onclick="select_cashier_item(this)">
                    <input type="checkbox" name="cashier_selection" class="cashier_selection" value="wxpay"
                           onclick="select_cashier_item(this)">
                    <img src="${zl.web.resource.address}/images/wx_pay.png">

                    <div class="cashier_money">支付<span>${inserOrderMain.totalPrice!''}</span>元</div>
                </div>
                <div class="cashier_item disableitem" onclick="select_cashier_item(this)">
                    <input type="checkbox" name="cashier_selection" class="cashier_selection"
                           onclick="select_cashier_item(this)">
                    <img src="${zl.web.dcms.domain}/images/union_pay.png">

                    <div class="cashier_money">支付<span>${account!''}</span>元</div>
                </div>
            </div>
        </div>
        <div class="form-group col-sm-12">
            <input type="button" value="提交" class="btn btn-primary col-lg-1" onclick="paySms()">
            <input type="button" onclick="back()" style="margin-left:10px;" value="返回"
                   class="btn btn-default">
        </div>
    </div>
<script>
    function select_cashier_item(obj) {
        $(".cashier_selection").each(function () {
            $(this)[0].checked = false;
        });
        $(".cashier_item").removeClass("selecteditem");
        $(obj).addClass("selecteditem");
        $(obj).find("input")[0].checked = true;
    }

    function paySms() {
        var shopcode = $('#shopcode').val();
        var billcode = $('#orderCode').val();
        var payamount = $('#totalprice').val();
        var payment = $('input:checkbox[name="cashier_selection"]:checked').val();
        // todo
        if (payment == 'wxpay') {
            window.open('${zl.web.pays.domain}/wxpay/entry/scanPay2SelfForServer.action?shopcodecharge=' + shopcode + '&businesscode=' + billcode + '&payamount=' + payamount + '&businessorigin=srvms-serverRecharge') ;
        } else {
            window.open('${zl.web.pays.domain}/alipay/entry/scanPay2SelfForServer.action?shopcodecharge=' + shopcode + '&businesscode=' + billcode + '&payamount=' + payamount + '&businessorigin=srvms-serverRecharge') ;
        }
    }
    
    function showOrHideDetail() {
        // 获取当前状态
        if($("#renewDetail").is(":hidden")){// 隐藏
            $("#renewDetail").show();

        }else {// 显示
            $("#renewDetail").hide();
        }
    }

</script>
</@override>
<@override name="window">
</@override>
<@extends name="../base_main.ftl"/>
