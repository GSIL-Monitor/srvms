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
<#-- 图片的js -->
<script>
    function returnWorkOrder() {
        window.location.href = '${ctxPath}/workorder/workOrderManage.action';
    }
    
    $(function () {
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
            var $lis = $('#carouselplus').parent().find("li");
            if ($lis.length - 1 >= 5){
                layer.msg('最多添加五张照片', {icon: 5});
                return;
            }
            console.log($('.carselhead>span'));
            var numarr=$('.carselhead>span');
            console.log(numarr.length);
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


    })
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
<form action="${ctxPath}/workorder/saveWorkOrder.action" method="post"  enctype="multipart/form-data" class="form-horizontal" role="form" id="submitForm">
    <div class="panel panel-default">
            <label class="control-label col-md-3"><strong style="font-size: 18px">维修工单-新增</strong></label>
    </div>
    <div class="panel-body">
        <div class="form-body">
            <div class="form-group">
                <label class="control-label col-md-3"><span style="color: red;">*</span>工单类型</label>
                <div class="col-md-9">
                    <div class="col-md-12" id="workordertype">
                        <label class="radio-inline">
                            <input type="radio" name="workordertype" id="soft" value="0" checked> 软件工单
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="workordertype" id="hardware"  value="1"> 硬件工单
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3"><span style="color: red;">*</span>工单标题</label>
                <div class="col-md-9">
                    <input style="margin-left:0px"  placeholder="请输入不要超过30字符的工单标题" type="text" class="form-control" name="workordertitle" id="workordertitle" value="">
                </div>
            </div>
            <div class="form-group soft">
                <label class="control-label col-md-3"><span style="color: red;">*</span>故障软件</label>
                <div class="col-md-3">
                    <input type="text" hidden name="componentname" id="componentname" value="" />
                    <select class="form-control" id="componentcode" name="componentcode">
                        <option id="1" value="1">商户后台(标准版)</option>
                        <option id="2" value="2">商户后台(连锁版)</option>
                        <option id="3" value="3">微商城(公众号)</option>
                        <option id="4" value="4">导购员助手</option>
                        <option id="5" value="5">微商城(小程序)</option>
                        <option id="6" value="6">老板助手</option>
                        <option id="7" value="7">服务商系统</option>
                        <option id="8" value="8">收银机(windows)</option>
                        <option id="9" value="9">收银机(XP)</option>
                        <option id="10" value="10">收银机(android)</option>
                        <option id="11" value="11">广告机</option>
                    </select>
                </div>
            </div>
            <div class="form-group device" hidden>
                <label class="control-label col-md-3"><span style="color: red;">*</span>故障设备</label>
                <div class="col-md-4">
                    <input type="text" hidden id="productcode" name="productcode" value="" />
                    <select class="form-control" id="productcategory" name="productcategory">
                        <option selected value="0">请选择设备类型</option>
                        <#if hardwareDeviceList?? && hardwareDeviceList?size gt 0>
                             <#list hardwareDeviceList as hardwareDevice>
                                <option id="${hardwareDevice.productcategory}" value = "${hardwareDevice.productcategory}">${hardwareDevice.productcategoryname}</option>
                             </#list>
                        </#if>
                    </select>
                    <input hidden type="text" value="" id="devicename" name="devicename" />
                </div>
                <div class="col-md-4">
                        <select class="form-control" id="productmodel" name="productmodel">
                        <option selected value="0">请选择设备型号</option>
                    </select>
                </div>
            </div>
            <div class="form-group device" hidden>
                <label class="control-label col-md-3">设备配件</label>
                <div class="col-md-9 parts">
                    <a href="javascript:void(0)" style="color: blue" onclick="addDevicePart()">+添加设备配件</a>
                    <input type="text" hidden value="" name="hardwareDeviceParts" id = "hardwareDeviceParts"/>
                    <div class="table-scrollable">
                        <table class="table table-hover table-bordered" id="submitDeviceParts">
                            <thead>
                                <tr>
                                    <th> 序号</th>
                                    <th> 配件名称</th>
                                    <th> 版本型号</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        暂无内容
                                    </td>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3"><span style="color: red;">*</span>故障门店</label>
                <div class="col-md-9" id="faultStoreDiv">
                    <a style="color: blue;" href="javascript:void(0)" onclick="queryBranch()">+添加门店</a>
                    <span></span>
                    <input hidden type="text" value="" id="shopcode" name="shopcode" />
                    <input hidden type="text" value="" id="shopname" name="shopname" />
                    <input hidden type="text" value="" id="branchcode" name="branchcode" />
                    <input hidden type="text" value="" id="branchname" name="branchname" />
                    <input hidden type="text" value="" id="dutyperson" name="dutyperson" />
                    <input hidden type="text" value="" id="dutypersonnum" name="dutypersonnum" />
                </div>
            </div>
            <div class="form-group soft">
                <label class="control-label col-md-3"><span style="color: red;">*</span>故障用户</label>
                <div class="col-md-9">
                    <div class="input-txt">
                        <input style="margin-left:0px" placeholder="请输入出故障时使用的用户名" type="text" class="form-control" name="faultusers" id="faultusers" value="">
                    </div>
                </div>
            </div>
            <div class="form-group device" hidden>
                <label class="control-label col-md-3"><span style="color: red;">*</span>设备唯一码</label>
                <div class="col-md-9">
                    <div class="input-txt">
                        <input style="margin-left:0px"  placeholder="请输入故障设备唯一码" type="text" class="form-control" name="devicecode" id="devicecode" value="">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3"><span style="color: red;">*</span>故障描述</label>
                <div class="col-md-9">
                    <div class="input-txt">
                        <textarea name="faultdescribe" id="faultdescribe"  class="form-control" rows="4"  placeholder="详细描述，不超过500字符"></textarea>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3"><span style="color: red;">*</span>上传图片</label>
                <div class="col-md-9">
                    <ul class='carouselbox'>
                        <li id="carouselplus">
                            <div class='carselconborder'>
                                <p class="carselplus1">+</p>
                                <p style="color: red;">最多可添加5张图片（每张最大5M;png或jpg）</p>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="form-group form-actions">
            <input type="button" value="提交" class="btn btn-primary col-lg-1"  id="sumbitButton" onclick="saveRechargeBill()">
            <input type="button" onclick="returnWorkOrder()" style="margin-left:10px;" value="返回"
                   class="btn btn-default">
        </div>
    </div>
</form>
<script>

    // 提交参数校验
    function submitParameterChecked(){
        var workordertitle = $("#workordertitle").val();
        var faultdescribe = $("#faultdescribe").val();
        var shopcode = $("#shopcode").val();
        var uploadFileFlag = false;


        if(!workordertitle){
            AlertMsg("请输入工单标题!");
            return false;
        }
        if(workordertitle.length > 30){
            AlertMsg("工单标题不能超过30字!");
            return false;
        }
        if(!faultdescribe){
            AlertMsg("请输入故障描述!");
            return false;
        }
        if(faultdescribe.length > 500){
            AlertMsg("故障描述不能超过500字!");
            return false;
        }
        if(!shopcode){
            AlertMsg("请选择故障门店!");
            return false;
        }

        var softOrHardware = $("input:radio[name=workordertype]:checked").val();
        if("0" == softOrHardware){ // 软件
            var componentcode = $("#componentcode").val();
            var faultusers = $("#faultusers").val();
            if(!componentcode){
                AlertMsg("请选择故障软件!");
                return false;
            }
            if(!faultusers){
                AlertMsg("请输入故障用户!");
                return false;
            }
            if(faultusers.length > 25){
                AlertMsg("故障用户不能超过25字!");
                return false;
            }

            var componentname = $("#componentcode").find("option:selected").html();
            $("#componentname").val(componentname);
        }else {//硬件
            var devicecode = $("#devicecode").val();
            var productcategory = $("#productcategory").val();
            var productmodel = $("#productmodel").val();

            var submitDeviceParts = $("#submitDeviceParts").find("tbody").find("input");
            if  (!devicecode) {
                AlertMsg("请输入设备唯一码！");
                return false;
            }
            if(devicecode.length > 50){
                AlertMsg("设备唯一码不能超过50字!");
                return false;
            }
            if  (productcategory == '0' ) {
                AlertMsg("请选择故障设备类型！");
                return false;
            }
            if  (productcategory == '0') {
                AlertMsg("请选择故障设备型号！");
                return false;
            }
            var hardwareDevices = [];
            // 处理参数
            $("#submitDeviceParts").find("tbody").find("tr").each(function () { // 遍历所有tr
                var hardwareDevice = {};
                hardwareDevice.productcode = $(this).find("td").find("input").val();
                hardwareDevice.productname = $(this).children("td:first-child").next().html();
                hardwareDevice.versionmodel = $(this).children("td:last-child").html();
                hardwareDevices.push(hardwareDevice);
            });
            var submitDeviceParts = $("#submitDeviceParts").find("tbody").find("input");
            if(submitDeviceParts && submitDeviceParts.length != 0){
                $("#hardwareDeviceParts").val(JSON.stringify(hardwareDevices));
            }

            var productcode = $("#productmodel").find("option:selected").attr("id");
            $("#productcode").val(productcode);
        }
        // 上传图片
        $('.carouselbox').find('.previewimg').each(function (i,v) {
            if(!$(v).attr('src')){
                layer.msg('您还有未上传图片框', {icon: 5});
                uploadFileFlag = false;
                return false;
            }
            uploadFileFlag = true;
        });

        if(!uploadFileFlag){
            AlertMsg("请上传图片!");
            return false;
        }

        var formtFlag = false;
        // 校验图片大小和格式
        $("input[name=upfiles]").each(function () {
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
        return true;
    }

    function getFileType(filePath) {
        var startIndex = filePath.lastIndexOf(".");
        if(startIndex != -1)
            return filePath.substring(startIndex + 1, filePath.length).toLowerCase();
        else return "";
    }

    // 提交表单
    function saveRechargeBill() {
        if(!submitParameterChecked()){
            return;
        }
        $("#sumbitButton").attr("disabled",true)
        var ajax_option={
            success:function(data){
                var result = eval(data);
                if (result.success) {
                    AlertMsg(result.data, function () {
                        window.location.href = '${ctxPath}/workorder/workOrderManage.action'
                    });
                }
            }
        };
        $('#submitForm').ajaxSubmit(ajax_option);
    }
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
        if (!shopkeyword){
            AlertMsg("请输入商户ID或商户名称");
            return;
        }
        var url = '${ctxPath}/workorder/queryShopByShopCodeAndShopName.action';
        var params = {
            shopkeyword: shopkeyword
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            var shopFirstChild = $('.shop').find(":first-child").prop("outerHTML");
            $('.shop').empty().append(shopFirstChild);
            var branchFirstChild = $('.branch').find(":first-child").prop("outerHTML");
            $('.branch').empty().append(branchFirstChild);
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
                $('.shop').append(shopHtml);
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
            AlertMsg("请先选择门店!");
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
            // 加入branch的div中  先清除
            var branchFirstChild = $('.branch').find(":first-child").prop("outerHTML");
            $('.branch').empty().append(branchFirstChild);
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
            AlertMsg("请先选择门店!");
            return;
        }
        // 赋值
        $("#shopcode").val(shopcode);
        $("#shopname").val(shopname);
        $("#branchname").val(branchname);
        $("#branchcode").val(branchcode);

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
    <#-------------------------------------------------门店JS  end----------------------------------------------------->

    <#-------------------------------------------------硬件产品JS  start----------------------------------------------->
    // 添加设备配件查询
    function addDevicePart(){
        var productcategory = $("#productcategory").val();
        var productmodel = $("#productmodel").val();
        var productcode = $("#productmodel").find("option:selected").attr("id");

        if(("0" == productmodel) || ("0" == productcategory)){
            AlertMsg("请选择设备类型和设备型号!");
            return;
        }
        var url = '${ctxPath}/workorder/queryHardwareDeviceParts.action';
        var params = {
            productcategory: productcategory,
            productmodel:productmodel,
            productcode:productcode
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            var json = eval(result);
            var html = '';
            if (json.length > 0){
                var html = '';
                for (var i = 0 ; i < json.length ;i++){
                    productcode = json[i].productcode;  // 配件设备编号
                    productname = json[i].productname; // 配件设备名称
                    versionmodel  = json[i].versionmodel; //配件设备
                    // 创建html
                    html += '<tr>';
                    html += '<td> <input onclick="radioDeviceParts(this)" type="checkbox" name="deviceparts" value="'+ productcode +'" /></td> ';
                    html += '<td>'+ (i + 1) +'</td> ';
                    html += '<td>'+ productname +'</td> ';
                    if(!versionmodel || versionmodel == 'null'){
                        html += '<td></td> ';
                    }else{
                        html += '<td>'+ versionmodel +'</td> ';
                    }
                    html += '</tr>';
                }
            }
            $('#devicePartTable').find("tbody").find("tr").remove();
            $('#devicePartTable').find("tbody").append(html);
            $('#device_parts').modal('show');
        });
    }
    // 保存配件信息
    function saveDeviceParts() {
        // 获取被选中的设备配件
        var html = '';
        var index = 1;
        $('#devicePartTable').find("tbody").find("input:checkbox[name=deviceparts]:checked").each(function () {
            // 获取当前被选中的checkbox的值
             var productcode = $(this).val();
             // 当前被选中的父类的下一个元素的HTML内容
             var productname = $(this).parent("td").next().next().html();
             var versionmodel = $(this).parent("td").next().next().next().html();
             // 创建html
             html += '<tr>';
             html += '<td>'+ index +'<input hidden value='+ productcode+'></td> ';
             html += '<td>'+ productname +'</td> ';
             html += '<td>'+ versionmodel +'</td> ';
             html += '</tr>';
             index++;
        });
        // 追加HTML
        $("#submitDeviceParts").find("tbody").find("tr").remove();
        $("#submitDeviceParts").find("tbody").append(html);
        // 清除选中状态
        $("#devicePartsAll")[0].checked = false;
        $('#device_parts').modal('hide');
    }

    // 配件的全选按钮
    function devicePartAll(e) {
        // 获取当前的选择状态
        var status = e.checked;
        // 获取所有的checkedbox
        $('#devicePartTable').find('tbody').find("input:checkbox[name=deviceparts]").each(function () {
            this.checked = status;
        });
    }

    // 给所有的配件选择按钮配置点击事件
    function radioDeviceParts(e) {
        // 点击时获取所有选择按钮
        var chechedFalg = $("input:checkbox[name=deviceparts]:checked");
        var checkboxAll = $("input:checkbox[name=deviceparts]");
        if (checkboxAll.length == chechedFalg.length) { // 数量相等
            // 获取全选的按钮设置全选
            $("input:checkbox[name=devicePartsAll]")[0].checked = true;
        } else {
            $("input:checkbox[name=devicePartsAll]")[0].checked = false;
        }
    }
    <#-------------------------------------------------硬件产品JS  end------------------------------------------------->

    $(function () {
        // 控制软件硬件的显示
        $("#workordertype").find("input[type='radio']").on("click",function () {
            var checkValue = $("#workordertype").find("input[type='radio']:checked").val();
            if ("0" == checkValue){
                $(".soft").show();
                $(".device").hide();
            }
            if ("1" == checkValue){
                $(".soft").hide();
                $(".device").show();
            }
        });

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
    });

</script>
</@override>
<@override name="window">
        <div id="branch_model" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
            <div class="modal-dialog" style="width:1200px">
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
                                                <div class="col-md-6 ">
                                                    <div class="form-group">
                                                        <div class="col-md-9">
                                                            <input type="text" id="shopkeyword" name="shopkeyword"  class="form-control"
                                                                   value="${RequestParameters.shopkeyword!''}"     placeholder="输入商户ID、名称查询">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-2 col-sm-6">
                                                    <button type="button" class="btn btn-default " onclick="findShop()">
                                                        <i class="fa fa-search"></i> 搜索
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 branch">
                                            <div class="col-md-12">
                                                <div class="col-md-6 ">
                                                    <div class="form-group">
                                                        <div class="col-md-9">
                                                            <input type="text" id="branchkeyword" name="branchkeyword"  class="form-control"
                                                                   value="${RequestParameters.branchkeyword!''}"      placeholder="输入门店编、名称查询">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-2 col-sm-6">
                                                    <button type="button" class="btn btn-default " onclick="queryBranchList()">
                                                        <i class="fa fa-search"></i> 搜索
                                                    </button>
                                                </div>
                                            </div>
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

        <#--------------------------------------- 查询设备配件  ------------------------------------------------------->
        <div id="device_parts" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
               <div class="modal-dialog" style="width: 600px">
                   <div class="modal-content">
                       <div class="modal-header">
                           <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                           <h4>添加设备配件</h4>
                       </div>
                       <div class="modal-body">
                           <form action="#" class="form-horizontal" method="post">
                               <div class="form-body">
                                   <div class="row">
                                       <div class="table-scrollable">
                                           <table class="table table-hover table-bordered" id="devicePartTable">
                                               <thead>
                                                   <tr>
                                                       <th width="48px">
                                                                   <input type="checkbox" name="devicePartsAll" id="devicePartsAll" value="0" onclick="devicePartAll(this)" />
                                                                全部
                                                       </th>
                                                       <th> 序号</th>
                                                       <th> 配件名称</th>
                                                       <th> 版本型号</th>
                                                   </tr>
                                               </thead>
                                               <tbody>

                                               </tbody>
                                           </table>
                                       </div>
                                   </div>
                               </div>
                           </form>
                       </div>
                       <div class="modal-footer">
                           <a href="#" class="btn btn-primary" onclick="saveDeviceParts()">保存</a>
                           <a href="#" class="btn btn-default" data-dismiss="modal" aria-hidden="true">取消</a>
                       </div>
                   </div>
               </div>
           </div>

</@override>
<@extends name="../base_main.ftl"/>