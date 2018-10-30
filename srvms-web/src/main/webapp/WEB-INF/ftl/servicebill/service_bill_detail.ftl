<#include "../default_cfg.ftl"/>
<@override name="jsfile">
    <script src="../assets/layer/layer.js" type="text/javascript"></script>
</@override>
<@override name="cssfile">
    <link rel="stylesheet" href="../assets/css/font-awesome.min.css"/>
    <link href="../assets/css/codemirror.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/ace.min.css"/>
    <link rel="stylesheet" href="../font/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="../css/style.css">
</@override>
<@override name="jstext">
    <script>
        function returnServiceBill() {
            window.location.href = '${ctxPath}/serviceBill/toServiceBillManage.action'
        }
        $(function () {
            $("ul").on("click", ".carselconborder", function () { //图片预览
                var imgdiv = $(this).children('.previewimg');
                if (imgdiv.attr('src')) {
                    //页面层-
                    let picHtml = '<img src="' + imgdiv.attr("src") + '" alt="" style="width: 700px;height: 500px" >';
                    layer.open({
                        type: 1,
                        title: false,
                        closeBtn: 0,
                        area: ['700px', '500px'],
                        skin: 'layui-layer-nobg', //没有背景色
                        shadeClose: true,
                        content: picHtml
                    });
                } else {
                    layer.msg('您还未上传图片，无法预览', {icon: 5});
                }
                //icon= 0-叹号；1-对号；2-×号；3-问号；4-锁号；5-哭脸；6-笑脸
            });
        });

        function localPrice(){
            $("#price_model").modal('show');
        }

    </script>
</@override>
<@override name="right">
<form action="${ctxPath}/serviceBill/saveServiceBill.action" method="post" role="form" id="submitForm">
    <input type="text" hidden name="workordercode" id="workordercode" />
    <div class="tab-pane" id="pane">
        <div class="portlet light portlet-fit portlet-form">
            <div class="portlet-title">
                <div class="caption font-dark">
                    <span class="caption-subject bold uppercase main-content-title">设备返修-详情</span>
                </div>
            </div>
            <div class="portlet-body form">
                <div class="col-md-12">
                    <div class="form-body">
                        <div class="form-group">
                            <label class="control-label col-md-12">
                                <h5 style="font-weight:bold">▉返修设备信息</h5>
                            </label>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">设备类型：</label>
                                <div class="col-md-4">
                                   <#if (serviceBillDetail.productcategory!'') == '1'>
                                        收银机
                                       <#elseif (serviceBillDetail.productcategory!'') == '2'>
                                        广告机
                                   </#if>
                                </div>
                                <label class="control-label col-md-2">设备型号：</label>
                                <div class="col-md-4">
                                    ${serviceBillDetail.productmodel!''}
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">故障门店：</label>
                                <div class="col-md-4">
                                    ${serviceBillDetail.shopname!''}- ${serviceBillDetail.branchname!''}&nbsp;${serviceBillDetail.dutyperson!''}(${serviceBillDetail.dutypersonnum!''})
                                </div>
                                <label class="control-label col-md-2">设备唯一码：</label>
                                <div class="col-md-4">
                                    ${serviceBillDetail.devicecode!''}
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">故障描述：</label>
                                <div class="control-label col-md-10">
                                    ${serviceBillDetail.faultdescribe!''}
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">工厂联系人：</label>
                                <div class="col-md-4">
                                    ${serviceBillDetail.companycontacts!''}
                                </div>
                                <label class="control-label col-md-2">工厂联系电话：</label>
                                <div class="col-md-4">
                                    ${serviceBillDetail.companycontactstel!''}
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">工厂地址：</label>
                                <div class="col-md-4">
                                    ${serviceBillDetail.companyaddress!''}
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-12">
                                <h5 style="font-weight:bold">▉收货地址<span style="color: #CCCCFF;font-size: 2px">(维修后的设备接收地址)</span>
                                </h5>
                            </label>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">联系人：</label>
                                <div class="col-md-4">
                                    ${serviceBillDetail.customcontacts!''}
                                </div>
                                <label class="control-label col-md-2">联系人手机：</label>
                                <div class="col-md-4">
                                    ${serviceBillDetail.customcontactstel!''}
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">收货地址：</label>
                                <div class="col-md-4">
                                    ${serviceBillDetail.customaddress!''}
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">备注：</label>
                                <div class="col-md-4">
                                    ${serviceBillDetail.customeraddressremake!''}
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-12">
                                <h5 style="font-weight:bold">▉返修物流<span style="color: #CCCCFF;font-size: 2px">(设备发往工厂的物流)</span>
                                </h5>
                            </label>
                        </div>
                        <div class="form-group col-md-12">
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">快递单号：</label>
                                <div class="col-md-4">
                                    ${serviceBillDetail.customcourier!''}
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">备注：</label>
                                <div class="col-md-4">
                                    ${serviceBillDetail.customerbillremake!''}
                                </div>
                            </div>
                        </div>
                        <#if  (serviceBillDetail.paystatus!'') == '1' >
                             <div class="form-group">
                                <label class="control-label col-md-12">
                                    <h5 style="font-weight:bold">▉付款信息</h5>
                                </label>
                             </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">支付方式：</label>
                                <div class="col-md-4">
                                    <#if (serviceBillDetail.paymethod!'') == '0'>
                                        线上
                                    <#elseif (serviceBillDetail.paymethod!'') == '1'>
                                        线下
                                    </#if>
                                </div>
                                <label class="control-label col-md-2">转账方式：</label>
                                <div class="col-md-4">
                                        <#if (serviceBillDetail.paymentmethod!'') == '1'>
                                            支付宝
                                        <#elseif (serviceBillDetail.paymentmethod!'') == '2'>
                                            微信
                                        <#elseif (serviceBillDetail.paymentmethod!'') == '0'>
                                            银行转账
                                        <#elseif (serviceBillDetail.paymentmethod!'') == '3'>
                                            其他
                                        </#if>
                                </div>
                            </div>
                           <div class="form-group col-md-12">
                               <label class="control-label col-md-2">支付时间：</label>
                               <div class="col-md-4">
                                   ${serviceBillDetail.paytime!''}
                               </div>
                           </div>
                            <#if (serviceBillDetail.paymethod!'') == '1'>
                                <div class="form-group col-md-12">
                                    <label class="control-label col-md-2">收款银行：</label>
                                    <div class="col-md-4">
                                        ${serviceBillDetail.duebank!''}
                                    </div>
                                    <label class="control-label col-md-2">收款账户：</label>
                                    <div class="col-md-4">
                                        ${serviceBillDetail.dueusername!''}
                                    </div>
                                </div>
                                 <div class="form-group col-md-12">
                                     <label class="control-label col-md-2">收款帐号：</label>
                                     <div class="col-md-4">
                                         ${serviceBillDetail.dueaccount!''}

                                     </div>
                                 </div>
                            </#if>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">维修价格清单：</label>
                                <div class="col-md-4">
                                    <a href="#" style="color:blue;" onclick="localPrice()">查看</a>
                                </div>
                            </div>
                            <#if (serviceBillDetail.paymethod!'') == '1'>
                              <div class="form-group col-md-12">
                                  <label class="control-label col-md-2">支付凭证：</label>
                                  <div class="col-md-4">
                                      <ul class='carouselbox'>
                                         <li>
                                             <div class="carselconborder">
                                                 <img src="${serviceBillDetail.paymentdocument!''}" alt="" class="previewimg" style="margin-top: 0px; ">
                                             </div>
                                         </li>
                                      </ul>
                                  </div>
                              </div>
                            </#if>
                        </#if>
                        <#if (serviceBillDetail.servicebillstatus) == '6' || (serviceBillDetail.servicebillstatus) == '7'>
                             <div class="form-group">
                                 <label class="control-label col-md-12">
                                     <h5 style="font-weight:bold">▉收货信息</h5>
                                 </label>
                             </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">工厂发货快递单号：</label>
                                <div class="col-md-4">
                                    ${serviceBillDetail.companycourier!''}
                                </div>
                            </div>
                            <#if (serviceBillDetail.receivingdocument!'') != ''>
                                <div class="form-group col-md-12">
                                    <label class="control-label col-md-2">收货凭证：</label>
                                    <div class="col-md-4">
                                        <ul class='carouselbox'>
                                            <li>
                                                <div class="carselconborder">
                                                    <img src="${serviceBillDetail.receivingdocument!''}" alt="" class="previewimg" style="margin-top: 0px; ">
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </#if>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">备注：</label>
                                <div class="col-md-4">
                                    ${serviceBillDetail.companybillremake!''}
                                </div>
                            </div>
                        </#if>
                    </div>
                </div>
                <div class="form-actions">
                    <div class="row">
                            <input type="button" onclick="returnServiceBill()" style="margin-left:10px;" value="返回"
                                   class="btn btn-default">
                        </div>
                    </div>
                </div>
            </div>
        </div>
</form>
</@override>
<@override name="window">
        <div id="price_model" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
            <div class="modal-dialog" style="width: 600px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                        <h4>返修部件价格清单</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-body">
                            <div class="row">
                                <div class="table-scrollable">
                                    <table class="table table-hover table-bordered" id="serviceDevicePartsTable">
                                        <thead>
                                        <tr>
                                            <th> 序号</th>
                                            <th> 部件名称</th>
                                            <th> 版本型号</th>
                                            <th> 配置参数</th>
                                            <th> 单价（元）</th>
                                            <th> 数量</th>
                                            <th> 小计（元）</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                                 <#if  serviceBillDetail.priceParts?? && serviceBillDetail.priceParts?size gt 0>
                                                    <#list serviceBillDetail.priceParts as serviceWorkOrderPrice>
                                                        <tr>
                                                            <td> ${serviceWorkOrderPrice_index+1}</td>
                                                            <td> ${serviceWorkOrderPrice.productname}</td>
                                                            <td> ${serviceWorkOrderPrice.versionmodel}</td>
                                                            <td> ${serviceWorkOrderPrice.productarg}</td>
                                                            <td> ${serviceWorkOrderPrice.saleprice}</td>
                                                            <td> ${serviceWorkOrderPrice.nums}</td>
                                                            <td> ${serviceWorkOrderPrice.totalprice}</td>
                                                        </tr>
                                                    </#list>
                                                 <tr>
                                                     <td></td>
                                                     <td></td>
                                                     <td></td>
                                                     <td></td>
                                                     <td>总计：</td>
                                                     <td>${totalNums!''}</td>
                                                     <td>${totalPrice!''}</td>
                                                 </tr>
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
        <div id="modal_work_order" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
            <div class="modal-dialog" style="width: 900px">
                <div class="modal-content">
                    <#include '../choose_work_order.ftl'>
                </div>
            </div>
        </div>
         <div id="modal_work_order_price" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
             <div class="modal-dialog" style="width: 600px">
                 <div class="modal-content">

                 </div>
             </div>
         </div>
</@override>
</div><@extends name="../base_main.ftl"/>