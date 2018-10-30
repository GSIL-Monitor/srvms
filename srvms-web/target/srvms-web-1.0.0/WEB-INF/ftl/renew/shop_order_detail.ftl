<@override name="jstext">
<script>
    function back() {
      window.location='${ctxPath}/renew/order/orderManage.action';
    }
</script>
</@override>
<@override name="right">
<div class="row">
    <div class="col-md-12">
        <div class="portlet light ">
            <div class="portlet-title">
                <div class="caption font-dark">
                    <span class="caption-subject bold uppercase main-content-title">订单查询-详情</span>
                </div>
            </div>
            <div class="panel-body">
                <div class="col-md-12">
                    <label class="control-label col-md-12" style="padding-left: 0px"><h5 style="font-weight:bold"><img src="${ctxPath}/images/label.png" style="width: 5px;margin-right: 5px;"/>订单信息</h5></label>
                    <div class="col-md-12" style="padding-left: 0px;margin-top: 20px">
                        <div class="col-md-4" style="padding-left: 0px;">
                            订单编号：${merchantDetail[0].billcode!''}
                        </div>
                        <div class="col-md-4">
                            订单状态：
                            <#if ((merchantDetail[0].status!'') == '0')>
                                    待支付
                                <#elseif ((merchantDetail[0].status!'') == '1')>
                                    已完成
                                <#elseif ((merchantDetail[0].status!'') == '2')>
                                    已失效
                            </#if>
                        </div>
                        <div class="col-md-4">
                            订单总金额：${merchantDetail[0].totalamount!''}元
                        </div>
                    </div>
                    <div class="col-md-12"  style="padding-left: 0px;margin-top: 20px">
                        <div class="col-md-4" style="padding-left: 0px;">
                            下单时间：${merchantDetail[0].createtime!''}
                        </div>
                        <div class="col-md-4">
                            购买人：${merchantDetail[0].createusername!''}
                        </div>
                        <div class="col-md-4">
                            支付时间：${merchantDetail[0].paytime!''}
                        </div>
                    </div>
                </div>
                <div class="col-md-12" style="margin-top: 20px">
                    <label class="control-label col-md-12" style="padding-left: 0px"><h5 style="font-weight:bold"><img src="${ctxPath}/images/label.png" style="width: 5px;margin-right: 5px;"/>商品信息</h5></label>
                    <div class="table-scrollable" style="margin-top: 20px">
                        <table class="table table-hover table-bordered" style="margin-top: 20px">
                            <thead>
                            <tr>
                                <th width="48px"> 序号</th>
                                <th> 商户ID</th>
                                <th> 商户名称</th>
                                <#if (merchantDetail[0].branchname!'') != 'undefined'&&(merchantDetail[0].branchname!'') != ''>
                                    <th> 门店编号</th>
                                    <th> 门店名称</th>
                                </#if>
                                  <#if (merchantDetail[0].saleassistantcode!'') != 'undefined'&&(merchantDetail[0].saleassistantcode!'') != ''>
                                    <th> 营销助手码</th>
                                  </#if>

                                <th> 产品名称</th>
                                <th> 购买年限</th>
                                <th> 折扣%</th>
                                <th> 价格（元）</th>
                            </tr>
                            </thead>
                            <tbody>
                                <#if merchantDetail??>
                                    <#list merchantDetail as order>
                                        <tr>
                                            <td>${order_index + 1} </td>
                                            <td>${order.shopcode!''}</td>
                                            <td>${order.shopname!''}</td>
                                            <#if (order.branchname!'') != 'undefined'&&(order.branchname!'') != ''>
                                                <td>${order.branchcode!''}</td>
                                                <td>${order.branchname!''}</td>
                                            </#if>
                                             <#if (order.saleassistantcode!'') != 'undefined'&&(order.saleassistantcode!'') != ''>
                                                <td>${order.saleassistantcode!''}</td>
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
                <div class="col-md-6" style="margin-top: 50px">
                    <button type="button"  class="btn btn-primary btn-default  center-block" id = "sumbitButton" style="margin-right: 10px;" onclick="back()">返回</button>
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