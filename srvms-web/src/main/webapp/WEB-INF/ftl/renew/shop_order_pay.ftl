<@override name="jstext">
<script>
    function submitOrder() {
        var shopcode = $("#servercode").val();
        var ordercode = $("#ordercode").val();
        var businesscode = $("#billcode").val();
        var payMethod =  $("input:radio[name=payMethod]:checked").val();
        // 支付宝
        if (payMethod == "1") {
            window.location.href =
                    '${zl.web.pays.domain}/mt/web/alipay/entry/scanPay2SelfForServer.action?shopcodecharge=' +
                    shopcode +
                    "&branchcode=" +
                    "&ordercode=" +
                    ordercode +
                    "&businesscode=" +
                    businesscode +
                    "&businessorigin=srvms-serverRecharge";
        } else if (payMethod == "0") {
            // 微信
            window.location.href =
                    '${zl.web.pays.domain}/mt/web/system/wxpay/entry/scanPay2SelfForServer.action?shopcodecharge=' +
                    shopcode +
                    "&branchcode=" +
                    "&ordercode=" +
                    ordercode +
                    "&businesscode=" +
                    businesscode +
                    "&businessorigin=srvms-serverRecharge";
        }
    }
</script>
</@override>
<@override name="right">
<div class="row">
    <div class="col-md-12">
        <div class="portlet light ">
            <div class="portlet-title">
                <div class="caption font-dark">
                    <span class="caption-subject bold uppercase main-content-title">商户续费-支付</span>
                </div>
            </div>
            <div class="panel-body">
                <div class="col-md-12">
                    <div class="col-md-4" style="padding-left: 0px;">
                        <input type="text" hidden value="${orderInfo[0].billcode!''}" id="billcode">
                        <input type="text" hidden value="${servercode!''}" id="servercode">
                        <input type="text" hidden value="${orderInfo[0].ordercode!''}" id="ordercode">
                        <h5 style="font-weight: bolder">订单编号：${orderInfo[0].billcode!''}</h5>
                    </div>
                    <div class="col-md-4">
                        <h5 style="font-weight: bolder">总价：${orderInfo[0].totalamount!''}</h5>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="table-scrollable">
                        <table class="table table-hover table-bordered">
                            <thead>
                            <tr>
                                <th width="48px"> 序号</th>
                                <th> 商户ID</th>
                                <th> 商户名称</th>
                                <#if (orderInfo[0].branchname!'') != 'undefined'>
                                    <th> 门店编号</th>
                                    <th> 门店名称</th>
                                 </#if>
                                <th> 产品名称</th>
                                <th> 购买年限</th>
                                <th> 折扣%</th>
                                <th> 价格（元）</th>
                            </tr>
                            </thead>
                            <tbody>
                                <#if orderInfo??>
                                    <#list orderInfo as order>
                                        <tr>
                                            <td>${order_index + 1} </td>
                                            <td>${order.shopcode!''}</td>
                                            <td>${order.shopname!''}</td>
                                            <#if (order.branchname!'') != 'undefined'>
                                                <td>${order.branchcode!''}</td>
                                                <td>${order.branchname!''}</td>
                                            </#if>
                                            <td>${order.productname!''}</td>
                                            <td>
                                                <#if (order.renewtime!'') != ''>
                                                    ${order.renewtime!''}年
                                                    <#else >
                                                        永久
                                                </#if>
                                            </td>
                                            <td>${order.discount!''}</td>
                                            <td>${order.payprice!''}</td>
                                        </tr>
                                    </#list>
                                </#if>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-md-12">
                    <label class="control-label col-md-12" style="padding-left: 0px"><h5 style="font-weight:bold"><img src="${ctxPath}/images/label.png" style="width: 5px;margin-right: 5px;"/>选择支付方式</h5></label>
                    <div class="col-md-4">
                        <label class="radio-inline">
                            <input type="radio" name="payMethod" id="alipay"  value="1" checked> 支付宝
                            <img src="${zl.web.resource.address}/images/ali_pay.png">
                        </label>
                    </div>
                    <div class="col-md-4">
                        <label class="radio-inline">
                            <input type="radio" name="payMethod" id="vxpay" value="0"> 微信
                            <img src="${zl.web.resource.address}/images/wx_pay.png">
                        </label>
                    </div>
                </div>
                <div class="col-md-6" style="margin-top: 50px">
                    <button type="button"  class="btn btn-primary btn-default  center-block" id = "sumbitButton" style="margin-right: 10px;" onclick="submitOrder()">立即支付</button>
                </div>
            </div>
        </div>
    </div>
</div>
</@override>
<@override name="window">
    <#include "../choose_single_shop.ftl" />
</@override>
<@extends name="../base_main.ftl"/>