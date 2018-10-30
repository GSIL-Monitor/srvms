<#include "../default_cfg.ftl"/>
<@override name="jsfile">
    <script src="../assets/layer/layer.js" type="text/javascript"></script>
    <script src="../js/jquery.form.js" type="text/javascript"></script>
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

        $(".form_datetime").datetimepicker({
            format: 'Y-m-d H:i',//显示格式
            lang: "zh",
            minView:0,
            startView:0,
            step:1,
            showSecond: true,
        });


        $("ul").on("change", ".carselcon",togglePic ); //图片替换
        function togglePic(){
            console.log(this.files[0]);
            var srcs = getObjectURL(this.files[0]);   //获取路径
            $(this).siblings('p').hide();//隐藏+号，文字
            $(this).siblings('img').attr("src", srcs);//展示图片
            $(this).siblings('img').show();
        }
        $("ul").on("click", ".carselpreview",function () { //图片预览
            var imgdiv=$(this).parent('.previewimgbtn').siblings('.carselconborder').children('.previewimg');
            console.log(imgdiv.attr('src'));
            if(imgdiv.attr('src')){
                //页面层-
                let picHtml='<img src="'+imgdiv.attr("src")+'" alt="" style="width: 700px;height: 500px" >';
                layer.open({
                    type: 1,
                    title: false,
                    closeBtn: 0,
                    area: ['700px', '500px'],
                    skin: 'layui-layer-nobg', //没有背景色
                    shadeClose: true,
                    content:picHtml
                });
            }else {
                layer.msg('您还未上传图片，无法预览', {icon: 5});
            }
            //icon= 0-叹号；1-对号；2-×号；3-问号；4-锁号；5-哭脸；6-笑脸
        } );
        $("ul").on("click", ".carseldelete",function () { //图片删除
            console.log($(this).text());
            console.log($(this).parent('.previewimgbtn').parent('li'));
            $(this).parent('.previewimgbtn').parent('li').remove();
        } );

        $('#carouselplus').on('click',function () {  //添加一个轮播图框
            var numarr=$('.carselhead>span');
            var index;
            if(!$('.carselhead>span').text()){
                index=1;
            }else {
                index=Number($(numarr[numarr.length - 1]).text())+1;
            }
            var imgHtml='<li>' +
                    '<div class="carselconborder">' +
                    '<input type="file" name="upfiles" accept="image/png, image/jpeg, image/gif, image/jpg"'+
                    'class="carselcon"/>'+
                    '<p class="carselplus">+</p>'+
                    '  <p>点击上传图片</p>'+
                    '    <img hidden src="" alt="" class="previewimg">'+
                    '</div>'+
                    '<div class="previewimgbtn">'+
                    '<div class="carselcheck carselpreview">预览</div>'+
                    ' <div class="carselcheck carseldelete">删除</div>'+
                    '</div>'+
                    ' </li>';
            $('ul.carouselbox').children("li:last-child").before(imgHtml);
        })
    });
    function selectPayMentod(e) {
        var payMentod = $(e).val();
        if (payMentod == '0'){
            $("#onLineDiv").show();
            $("#offLineDiv").hide();
        }
        if (payMentod == '1'){
            $("#onLineDiv").hide();
            $("#offLineDiv").show();
        }
    }

    function getObjectURL(file) {  //获取上传的URL
        var url = null;
        if (window.createObjectURL != undefined) {
            url = window.createObjectURL(file)
        } else if (window.URL != undefined) {
            url = window.URL.createObjectURL(file)
        } else if (window.webkitURL != undefined) {
            url = window.webkitURL.createObjectURL(file)
        }
        return url;
    };
</script>
</@override>
<@override name="right">
    <div class="tab-pane" id="pane">
        <div class="portlet light portlet-fit portlet-form">
            <div class="portlet-title">
                <div class="caption font-dark">
                    <span class="caption-subject bold uppercase main-content-title">确认付款</span>
                </div>
            </div>
            <div class="portlet-body form">
                <div class="form-body">
                    <div class="row col-md-8">
                        <div class="form-group">
                            <label class="control-label col-md-12">
                                <h5 style="font-weight:bold">▉实际维修价格清单</h5>
                            </label>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <div class="table-scrollable">
                                    <table class="table table-hover table-bordered">
                                        <thead>
                                        <tr>
                                            <th> 序号</th>
                                            <th> 配件名称</th>
                                            <th> 版本型号</th>
                                            <th> 配置参数</th>
                                            <th> 单价（元）</th>
                                            <th> 数量</th>
                                            <th> 小计（元）</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                             <#if priceResult?? && priceResult?size gt 0>
                                                <#list priceResult as priceDetail>
                                                    <tr>
                                                        <td> ${priceDetail_index+1}</td>
                                                        <td> ${priceDetail.productname}</td>
                                                        <td> ${priceDetail.versionmodel}</td>
                                                        <td> ${priceDetail.productarg}</td>
                                                        <td> ${priceDetail.saleprice}</td>
                                                        <td> ${priceDetail.nums}</td>
                                                        <td> ${priceDetail.totalprice}</td>
                                                    </tr>
                                                </#list>
                                                 <tr>
                                                     <td></td>
                                                     <td> </td>
                                                     <td> </td>
                                                     <td></td>
                                                     <td>总计:</td>
                                                     <td> ${totalnums}</td>
                                                     <td> ${totalamount}</td>
                                                 </tr>
                                             <#else>
                                                  <tr>
                                                      <td colspan="7">暂无数据</td>
                                                  </tr>
                                             </#if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <form action="${ctxPath}/serviceBill/saveServiceBillPaymentMethod.action" method="post"  role="form" enctype="multipart/form-data" id="submitForm">
                            <input hidden name="paycode" value="${paymentDetail.paycode}" id="paycode"  />
                            <input hidden name="shopcode" value="${paymentDetail.shopcode}" id="shopcode"  />
                            <input hidden name="branchcode" value="${paymentDetail.branchcode}" id="branchcode"  />
                            <input hidden name="ordercode" value="${paymentDetail.ordercode}" id="ordercode"  />
                            <input hidden name="servicebillcode" value="${paymentDetail.servicebillcode}" id="ordercode"  />
                            <div class="form-group">
                                <label class="control-label col-md-12"><h5 style="font-weight:bold">▉收款账号</h5></label>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label col-md-2">收款银行:</label>
                                    <div class="col-md-4">
                                        ${paymentDetail.duebank!''}
                                    </div>
                                    <label class="control-label col-md-2">收款账户:</label>
                                    <div class="col-md-4">
                                        ${paymentDetail.dueaccount!''}
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label col-md-2">收款账号:</label>
                                    <div class="col-md-4">
                                        ${paymentDetail.dueusername!''}
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-12"><h5 style="font-weight:bold">▉付款</h5></label>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label col-md-2">支付方式:</label>
                                    <div class="col-md-4">
                                        <label class="radio-inline">
                                            <input type="radio" onclick="selectPayMentod(this)" name="paymentmethod" id="online" value="0" checked> 线上支付
                                        </label>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="radio-inline">
                                            <input type="radio"  onclick="selectPayMentod(this)"  name="paymentmethod" id="offline"  value="1"> 线下支付
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12" id="onLineDiv">
                                <input type="text" hidden value="orderCode">
                                <input type="text" hidden value="">
                                <div class="form-group">
                                    <label class="control-label col-md-2"></label>
                                    <div class="col-md-4">
                                        <label class="radio-inline">
                                            <input type="radio" name="payMethod" id="alipay"  value="1" checked> 支付宝
                                            <img src="http://091801.zhonglunnet.com/web/images/ali_pay.png">
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-2"></label>
                                    <div class="col-md-4">
                                        <label class="radio-inline">
                                            <input type="radio" name="payMethod" id="vxpay" value="0"> 微信
                                            <img src="http://091801.zhonglunnet.com/web/images/wx_pay.png">
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12" hidden id="offLineDiv">
                                <div class="form-group">
                                    <label class="control-label col-md-2"><span style="color:red">*</span>转账方式:</label>
                                    <div class="col-md-4">
                                        <select class="form-control" id="transfermethod" name="transfermethod">
                                                <option value="0">银行转账</option>
                                                <option value="1">支付宝</option>
                                                <option value="2">微信</option>
                                                <option value="3">其他</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-2"><span style="color:red">*</span>支付时间:</label>
                                    <div class="col-md-4">
                                        <input type="text" name="paytime" id="paytime"
                                               value=""
                                               placeholder="请选择日期"
                                               readonly="readonly" class="form_datetime form-control"
                                               style="padding-left:12px;" >
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-2"><span style="color:red">*</span>支付凭证:</label>
                                    <div class="col-md-10" id="payOrder">
                                        <div class="col-md-12">
                                            <ul class='carouselbox'>
                                                <li>
                                                    <div class='carselconborder'>
                                                        <input type="file" name="upfiles" accept="image/png, image/jpeg, image/gif, image/jpg"
                                                        class="carselcon"/>
                                                        <p class="carselplus" style="margin-top: -150PX">+</p>
                                                        <p>点击上传图片</p>
                                                        <img hidden src="" alt="" class="previewimg">
                                                    </div>
                                                    <div class="previewimgbtn">
                                                        <div class="carselcheck carselpreview">预览</div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-2">备注:</label>
                                    <div class="col-md-4">
                                        <div class="input-txt">
                                            <textarea name="remake" id="remake" class="form-control" rows="4" style="width: 250px" placeholder="请输入不超过500字备注"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-actions">
                                <div class="row">
                                    <div class="col-md-offset-3 col-md-9">
                                        <input type="button" value="提交" class="btn btn-primary col-lg-1" onclick="saveServiceBillPaymentMethod()">
                                        <input type="button" onclick="returnServiceBill()" style="margin-left:10px;" value="返回"
                                               class="btn btn-default">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
<script>
    $("input:radio[name=paymentmethod]").on("click",function () {
       var paymentMethod =  $("input:radio[name=paymentmethod]:checked");
       if (paymentMethod == '0'){
           $(".onLineDiv").show();
           $(".offLineDiv").hide();
       }else if (paymentMethod == '1'){
           $(".onLineDiv").hide();
           $(".offLineDiv").show();
       }
    })
    
    function saveServiceBillPaymentMethod() { // 提交表单
        var paymentMethod =  $("input:radio[name=paymentmethod]:checked").val();
        // 当前支付
        if (paymentMethod == '1'){// 校验参数
            var transfermethod = $("#transfermethod").val();
            var paymenttime = $("#paytime").val();
            if (!transfermethod){
                AlertMsg("请选择支付方式");
                return;
            }
            if (!paymenttime){
                AlertMsg("请选择支付时间");
                return;
            }
            var src = $('#payOrder').find("img.previewimg").attr('src');
            if(!src){
                AlertMsg('你有未上传的图片框，请先上传图片!');
                return;
            }
            var formtFlag = false;
            $('#payOrder').find("input[name=upfiles]").each(function () {
                var filePath = $(this).val();
                var fileType = getFileType(filePath);
                //console.log(fileType);
                //判断上传的附件是否为图片
                if("jpg" != fileType && "jpeg" != fileType  && "png" != fileType) {
                    $("#image").val("");
                    AlertMsg("请上传JPG,JPEG,PNG格式的图片");
                    formtFlag = false;
                    return false;
                }
                //获取附件大小（单位：KB）
                var fileSize = this.files[0].size / 1024;
                if(fileSize > 5120) {
                    AlertMsg("图片大小不能超过5MB");
                    formtFlag = false;
                    return false;
                }

                formtFlag = true;
            });
            if (!formtFlag){
                return false;
            }

            var ajax_option={
                success:function(data){
                    var result = eval(data);
                    if (result.success) {
                        AlertMsg(result.data, function () {
                            window.location.href = '${ctxPath}/serviceBill/toServiceBillManage.action'
                        });
                    }
                }
            };
            $('#submitForm').ajaxSubmit(ajax_option);
        }else{
            var shopcode = $("#shopcode").val();
            var ordercode = $("#paycode").val();
            var businesscode = $("#ordercode").val();
            var branchcode = $("#branchcode").val();
            var payMethod =  $("input:radio[name=payMethod]:checked").val();
            // 支付宝
            if (payMethod == "1") {
                window.location.href =
                        'http://lsdev.cnzhonglunnet.com//mt/web/alipay/entry/scanPay2SelfForServer.action?shopcodecharge=' +
                        shopcode +
                        "&branchcode=" +
                        branchcode +
                        "&ordercode=" +
                        ordercode +
                        "&businesscode=" +
                        businesscode +
                        "&businessorigin=bugms-service";
            } else if (payMethod == "0") {
                // 微信
                window.location.href =
                        'http://lsdev.cnzhonglunnet.com//mt/web/system/wxpay/entry/scanPay2SelfForServer.action?shopcodecharge=' +
                        shopcode +
                        "&branchcode=" +
                        branchcode +
                        "&ordercode=" +
                        ordercode +
                        "&businesscode=" +
                        businesscode +
                        "&businessorigin=bugms-service";
            }
        }
    }

    function getFileType(filePath) {
        var startIndex = filePath.lastIndexOf(".");
        if(startIndex != -1)
            return filePath.substring(startIndex + 1, filePath.length).toLowerCase();
        else return "";
    }

</script>
</@override>
<@override name="window">

</@override>
<@extends name="../base_main.ftl"/>