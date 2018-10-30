<@override name="jstext">
<script>
    function singleShop() {
        ChooseSingleShop.open(null ,function (params) {
            // 遍历
            var length = params.length;
            var html = "<tr><td valign='top' colspan='11' class='dataTables_empty'>暂无数据</td></tr>"
            if (length > 0){ // 有数据
                html = '';
                var productprice = $("#productprice").val();
                var totalamount = 0;
                for (var i = 0 ; i < length; i++){
                    html += '<tr id ="'+ params[i].shopcode +'">';
                    html += "<td>"+ (i+1) +"</td>"
                    html += "<td>"+ params[i].shopcode +"</td>"
                    html += "<td>"+ params[i].shopname +"</td>"
                    html += "<td>"+ params[i].expiretime +"</td>"
                    html += "<td><input " +
                            "onblur='writeDiscount(this)' class='form-control'  name = 'discount' id='discount' value='100'/></td>"
                    html += "<td>" + productprice + "</td>"
                    html += "<td><a href='#' onclick='deleteColumn(this)'>删除</a></td>"
                    html += '</tr>';
                    totalamount += parseInt(productprice);
                }
                html +='<tr>';
                html +='<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>';
                html +="<td>合计总价:</td><td id='totalamount'>"+totalamount+"元</td>";
                html +='</tr>';
            }
            $("table tbody").html(html);
        });
    }

    function deleteColumn(e) {
        var parentId = $(e).parent().parent().attr("id");
        var amount =  parseInt($(e).parent().prev().html());
        var totalamount = parseInt($('#totalamount').html());
        $("table tbody tr[id='"+parentId+"']").remove();
        console.info($("table tbody").children().length);
        if($("table tbody").children().length == 2){
            var html = "<tr><td valign='top' colspan='11' class='dataTables_empty'>暂无数据</td></tr>"
            $("table tbody").html(html);
        }else{
            totalamount = totalamount - amount;
            $('#totalamount').html(totalamount + "元");
        }
    }

    function writeDiscount(e) {
        var discount = $(e).val();
        var flag = isRealNum(discount);
        if(!flag || discount > 100 ){
            discount = 100;
            $(e).val(100);
        }
        var serverdiscount = parseInt($("#serverdiscount").val());

        if (discount < serverdiscount){
            discount = serverdiscount;
            $(e).val(serverdiscount);
        }

        // 计算金额
        var productprice = parseInt($("#productprice").val());
        var oldprice = parseInt($(e).parent().next().html());
        var newprice = productprice * discount / 100;
        // 修改后面的金额
        $(e).parent().next().html(newprice);
        $("#totalamount").html((parseInt($("#totalamount").html()) - oldprice + newprice) + "元");
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

    function submitOrder() {
        var shopcodes = new Array();
        var params = new Array();
        $("table tbody").find("tr").each(function () {
            var index = 0;
            var obj = new Object();
            $(this).find("td").each(function () {
                switch(index){
                    case 0 : index++; return true;
                    case 1 :
                        var flag = shopcodes.indexOf($(this).html());
                        if (flag != -1 || $(this).html() == ''){
                            return false;
                        }
                        shopcodes.push($(this).html());
                        obj.shopcode = $(this).html()
                        break;
                    case 2 :obj.shopname = $(this).html();
                        break;
                    case 3 :obj.branchcode = $(this).html();
                        break;
                    case 4 :obj.branchname = $(this).html();
                        break;
                    case 5 :obj.expiretime = $(this).html();
                        break;
                    case 6 : index++; return true;
                    case 7 : index++; return true;
                    case 8 :obj.discount = $(this).find("input").val();
                }
                index++;
            })
            if(JSON.stringify(obj) != "{}"){
                params.push(obj);
            }
        });
        if (params.length == 0){
            AlertMsg("请选择门店信息!");
            return false;
        }

        var paramsObj = new Object();
        paramsObj.productcode = $('#productcode').val();
        paramsObj.type = 0;
        paramsObj.items = params;
        // 提交单据
        $("#orderInfo").val(JSON.stringify(paramsObj));
        $('#submitForm').submit();
    }



</script>
</@override>
<@override name="right">
<div class="row">
    <input hidden type="text" value="${productInfo.productprice}" id="productprice">
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
                        <label class="control-label col-md-12" style="padding-left: 0px"><h5 style="font-weight:bold"><img src="${ctxPath}/images/label.png" style="size: 30px"/>续费产品</h5></label>
                        <div class="col-md-12">
                            <div class="col-md-8"  style="margin-bottom:15px;margin-top:15px;">
                                ${productInfo.productname}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12" style="padding-left: 0px">
                        <label class="control-label col-md-12"><h5 style="font-weight:bold"><img src="${ctxPath}/images/label.png" style="size: 30px"/>选择门店</h5></label>
                        <div class="col-md-12">
                            <div class="col-md-8" style="margin-bottom:15px;padding-left: 0px;">
                                <input type="text" hidden value="${productInfo.productcode}" name="productcode" id = "productcode" />
                                <button type="button" class="btn btn-primary" onclick="singleShop()"><span style="color: white">+选择门店</span></button>
                                <button type="button" onclick="restSingleShop()" class="btn btn-primary" style="background-color: grey"><span>重置</span></button>
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
                                    <th> 到期时间</th>
                                    <th> 选择续费年限</th>
                                    <th> 折扣%</th>
                                    <th> 价格（元）</th>
                                    <th> 操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td valign="top" colspan="11" class="dataTables_empty">暂无数据</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <button type="button"  class="btn btn-primary btn-default  center-block" id = "sumbitButton" style="margin-right: 10px;" onclick="submitOrder()">提交订单</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</@override>
<@override name="window">
    <#include "../choose_banrch.ftl" />
</@override>
<@extends name="../base_main.ftl"/>