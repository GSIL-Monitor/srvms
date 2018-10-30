<#include "../default_cfg.ftl"/>
<div class="panel panel-default" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
        <div class="panel-heading main-content-title"></div>
        <div class="panel-body">
            <div class="form-body">
                <div class="row">
                    <div class="col-md-10">
                        <label class="control-label col-md-3" style="color:#0000FF;font-weight:bold;font-size:16px;">订单信息</label>
                    </div>
                </div>
                </br>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <table class="table table-hover ">
                                <tr>
                                    <td>
                                        <label class="control-label col-md-12">订单编号</label>
                                    </td>
                                    <td>
                                        ${orderMainDetail.id!''}
                                    </td>
                                    <td>
                                        <label class="control-label col-md-12">购买人  </label>
                                    </td>
                                    <td>
                                        ${orderMainDetail.createuser!''}
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label class="control-label col-md-12">支付时间</label>
                                    </td>
                                    <td>
                                         ${orderMainDetail.paymenttime!''}
                                    </td>
                                    <td colspan="2">
                                        <label class="control-label col-md-12">下单时间</label>
                                    </td>
                                    <td>
                                        ${orderMainDetail.createtime!''}
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label class="control-label col-md-12">商户编号</label>
                                    </td>
                                    <td>
                                    ${orderMainDetail.shopcode!''}
                                    </td>
                                    <td colspan="2">
                                        <label class="control-label col-md-12">商户名称</label>
                                    </td>
                                    <td>
                                    ${orderMainDetail.shopname!''}
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label class="control-label col-md-12">订单状态</label>
                                    </td>
                                    <td>
                                         <#if (orderMainDetail.paystatus == "0")>
                                             待支付
                                                 <#elseif (orderMainDetail.paystatus == "5")>
                                            支付成功
                                                 <#elseif (orderMainDetail.paystatus == "4")>
                                            支付失败
                                                 <#elseif (orderMainDetail.paystatus == "8")>
                                            已失效
                                                 </#if>
                                    </td>
                                    <td colspan="2">
                                        <label class="control-label col-md-12">订单总金额</label>
                                    </td>
                                    <td>
                                    ${orderMainDetail.totalamount!''}元
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label class="control-label col-md-12">支付方式</label>
                                    </td>
                                    <td>
                                        <#if (orderMainDetail.payfunction??)>
                                    <#if (orderMainDetail.payfunction == "0")>
                                            支付宝
                                    <#elseif (orderMainDetail.payfunction == "1")>
                                            微信
                                    <#elseif (orderMainDetail.payfunction == "")>
                                    </#if>
                                        </#if>
                                    </td>
                                </tr>

                            </table>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <label class="control-label col-md-4" style="color:#0000FF;font-weight:bold;font-size:16px;">商品信息</label>
                    </div>
                </div>
                </br>
                <div class="row">
                    <div class="col-md-30">
                        <div class="form-group">
                            <div class="col-lg-15 col-xs-40 col-sm-40">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div class="tab-pane active">
                                            <div class="table-responsive">
                                                <table class="table table-hover ">
                                                    <thead>
                                                    <tr>
                                                        <th> 门店编号</th>
                                                        <th> 门店名称</th>
                                                        <th> 购买产品</th>
                                                        <th> 购买年限(年)</th>
                                                        <th> 金额(元)</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody id="branchTbody">
                                                        <#if orderItemDetail?? && orderItemDetail?size gt 0>
                                                            <#list orderItemDetail as orderItem>
                                                            <tr>
                                                                <td> ${orderItem.branchcode!""}</td>
                                                                <td> ${orderItem.branchname!""}</td>
                                                                <td> ${orderItem.productname!''}</td>
                                                                <td> ${orderItem.renewtime!''} </td>
                                                                <td> ${orderItem.subtotalamount!''}</td>
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
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-3">合计总价</label>
                            <div class="col-md-6">
                                <div class="input-group">
                                    ${orderMainDetail.totalamount!''}元
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
