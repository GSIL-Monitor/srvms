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
<#-- 图片的js -->
<script>
    function returnWorkOrder() {
        window.location.href = '${ctxPath}/workorder/workOrderManage.action';
    }

    // 弹窗
    function checkServiceParts() {
        $("#price_model").modal("show");
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
</script>
</@override>
<@override name="right">
    <div class="panel panel-default">
        <div class="col-md-9">
            <label class="control-label col-md-3">维修工单-详情</label>
        </div>
    </div>
        <div class="panel-body">
            <div class="form-body">
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="control-label col-md-12">工单信息</label>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="control-label col-md-2">工单编号：</label>
                        <div class="col-md-4">
                             ${workOrderDetails.workordercode!''}
                        </div>
                        <label class="control-label col-md-2">工单标题：</label>
                        <div class="col-md-4">
                            ${workOrderDetails.workordertitle!''}
                        </div>
                    </div>
                </div>
                <#if (workOrderDetails.workordertype!'') == '0'>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-2">故障软件：</label>
                            <div class="col-md-4">
                                ${workOrderDetails.componentname!''}
                            </div>
                            <label class="control-label col-md-2">故障用户：</label>
                            <div class="col-md-4">
                                ${workOrderDetails.faultusers!''}
                            </div>
                        </div>
                    </div>
                </#if>

                <#if (workOrderDetails.workordertype!'') == '1'>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-2"> 设备类型：</label>
                            <div class="col-md-4">
                               <#if  (workOrderDetails.productcategory!'') == '1'>
                                    收银机
                                   <#elseif  (workOrderDetails.productcategory!'') == '2'>
                                    广告机
                               </#if>
                            </div>
                            <label class="control-label col-md-2">设备型号：</label>
                            <div class="col-md-4">
                                ${workOrderDetails.productmodel!''}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-2"> 设备唯一码：</label>
                            <div class="col-md-10">
                                ${workOrderDetails.devicecode!''}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-2"> 设备配件：</label>
                            <div class="col-md-10">
                                <div class="table-scrollable">
                                    <table class="table table-hover table-bordered">
                                        <thead>
                                        <tr>
                                            <th> 序号</th>
                                            <th> 配件名称</th>
                                            <th> 版本型号</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                             <#if  workOrderDetails.hardwareDevicePartsDetail?? && workOrderDetails.hardwareDevicePartsDetail?size gt 0>
                                                <#list workOrderDetails.hardwareDevicePartsDetail as hardwareDevicePartsDetail>
                                                    <tr>
                                                        <td> ${hardwareDevicePartsDetail_index+1}</td>
                                                        <td> ${hardwareDevicePartsDetail.productname}</td>
                                                        <td> ${hardwareDevicePartsDetail.versionmodel}</td>
                                                    </tr>
                                                </#list>
                                             </#if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </#if>
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="control-label col-md-2">申请人：</label>
                        <div class="col-md-4">
                            ${workOrderDetails.createuser!''}
                        </div>
                        <label class="control-label col-md-2">创建时间：</label>
                        <div class="col-md-4">
                            ${workOrderDetails.createtime!''}
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="control-label col-md-2">故障门店：</label>
                        <div class="col-md-4">
                            ${workOrderDetails.shopname!''}_${workOrderDetails.branchname!''}&nbsp;
                            <#if (workOrderDetails.dutyperson!'') != ''>
                                ${workOrderDetails.dutyperson!''}
                            </#if>
                            <#if (workOrderDetails.dutypersonnum!'') != ''>
                              (${workOrderDetails.dutypersonnum!''})
                            </#if>
                        </div>
                        <label class="control-label col-md-2">处理状态：</label>
                        <div class="col-md-4">
                            <#if (workOrderDetails.workorderstatus!'') == "0">
                                待处理
                            <#elseif (workOrderDetails.workorderstatus!'') == "1">
                                处理中
                            <#elseif (workOrderDetails.workorderstatus!'') == "2">
                                运营待处理
                            <#elseif (workOrderDetails.workorderstatus!'') == "3" || (workOrderDetails.workorderstatus!'') == "4">
                                运营处理中
                            <#elseif (workOrderDetails.workorderstatus!'') == "5">
                                待返修
                            <#elseif (workOrderDetails.workorderstatus!'') == "9">
                                返修完成
                            <#elseif (workOrderDetails.workorderstatus!'') == "6" || (workOrderDetails.workorderstatus!'') == "7" || (workOrderDetails.workorderstatus!'') == "8">
                                已完成
                            </#if>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="control-label col-md-2">故障描述：</label>
                        <div class="col-md-10">
                            ${workOrderDetails.faultdescribe!''}
                        </div>
                    </div>
                </div>

                <div class="col-md-12">
                    <div class="form-group">
                        <label class="control-label col-md-2">图片：</label>
                        <div class="col-md-10">
                            <#if imageUrls?? && imageUrls?size gt 0>
                                <ul class='carouselbox'>
                                     <#list imageUrls as imageUrl>
                                         <li>
                                             <div class="carselconborder">
                                                  <img src="${imageUrl!''}" alt="" class="previewimg" style="margin-top: 0px; ">
                                             </div>
                                         </li>
                                     </#list>
                                </ul>
                            </#if>
                        </div>
                    </div>
                </div>
                <#if workOrderDetails.serverHandleInfo?? && workOrderDetails.serverHandleInfo?size gt 0>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-12">服务商处理结果</label>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-2">处理方式：</label>
                            <div class="col-md-4">
                                <#if (workOrderDetails.serverHandleInfo.resultcode!'') == '0'>
                                    自行处理
                                    <#elseif (workOrderDetails.serverHandleInfo.resultcode!'') == '1'>
                                        反馈上级
                                </#if>
                            </div>
                            <label class="control-label col-md-2">处理时间：</label>
                            <div class="col-md-4">
                               ${workOrderDetails.serverHandleInfo.createtime!''}
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-2">反馈描述：</label>
                            <div class="col-md-9">
                                ${workOrderDetails.serverHandleInfo.serverdescribe!''}
                            </div>
                        </div>
                    </div>
                </#if>
                <#if workOrderDetails.companyHandleInfo?? && workOrderDetails.companyHandleInfo?size gt 0>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-12">运营处理结果</label>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-2">处理时间：</label>
                            <div class="col-md-4">
                                ${workOrderDetails.companyHandleInfo.createtime!''}
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-2">反馈描述：</label>
                            <div class="col-md-4">
                                ${workOrderDetails.companyHandleInfo.outdescribe!''}
                            </div>
                        </div>
                        <#if (workOrderDetails.workorderstatus!'') == '5'>
                              <div class="form-group">
                                  <label class="control-label col-md-2">工厂联系人：</label>
                                  <div class="col-md-4">
                                      ${workOrderDetails.serviceAddr.companycontacts!''}
                                  </div>
                                  <label class="control-label col-md-2">工厂联系电话：</label>
                                  <div class="col-md-4">
                                      ${workOrderDetails.serviceAddr.companycontactstel!''}
                                  </div>
                              </div>
                             <div class="form-group">
                                 <label class="control-label col-md-2">工厂地址：</label>
                                 <div class="col-md-4">
                                     ${workOrderDetails.serviceAddr.companyaddress!''}
                                 </div>
                                 <label class="control-label col-md-2">返修价格参考表：</label>
                                 <div class="col-md-4">
                                     <a href="javascript:void(0)" style="color: blue;" onclick="checkServiceParts()" >查看</a>
                                 </div>
                             </div>
                        </#if>
                    </div>
                </#if>
                <div class="form-actions">
                    <div class="row">
                        <input type="button" onclick="returnWorkOrder()" style="margin-left:10px;" value="返回"
                               class="btn btn-default">
                    </div>
                </div>
            </div>
        </div>
    </div>
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
                                                <th> 部件参数</th>
                                                <th> 单价（元）</th>
                                                <th class="partsNum"> 数量</th>
                                                <th class="partsTotalPrice"> 小计（元）</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                                 <#if  workOrderDetails.serviceWorkOrderPrice?? && workOrderDetails.serviceWorkOrderPrice?size gt 0>
                                                    <#list workOrderDetails.serviceWorkOrderPrice as serviceWorkOrderPrice>
                                                        <tr>
                                                             <td> ${serviceWorkOrderPrice_index+1}</td>
                                                             <td> ${serviceWorkOrderPrice.productname}</td>
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
</@override>
<@extends name="../base_main.ftl"/>