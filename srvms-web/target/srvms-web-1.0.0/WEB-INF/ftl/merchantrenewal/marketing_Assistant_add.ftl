<@override name="jsfile">
    <script src="${ctxPath}/js/jquery.form.js" type="text/javascript"></script>
</@override>
<@override name="jstext">
<script>

    function allRadioClick(e) {
        var year = $(e).val();
        var price = parseFloat($(e).attr("price")) * 100;

        var totalamount = 0;
        // 修改所有的复选框
        $("table .shopData td[name='radioTd'] input[value='"+year+"']").each(function () {
            this.checked = "checked";
            console.info(this);
            var number = $(this).parent().prev().find("input[name='number']").val();

            var discount =  parseFloat($(this).parent().next().find("input[name='discount']").val());
            var subtotal = Number(discount * price * number / 100 / 100 ).toFixed(2) * 100;
            // 修改后面的金额
            totalamount += subtotal
            $(this).parent().next().next().html(Number(subtotal/100).toFixed(2));
        })
        $("#totalamount").html(Number( totalamount / 100).toFixed(2) + "元");
    }

    function radioClick(e) {
        // 清空所有的额选中
        $("input[name='allYear']").each(function () {
            this.checked = false;
        });
        var flag = true;
        var year = "";
        var index = 0;

        if(($("table .shopData tr").length - 1) == $("table tbody input[type='radio']:checked").length){
            $("table tbody input[type='radio']:checked").each(function () {
                if (index == 0){
                    index++;
                    year = $(this).val();
                    return true;
                }
                if (year != $(this).val()){
                    flag = false;
                    return false;
                }
            });
            if(flag){
                $("input[name='allYear']").each(function () {
                    if ($(this).val() == year){
                        this.checked = "checked";
                    }
                });
            }
        }
        // 修改价格
        var number = $(e).parent().prev().find("input[name='number']").val();
        // 获取当前的原价格
        var oldPrice = parseFloat($(e).parent().next().next().html()) * 100;
        var price =  parseFloat($(e).attr("price")) * 100;
        var discount = parseFloat($(e).parent().next().find("input[name='discount']").val());
        var newPrice = (price * discount * number / 100 / 100).toFixed(2) * 100;
        $(e).parent().next().next().html(Number(newPrice / 100).toFixed(2));
        var subStr = $("#totalamount").html();
        var totalamount = parseFloat(subStr.substring(0 ,subStr.length - 1)) * 100;
        $("#totalamount").html((Number((totalamount - oldPrice + newPrice) / 100).toFixed(2)) + "元");
    }

    function singleShop() {
        // 获取所有的年份
        var allYeas = new Array();
        $("input[name=yearParts]").each(function () {
            var obj = new Object();
            var year = $(this).val();
            var price = $(this).next().val();
            obj.year = year;
            obj.price = price;
            allYeas.push(obj);
        });
        ChooseWechatShop.open(null ,function (params) {
            // 遍历
            var length = params.length;
            var html = "<tr><td valign='top' colspan='11' class='dataTables_empty'>暂无数据</td></tr>"
            if (length > 0){ // 有数据
                html = '';
                for (var i = 0 ; i < length; i++){
                    html += '<tr name = "data" id ="'+ params[i].shopcode +'">';
                    html += "<td>"+ (i+1) +"</td>"
                    html += "<td>"+ params[i].shopcode +"</td>"
                    html += "<td>"+ params[i].shopname +"</td>"
                    html += "<td><input " +
                            " class='form-control' onblur='writeNumber(this)'   type='number'  name = 'number' id='number' value='1'/></td>"
                    html += ' <td name="radioTd">'
                    html += '<input type="text" hidden name="shopcode" value="'+params[i].shopcode+'" />';
                    html += '<input type="text" hidden name="shopname" value="'+ params[i].shopname +'" />';
                    html += '<input type="text" hidden name="branchcode" value="'+ params[i].branchcode +'" />';
                    html += '<input type="text" hidden name="branchname" value="'+ params[i].branchname +'" />';

                    html += '<input type="text" hidden name="expirestime" value="'+ params[i].expiretime +'" />';
                    for (var j = 0 ; j < allYeas.length ;j++){
                        html += "<input class='yearRadio' type='radio' onclick='radioClick(this)' name = '"+params[i].shopcode +"' price='"+ allYeas[j].price +"' value='"+ allYeas[j].year +"'/>" +  allYeas[j].year +"年 &nbsp;&nbsp;"
                    }
                    html += '</td>';
                    html += "<td><input " +
                            "onblur='writeDiscount(this)' class='form-control'  name = 'discount' id='discount' value='100'/></td>"
                    html += ' <td>0</td>';
                    html += "<td><a href='JavaScript:void(0)' onclick='deleteColumn(this)'>删除</a></td>"
                    html += '</tr>';
                }
                html +='<tr>';
                html +='<td></td><td></td><td></td><td></td><td></td><td></td>';
                html +="<td>合计总价:</td><td id='totalamount'>"+0+"元</td>";
                html +='</tr>';
            }
            $("table tbody").html(html);
        });
    }

    function deleteColumn(e) {
        var parentId = $(e).parent().parent().attr("id");
        var amount =  parseFloat($(e).parent().prev().html()) * 100;
        var totalamount = parseFloat($('#totalamount').html()) * 100;
        $("table tbody tr[id='"+parentId+"']").remove();
        if($("table tbody").children().length == 2){
            var html = "<tr><td valign='top' colspan='11' class='dataTables_empty'>暂无数据</td></tr>"
            $("table tbody").html(html);
        }else{
            totalamount = totalamount - amount;
            $('#totalamount').html(Number(totalamount / 100).toFixed(2) + "元");
        }
    }
    function writeNumber(e) {
        var number = $(e).val();
        var flag = isRealNum(number);
        var discount = $(e).parent().next().next().find("input[name='discount']").val();

        if(!flag || number < 1){
            number = 1;
            $(e).val(1);
            AlertMsg("请输入正确的营销助手码个数!");
            return;
        }
        if (number > 999){
            number = 999;
            $(e).val(999);
            AlertMsg("最多一次购买999个营销助手码!");
        }
        // 计算金额
        var productprice = parseFloat($(e).parent().next().find("input[type='radio']:checked").attr("price")) * 100;
        if (!productprice){
            productprice = 0;
        }
        var oldprice = parseFloat($(e).parent().next().next().next().html()) * 100;
        var newprice = (productprice * discount * number / 100 /100 ).toFixed(2) * 100;
        // 修改后面的金额
        $(e).parent().next().next().next().html(Number(newprice / 100).toFixed(2));
        $("#totalamount").html(Number((parseFloat($("#totalamount").html()) * 100 - oldprice + newprice) / 100).toFixed(2) + "元");
    }


    function writeDiscount(e) {
        var discount = $(e).val();

        var flag = isRealNum(discount);
        if(!flag || discount > 100 ){
            discount = 100;
            $(e).val(100);
        }

        // 获取当前填写的个数
        var number = $(e).parent().prev().prev().find("input[name='number']").val();
        var serverdiscount = parseFloat($("#serverdiscount").val());
        if (discount < serverdiscount){
            discount = serverdiscount;
            $(e).val(serverdiscount);
        }
        // 计算金额
        var productprice = parseFloat($(e).parent().prev().find("input[type='radio']:checked").attr("price")) * 100;
        if (!productprice){
            productprice = 0;
        }
        var oldprice = parseFloat($(e).parent().next().html()) * 100;
        var newprice = Number(productprice * discount * number / 100 /100 ).toFixed(2) * 100;
        // 修改后面的金额
        $(e).parent().next().html(Number(newprice / 100).toFixed(2));
        $("#totalamount").html(Number((parseFloat($("#totalamount").html()) * 100 - oldprice + newprice) / 100).toFixed(2) + "元");
    }

    function isRealNum(val){
        // isNaN()函数 把空串 空格 以及NUll 按照0来处理 所以先去除
        if(val === "" || val ==null){
            return false;
        }
        if(!isNaN(val)){
            return true;
        }else{
            return false;
        }
    }

    function restSingleShop() {
        var html = "<tr><td valign='top' colspan='11' class='dataTables_empty'>暂无数据</td></tr>"
        $("table tbody").html(html);
    }

    function submitOrder(){
        var productcode = $('#productcode').val(); // 产品code
        // 获取tbody下的所有的tr 标签
        var radioLength = $("table .shopData tr[name='data'] input[class='yearRadio']:checked").length;
        var dataLength = $("table .shopData tr[name='data']").length;
        if (dataLength == 0){
            AlertMsg("请选择店铺！");
            return;
        }
        if (radioLength != dataLength){
            AlertMsg("请选择续费年限！");
            return;
        }
        var param = new Object();
        param.productcode = productcode;
        param.type =3;
        var objArr = new Array();
        $(".shopData tr[name='data']").each(function () {
            var obj = new Object();
            $(this).find("input").each(function () {
                var name = $(this).attr("name");
                switch (name){
                    case "shopcode": obj.shopcode = $(this).val();
                        break;
                    case "shopname": obj.shopname = $(this).val();
                        break;
                    case "branchcode": obj.branchcode = $(this).val();
                        break;
                    case "branchname": obj.branchname = $(this).val();
                        break;
                    case "expirestime": obj.expiretime = $(this).val();
                        break;
                    case "discount": obj.discount = $(this).val();
                        break;
                    case "number": obj.number = $(this).val();
                        break;
                    default :
                        if(this.checked){
                            obj.renewtime = $(this).val();
                        }
                }
            });
            objArr.push(obj);
        });
        param.items = objArr;
        $("#orderInfo").val(JSON.stringify(param));
        //$("#submitForm").submit();

        $("#sumbitButton").attr("disabled",true)
        var ajax_option={
            success:function(data){
                var result = eval(data);
                if (result.success == 1){
                    window.location = "${ctxPath}/renew/order/wechattoPayView.action?billcode=" + result.data
                }else{
                    AlertMsg(result.errorMsg,function () {
                        $("#sumbitButton").attr("disabled",false);
                    });
                }
            }
        };
        $('#submitForm').ajaxSubmit(ajax_option);


    }

    function fix1submit() {
        var productcode=$("#productcode").val("")
        $("#submittrenewalForm").submit();
    }

    function change(){//按钮单击事件

        var productcode=$("#productcode").val("")
        $("#submitwechatForm").submit();
    }

</script>
</@override>
<@override name="right">
<div class="row">
    <input hidden type="text" value="${productInfo.componentprice}" id="productprice">
    <input hidden type="text" value="${serverdiscount}" id="serverdiscount">
    <div class="col-md-12">
        <div class="portlet light ">
            <div class="portlet-title">
                <div class="caption font-dark">
                    <span class="caption-subject bold uppercase main-content-title">商户续费</span>
                </div>
            </div>
            <div class="panel-body">
                <form action="${ctxPath}/renew/order/payAgainMerchantStandard.action" method="post" id="submitForm">
                    <input type="text" id="orderInfo" name="orderInfo" hidden />
                    <div class="col-md-12">
                        <label class="control-label col-md-12" style="padding-left: 0px"><h5 style="font-weight:bold"><img src="${ctxPath}/images/label.png" style="width: 5px;margin-right: 5px;"/>续费产品</h5></label>
                        <div class="col-md-12" style="padding-left: 0px ;">
                            <div class="col-md-8"  style="margin-bottom:15px;margin-top:15px;padding-left: 0px ;" >
                                ${productInfo.componentname}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <label class="control-label col-md-12" style="padding-left: 0px"><h5 style="font-weight:bold"><img src="${ctxPath}/images/label.png" style="width: 5px;margin-right: 5px;"/>续费方式</h5></label>
                        <div class="col-md-12" style="padding-left: 0px ;">
                            <div class="col-md-8"  style="margin-bottom:15px;margin-top:15px;padding-left: 0px ;" >
                                <form action="${ctxPath}/wechattrenewal/wehcat/marketingAssistantadd.action?productcode=ZLRJ004&type='4'" method="get" id="submitwechatForm">
                                    <input type="radio" onclick="change()"  checked="checked" />购买新营销助手码
                                </form>
                            </div>
                            <div class="col-md-8"  style="margin-bottom:15px;margin-top:15px;padding-left: 0px ;" >
                                <form action="${ctxPath}/wechattrenewal/wehcat/marketingAssistant.action?productcode=ZLRJ004&type='4'" method="get" id="submittrenewalForm">
                                    <input type="radio" onclick="fix1submit()" />已有营销助手码续费
                                    <input type="hidden"  name="productcode" value="ZLRJ004"  />
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12" style="padding-left: 0px">
                        <label class="control-label col-md-12"><h5 style="font-weight:bold"><img src="${ctxPath}/images/label.png" style="width: 5px;margin-right: 5px;"/>选择门店</h5></label>
                        <div class="col-md-12">
                            <div class="col-md-8" style="margin-bottom:15px;padding-left: 0px;">
                                <input type="text" hidden value="${productInfo.componentcode}" name="productcode" id = "productcode" />
                                <button type="button" class="btn btn-primary" onclick="singleShop()"><span style="color: white">+选择门店</span></button>
                                <button type="button" onclick="restSingleShop()" class="btn btn-primary" style="background-color: grey"><span>重置</span></button>
                            </div>
                        </div>
                        <div class="col-md-12" style="margin-top: 15px;padding-left: 0px;margin-bottom: 0px;">
                            <div class="col-md-1" style="margin-bottom:0px;padding-left: 0px;">
                                选择年限：
                            </div>
                            <div class="col-md-9" style="margin-bottom:15px;padding-left: 0px;margin-bottom:0px">
                                    <#if productInfo.priceList??>
                                        <#list productInfo.priceList as price>
                                            <div class="col-md-2" style="margin-bottom:15px;padding-left: 0px;margin-bottom:0px">
                                                <input type="radio" onclick="allRadioClick(this)" price="${price.componentprice!''}" name="allYear" value="${price.year!''}"/>
                                                <input type="text" hidden name="yearParts" value="${price.year!''}"/>
                                                <input type="text" hidden name="priceParts" value="${price.componentprice!''}"/>
                                                ${price.componentprice!''}元/${price.year}${price.smstype!''}
                                            </div>
                                        </#list>
                                    </#if>
                            </div>
                        </div>
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
                            <th> 购买数量</th>
                            <th> 选择续费年限</th>
                            <th> 折扣%</th>
                            <th> 价格（元）</th>
                            <th> 操作</th>
                        </tr>
                        </thead>
                        <tbody class="shopData">
                        <tr>
                            <td valign="top" colspan="11" class="dataTables_empty">暂无数据</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-6" style="margin-top: 50px">
                <button type="button"  class="btn btn-primary btn-default  center-block" id = "sumbitButton" style="margin-right: 10px;" onclick="submitOrder()">提交订单</button>
            </div>
            </form>
        </div>
    </div>
</div>
</div>
</@override>
<@override name="window">
    <#include "../choose_assi_shop.ftl" />
</@override>
<@extends name="../base_main.ftl"/>