<#include "../default_cfg.ftl"/>
<@override name="jsfile">
    <script src="${ctxPath}/js/jquery.form.js" type="text/javascript"></script>
</@override>
<@override name="cssfile">
    <link rel="stylesheet" href="../css/style.css">
</@override>
<@override name="jstext">
<script>
    
    function returnServiceBill() {
        window.location.href = '${ctxPath}/serviceBill/toServiceBillManage.action'
    }
    // 绑定改变事件
    $("#productcategory").on("change" ,function () {
        $('#productmodel').find("option:not(:first)").remove();
        // 获取当前的值
        var productcategory = $("#productcategory").val();
        // 查询当前产品的型号
        var url = '${ctxPath}/workorder/queryHardwareDeviceModelByType.action';
        var params = {
            productcategory: productcategory
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            var json = eval(result);
            if (json.length > 0){
                var html = '';
                for (var i = 0 ; i < json.length ;i++){
                    var productmodel = json[i].productmodel;
                    var productcode = json[i].productcode;
                    // 创建HTML
                    html+='<option id='+ productcode +' value = '+ productmodel +'>'+ productmodel +'</option>';
                }
                $('#productmodel').append(html);
            }
        })
    });

    <#-------------------------------------------------门店JS start---------------------------------------------------->
    //查询门店
    function queryBranch() {
        $('#branch_model').modal('show');
    }
    //改变背景色
    function changeBackground(e){
        $(e).parent().children("div").addClass('noSelectedBranch').removeClass('selectedBranch');
        $(e).addClass('selectedBranch').removeClass('noSelectedBranch');
    }
    // 查询店铺信息
    function findShop(){
        // 获取填写的内容
        var shopkeyword = $("#shopkeyword").val();
        var url = '${ctxPath}/workorder/queryShopByShopCodeAndShopName.action';
        var params = {
            shopkeyword: shopkeyword
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            var json = eval(result);
            if (json.length > 0){
                var shopHtml = '';
                for (var i = 0 ; i < json.length ;i++){
                    var code = json[i].shopcode;
                    var name = json[i].shopname;
                    // 创建HTML
                    shopHtml+='<div class="col-md-12 branchStyle noSelectedBranch" onclick="findBranch(this)" ><h4>';
                    shopHtml+=code+ '_' + name;
                    shopHtml+='</h4><input hidden name="shopcode" value="'+ code +'" />';
                    shopHtml+='<input hidden name="shopname" value="'+ name +'" />';
                    shopHtml+='</div>';
                }
                // 加入branch的div中  先清除
                $('.shop').find("div:not(:first)").remove();
                $('.shop').append(shopHtml);
                $('.branch').find("div:not(:first)").remove();
            }
        });
    }
    /*查询门店*/
    function findBranch(e) {
        changeBackground(e);
        // 获取当前DIV中的内容
        var shopcode = $(e).find("input[name='shopcode']").val();
        // 根据发送Ajax
        findBranchByShopCodeAndBranchCodeAndBranchName(shopcode);
    }
    function queryBranchList() {
        //　获取当前选中的shop
        var shopcode = $(".shop").find(".selectedBranch").find("input[name='shopcode']").val();
        if (!shopcode){
            AlertMsg("请先选择门店");
            return;
        }
        // 获取当前填写的
        var branchkeyword = $("#branchkeyword").val();
        findBranchByShopCodeAndBranchCodeAndBranchName(shopcode ,branchkeyword);
    }
    // 查询门店信息
    function findBranchByShopCodeAndBranchCodeAndBranchName(shopcode ,branchkeyword) {
        var url = '${ctxPath}/workorder/querBranchByShopCode.action';
        var params = {
            shopcode: shopcode,
            branchkeyword:branchkeyword
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            var json = eval(result);
            if (json.length > 0){
                var branchHtml = '';
                for (var i = 0 ; i < json.length ;i++){
                    var code = json[i].branchcode;
                    var name = json[i].branchname;
                    var dutyperson = json[i].dutyperson;
                    var dutypersonnum  = json[i].dutypersonnum;
                    // 创建HTML
                    branchHtml+=' <div class="col-md-12 branchStyle noSelectedBranch" onclick="changeBackground(this)" ><h4>';
                    branchHtml+=code+ '_' + name;
                    branchHtml+='</h4><input hidden name="branchcode" value="'+ code +'" />';
                    branchHtml+='<input hidden name="branchname" value="'+ name +'" />';
                    branchHtml+='<input hidden name="dutyperson" value="'+ dutyperson +'" />';
                    branchHtml+='<input hidden name="dutypersonnum" value="'+ dutypersonnum +'" />';
                    branchHtml+='</div>';
                }
                // 加入branch的div中  先清除
                $('.branch').find("div:not(:first)").remove();
                $('.branch').append(branchHtml);
            }
        })
    }
    // 保存门店信息
    function saveBranchInfo() {
        // 获取当前选中的店铺和门店信息
        var shopname = $(".shop").find(".selectedBranch").find("input[name=shopname]").val();
        var shopcode = $(".shop").find(".selectedBranch").find("input[name=shopcode]").val();
        var branchname = $(".branch").find(".selectedBranch").find("input[name=branchname]").val();
        var branchcode = $(".branch").find(".selectedBranch").find("input[name=branchcode]").val();
        var dutyperson = $(".branch").find(".selectedBranch").find("input[name=dutyperson]").val();
        var dutypersonnum = $(".branch").find(".selectedBranch").find("input[name=dutypersonnum]").val();
        if (!branchcode){
            AlertMsg("请选择门店");
            return;
        }
        // 赋值
        $("#shopcode").val(shopcode);
        $("#shopname").val(shopname);
        $("#branchname").val(branchname);
        $("#branchcode").val(branchcode);
        $("#dutyperson").val(dutyperson);
        $("#dutypersonnum").val(dutypersonnum);
        var str = shopname + '-' + branchname ;
        if(dutyperson && dutyperson != 'null'){
            str = str + '-' + dutyperson;
            $("#dutyperson").val(dutyperson);
        }
        if(dutypersonnum && dutypersonnum != 'null'){
            str = str + '（' + dutypersonnum + '）';
            $("#dutypersonnum").val(dutypersonnum);
        }
        // 关闭
        $('#branch_model').modal('hide');
        // 追加
        $("#faultStoreDiv").find('span').html(str);
    }
    
    function saveServiceBill() {
        // 校验参数
       var productcategory = $('#productcategory').val();
       var productmodel = $('#productmodel').val();
       var shopcode = $('#shopcode').val();
       var devicecode = $('#devicecode').val();
       var faultdescribe = $('#faultdescribe').val();
       var customcontacts = $('#customcontacts').val();
       var customcontactstel = $('#customcontactstel').val();
       var customaddress = $('#customaddress').val();
       var customcourier = $('#customcourier').val();
       var customeraddressremake = $('#customeraddressremake').val();
       var customerbillremake = $('#customerbillremake').val();


       var companycontacts = $('#companycontacts').val();
       var companycontactstel = $('#companycontactstel').val();
       var companyaddress = $('#companyaddress').val();

       if (productcategory == '0'){
           AlertMsg("请选择设备类型");
           return;
       }
        if (productmodel == '0'){
            AlertMsg("请选择设备型号");
            return;
        }
        if (!shopcode){
            AlertMsg("请选择故障门店");
            return;
        }

        if (!devicecode){
            AlertMsg("请输入故障设备唯一码");
            return;
        }
        if(devicecode.length > 50){
            AlertMsg("设备唯一码不能超过50字!");
            return false;
        }

        if (!customcontacts || customcontacts.length > 25){
            AlertMsg("请输入收货联系人且最长25字");
            return;
        }
        if (!customaddress){
            AlertMsg("请输入收货人地址");
            return false;
        }
        if (customaddress.length > 50){
            AlertMsg("收货人地址最多为50个字符");
            return false;
        }
        if((!/^[1][3,4,5,7,8][0-9]{9}$/.test(customcontactstel))){
            alert("请输入正确的电话!");
            return false;
        }
        if (!customcourier){
            AlertMsg("请输入快递单号");
            return false;
        }
        if (customcourier.length > 20){
            AlertMsg("快递单号最多为20个字符");
            return false;
        }

        if (!faultdescribe){
            AlertMsg("请输入故障描述!");
            return false;
        }
        if (faultdescribe.length > 500){
            AlertMsg("故障描述最多为500字!");
            return false;
        }
        if (customeraddressremake.length > 100){
            AlertMsg("收货地址备注，最多100字!");
            return false;
        }
        if (customerbillremake.length > 100){
            AlertMsg("快递单号备注，最多100字!");
            return false;
        }

        if (companycontacts.length > 25){
            AlertMsg("工厂联系人最多25字!");
            return false;
        }
        if(companycontactstel &&(!/^[1][3,4,5,7,8][0-9]{9}$/.test(companycontactstel))){
            alert("请输入正确的工厂联系电话!");
            return false;
        }
        if (companyaddress.length > 50){
            AlertMsg("工厂地址最多50字!");
            return false;
        }

        // 赋值
        var productcode = $('#productmodel option:selected').attr("id");
        $("#productcode").val(productcode);

        // 置灰按钮
        $("#sumbitButton").attr("disabled",true)
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
    }

    // 打开workOrder选择框
    function addWorkOrder() {
        ChooseWorkOrder.open(null,function (workordercode) {
            // 根据workordercode查询单据信息
            var url = '${ctxPath}/workorder/findWorkOrderByWorkOrderCode.action';
            var params = {
                workordercode:workordercode.id
            }
            ajaxSyncInSameDomain(url, params, function (result) {
                var json = eval(result);
                if (json){
                    //1 . 设备类型
                    var productcategory = json.productcategory;
                    var productmodel = json.productmodel;
                    var productmodelsjson = json.productmodels;
                    $("#productcategory").val(productcategory);
                     if (productmodelsjson && productmodelsjson.length > 0){
                        var html = '';
                        for (var i = 0 ; i < productmodelsjson.length ;i++){
                            var productmodelopt = productmodelsjson[i].productmodel;
                            var productcode = productmodelsjson[i].productcode;
                            // 创建HTML
                            if(productmodelopt == productmodel){
                                html+='<option selected id="'+ productcode +'" value ="'+ productmodelopt +'">'+ productmodelopt +'</option>';
                            }else {
                                html+='<option id='+ productcode +'value ='+ productmodelopt +'>'+ productmodelopt +'</option>';
                            }

                        }
                        $('#productmodel').find("option:not(:first)").remove();
                        $('#productmodel').append(html);
                    }
                    // 2.故障門店
                    var shopcode = json.shopcode;
                    var shopname = json.shopname;
                    var branchcode = json.branchcode;
                    var branchname = json.branchname;
                    var dutyperson = json.dutyperson;
                    var dutypersonnum = json.dutypersonnum;

                    $("#shopcode").val(shopcode);
                    $("#shopname").val(shopname);
                    $("#branchcode").val(branchcode);
                    $("#branchname").val(branchname);
                    $("#dutyperson").val(dutyperson);
                    $("#dutypersonnum").val(dutypersonnum);
                    var str = shopname + '-' + branchname ;
                    if(dutyperson && dutyperson != 'null'){
                        str = str + '-' + dutyperson;
                        $("#dutyperson").val(dutyperson);
                    }
                    if(dutypersonnum && dutypersonnum != 'null'){
                        str = str + '（' + dutypersonnum + '）';
                        $("#dutypersonnum").val(dutypersonnum);
                    }
                    $("#faultStoreDiv").find('span').html(str);
                    // 3.設備唯一碼
                    $("#devicecode").val(json.devicecode);

                    // 4.故障描述
                    $("#faultdescribe").val(json.faultdescribe);

                    // 5.工厂信息
                    $("#companycontacts").val(json.companycontacts);
                    $("#companyaddress").val(json.companyaddress);
                    $("#companycontactstel").val(json.companycontactstel);

                    $("#workordercode").val(json.workordercode);

                    // 将查看按钮变成蓝色
                    $('#lockPrice').css('color' ,'blue');
                    // 绑定单击事件
                    $('#lockPrice').on('click',function () {
                        // 获取当前的workordercode
                        var lockPriceUrl = '${ctxPath}/workorder/findWorkOrderPrice.action';
                        var code = $('#workordercode').val();
                        var lockPriceParams = {
                            workordercode:workordercode.id
                        }
                        ajaxInSameDomain(lockPriceUrl, lockPriceParams, function (result) {
                            $('#modal_work_order_price').find('div.modal-content').html('');
                            $('#modal_work_order_price').find('div.modal-content').html(result);
                            $('#modal_work_order_price').modal("show");
                        },'html')
                    });
                }
            });
        })
    }

    function continueUseAddress(e) {
        var isChecked = e.checked;
        if(isChecked){
            // 根据workordercode查询单据信息
            var url = '${ctxPath}/seviceaddress/queryServiceAddress.action';
            ajaxSyncInSameDomain(url, null, function (result) {
                if(result){
                    var json = eval(result.data);
                    $("#companycontacts").val(json.contact);
                    $("#companycontactstel").val(json.contacttel);
                    $("#companyaddress").val(json.address);
                }
            });
        }
    }

</script>
</@override>
<@override name="right">
<form action="${ctxPath}/serviceBill/saveServiceBill.action" method="post" role="form" id="submitForm">
    <input type="text" hidden name="workordercode" id="workordercode" />
    <input type="text" hidden name="productcode" id="productcode" />
    <div class="tab-pane" id="pane">
        <div class="portlet light portlet-fit portlet-form">
            <div class="portlet-title">
                <div class="caption font-dark">
                    <span class="caption-subject bold uppercase main-content-title">设备返修-新增</span>
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
                                    <div class="col-md-2">
                                        <a href="#"  class="btn btn-primary" onclick="addWorkOrder()">+待返修工单</a>
                                    </div>
                                    <div class="col-md-10">
                                        <p style="color: red">温馨提示：可通过添加'待返修'的工单来自动填充返修设备信息</p>
                                    </div>
                                </div>
                                <div class="form-group col-md-12">
                                    <label class="control-label col-md-2"><span style="color:red">*</span>设备类型</label>
                                    <div class="col-md-4">
                                        <select class="form-control" id="productcategory" name="productcategory">
                                            <option value="0" selected>请选择设备类型</option>
                                            <option value="1">收银机</option>
                                            <option value="2">广告机</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4">
                                        <select class="form-control" id="productmodel" name="productmodel">
                                            <option value="0" selected>请选择设备型号</option>
                                        </select>
                                    </div>
                                </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2"><span style="color:red">*</span>故障门店</label>
                                <div class="col-md-8" id="faultStoreDiv">
                                    <a href="javascript:void(0)" style="color:blue;" onclick="queryBranch()">+添加门店</a>
                                    <span></span>
                                    <input hidden type="text" value="" id="shopcode" name="shopcode"/>
                                    <input hidden type="text" value="" id="shopname" name="shopname"/>
                                    <input hidden type="text" value="" id="branchcode" name="branchcode"/>
                                    <input hidden type="text" value="" id="branchname" name="branchname"/>
                                    <input hidden type="text" value="" id="dutyperson" name="dutyperson"/>
                                    <input hidden type="text" value="" id="dutypersonnum" name="dutypersonnum"/>
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2"><span style="color:red">*</span>设备唯一吗</label>
                                <div class="col-md-4">
                                    <input placeholder="请输入故障设备唯一码" type="text" class="form-control"
                                           name="devicecode" id="devicecode" value="">
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2"><span style="color:red">*</span>故障描述</label>
                                <div class="control-label col-md-10">
                                    <div class="input-txt">
                                        <textarea name="faultdescribe" id="faultdescribe" class="form-control"
                                                  rows="4"
                                                  placeholder="请输入不超过500字的详细描述"></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">延用历史工厂信息:</label>
                                <div class="control-label col-md-10">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" onclick="continueUseAddress(this);">延用
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">工厂联系人：</label>
                                <div class="col-md-4">
                                    <input placeholder="请输入工厂联系人姓名" type="text" class="form-control"
                                                                                                         name="companycontacts" id="companycontacts" value="">
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">工厂联系电话：</label>
                                <div class="col-md-4">
                                    <input placeholder="请输入工厂联系人电话" type="text" class="form-control"
                                           name="companycontactstel" id="companycontactstel" value="">
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">工厂地址：</label>
                                <div class="col-md-4">
                                    <input placeholder="请输入工厂地址" type="text" class="form-control"
                                           name="companyaddress" id="companyaddress" value="">
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">返修价格参考表：</label>
                                <div class="col-md-4">
                                    <div class="col-md-4">
                                        <a href="javascript:void(0)" id="lockPrice">查看</a>
                                    </div>
                                </div>
                            </div>
                            <label class="control-label col-md-12">
                                <h5 style="font-weight:bold">▉收货地址<span style="color: #CCCCFF;font-size: 2px">(维修后的设备接收地址)</span>
                                </h5>
                            </label>
                                <br/>
                            <div class="form-group col-md-12">
                                    <label class="control-label col-md-2"><span
                                            style="color:red">*</span>联系人：</label>
                                    <div class="col-md-4">
                                        <input placeholder="请输入收货联系人姓名" type="text" class="form-control"
                                               name="customcontacts" id="customcontacts" value="">
                                    </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2"><span
                                        style="color:red">*</span>联系人手机：</label>
                                <div class="col-md-4">
                                    <input placeholder="请输入收货联系人电话" type="text" class="form-control"
                                           name="customcontactstel" id="customcontactstel" value="">
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2"><span
                                        style="color:red">*</span>收货地址：</label>
                                <div class="col-md-4">
                                    <input placeholder="请输入收货地址" type="text" class="form-control"
                                           name="customaddress" id="customaddress" value="">
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">备注：</label>
                                <div class="col-md-4">
                                    <input placeholder="最多输入100字符" type="text" class="form-control"
                                           name="customeraddressremake" id="customeraddressremake" value="">
                                </div>
                            </div>

                            <label class="control-label col-md-12">
                                <h5 style="font-weight:bold">▉返修物流<span style="color: #CCCCFF;font-size: 2px">(设备发往工厂的物流)</span>
                                </h5>
                            </label>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2"><span
                                        style="color:red">*</span>快递单号：</label>
                                <div class="col-md-4">
                                    <input placeholder="请输入快递单号" type="text" class="form-control"
                                           name="customcourier" id="customcourier" value="">
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2">备注：</label>
                                <div class="col-md-4">
                                    <input placeholder="最多输入100字符" type="text" class="form-control"
                                           name="customerbillremake" id="customerbillremake" value="">
                                </div>
                            </div>
                            <div class="form-actions">
                                <div class="row">
                                    <div class="col-md-offset-3 col-md-9">
                                        <input type="button" value="提交"  id="sumbitButton"  class="btn btn-primary col-lg-1"
                                               onclick="saveServiceBill()">
                                        <input type="button" onclick="returnServiceBill()" style="margin-left:10px;" value="返回"
                                               class="btn btn-default">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
</@override>
<@override name="window">
        <div id="branch_model" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
            <div class="modal-dialog" style="width: 1200px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                        <h4>添加门店</h4>
                    </div>
                    <div class="modal-body">
                        <form action="#" class="form-horizontal" method="post">
                            <div class="form-body">
                                <div class="row">
                                    <div class="col-md-6 shop">
                                        <div class="col-md-12">
                                            <input type="text" id="shopkeyword" name="shopkeyword" style="width: 120px"
                                                   value="${RequestParameters.shopkeyword!''}"
                                                   placeholder="">
                                            <button style="height: 28px" type="button" class="btn btn-default "
                                                    onclick="findShop()">
                                                <i class="fa fa-search"></i> 搜索
                                            </button>
                                        </div>
                                        <br/>
                                        <br/>
                                        <br/>

                                    </div>
                                    <div class="col-md-6 branch">
                                        <div class="col-md-12">
                                            <input type="text" id="branchkeyword" name="branchkeyword"
                                                   style="width: 120px"
                                                   value="${RequestParameters.branchkeyword!''}"
                                                   placeholder="">
                                            <button style="height: 28px" type="button" class="btn btn-default "
                                                    onclick="queryBranchList()">
                                                <i class="fa fa-search"></i> 搜索
                                            </button>
                                        </div>
                                        <br/>
                                        <br/>
                                        <br/>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <a href="#" class="btn btn-primary" onclick="saveBranchInfo()">保存</a>
                        <a href="#" class="btn btn-default" data-dismiss="modal" aria-hidden="true">取消</a>
                    </div>
                </div>
            </div>
        </div>
        <#include '../choose_work_order.ftl'>
         <div id="modal_work_order_price" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
             <div class="modal-dialog" style="width: 600px">
                 <div class="modal-content">

                 </div>
             </div>
         </div>
</@override>
<@extends name="../base_main.ftl"/>