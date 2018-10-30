<@override name="jsfile">
    <script src="${ctxPath}/js/jquery.form.js" type="text/javascript"></script>
</@override>
<@override name="csstext">
    <style type="text/css">
        .shoplist {
            width: 750px;
            margin: 10px auto;
            box-sizing: border-box;
            border: 1px solid #eee;
            height: 356px;
            font-size: 14px;
            color:#333;
        }
        .shoplistLeft {
            border-right: 1px solid #eee;
        }
        .shoplistLeft, .shoplistRight {
            box-sizing: border-box;
            float: left;
            width: 49.99%;
            position: relative;
            height: 100%;
            padding: 0 10px;
            overflow: auto;
        }
        .shopSearchContent {
            margin: 10px 0;
        }
        .alreadySelectedShop {
            border-bottom: 1px solid #ccc;
            padding: 12px 0;
            margin-bottom: 4px;
        }
        .shoplistRight ul, .branchItemList ul {
            margin: 0;
            padding:0;
        }
        .shoplistRight ul li {
            position: relative;
            line-height: 24px;
            padding:0 10px;
        }
        .shoplistRight ul li:hover {
            background-color: #f1f1f1;
        }
        .shoplistRight ul li span {
            position: absolute;
            right: 10px;
            font-family: "arial","tahoma";
            cursor:pointer;
        }
        .branchItemList .mr15 {
            margin-right: 15px;
        }
        .branchItemList ul li {
        }
        .branchItemList ul li.pr {
            /*cursor: pointer;*/
            padding: 0 10px;
            margin-bottom: 5px;
        }
        .branchItemList ul li span.pa {
            right:10px;
            top: 3px;
            cursor: pointer;
        }
        .branchItemList .branchItemChild {
            list-style: none;
            padding-left: 46px;

        }
        .branchItemList .branchItemChild label {
            display: block;
        }
        .branchItemList .branchItemChild * {
            font-weight: normal;
        }
        .pr {
            position: relative;
        }
        .pa {
            position: absolute;
        }
        .dn {
            display: none;
        }
    </style>
</@override>
<@override name="jstext">
    <script type="text/javascript">

    $(function(){
			//左侧商户点击时候的效果
			$("body").on('click', '.branchItemList>ul>li', function(){
			// $('.branchItemList>ul>li').click(function(){
				var branchItemChild = $(this).find('.branchItemChild');
				branchItemChild.toggleClass('dn');
				if(branchItemChild.is(':visible')) {
					branchItemChild.prev().removeClass('glyphicon-menu-up').addClass('glyphicon-menu-down');
				} else {
					branchItemChild.prev().removeClass('glyphicon-menu-down').addClass('glyphicon-menu-up');
				}
			})

			//全选子项 或 取消全选
			$("body").on('click', '.selectAllChilds', function(e){
				var checked = $(this)[0].checked;
				$(this).parent().find('.branchItemChild :checkbox').each(function(){
					//父级取消全选 || 子项未选
					if(checked === false || $(this)[0].checked === false) {
						$(this)[0].checked = checked;
						$(this).trigger('change');
					}
				})

				//如果子项没有展开，则展开子项
				if(!$(this).parent().find('.branchItemChild').is(":visible")) {
					$(this).parent().trigger('click');
				}
				e.stopPropagation();
			});
			/*$('.selectAllChilds').click(function(){
				var checked = $(this)[0].checked;
				$(this).parent().find('.branchItemChild :checkbox').each(function(){
					//父级取消全选 || 子项未选
					if(checked === false || $(this)[0].checked === false) {
						$(this)[0].checked = checked;
						$(this).trigger('change');
					}
				})

				//如果子项没有展开，则展开子项
				if(!$(this).parent().find('.branchItemChild').is(":visible")) {
					$(this).parent().trigger('click');
				}
			});*/

			//商户下的子项目  门店点选时候的处理
			$("body").on('change', '.branchItemChild :checkbox', function(e){
				var value = $(this).val();

                var shopcode = $(this).attr("shopcode");
                var branchcode = $(this).attr("branchcode");
                var shopname = $(this).attr("shopname");
                var branchname = $(this).attr("branchname");
                var expirestime = $(this).attr("expirestime");
                var appendHTML = '<li data="'+value+'">' + value + '<span title="移除选项">X</span>';
                appendHTML += '<input hidden type = "text" name="shopcode" value="'+ shopcode +'"/>'
                appendHTML += '<input hidden type = "text" name="branchcode" value="'+ branchcode +'"/>'
                appendHTML += '<input hidden type = "text" name="shopname" value="'+ shopname +'"/>'
                appendHTML += '<input hidden type = "text" name="branchname" value="'+ branchname +'"/>'
                appendHTML += '<input hidden type = "text" name="expirestime" value="'+ expirestime +'"/>'
                appendHTML += '</li>';

				//获取当前父级中一共有多少个子项的checkbox
				var checkboxLength = $(this).parents('.branchItemChild').find(":checkbox").length;

				//获取当前父级中一共有多少个子项的checkbox被选中
				var checkboxCheckedLength = $(this).parents('.branchItemChild').find(":checked").length;

				// alert(checkboxCheckedLength);

				//如果选中的子项 跟 子项数量相等,那么选中父级的checkbox
				if(checkboxLength == checkboxCheckedLength) {
					$(this).parents('.branchItemChild').parent().find('.selectAllChilds')[0].checked = true;
				} else {
					$(this).parents('.branchItemChild').parent().find('.selectAllChilds')[0].checked = false;
				}

				if($(this)[0].checked == true) {
                    // 判断是否存在，如果存在不添加
                    var flag = false;
                    $(".selectedBranchItem li").each(function () {
                        var data = $(this).attr("data");
                        if (value == data){
                            flag = true;
                            return true;
                        }
                    });
                    if (flag){
                        return;
                    }
					$(appendHTML).appendTo('.selectedBranchItem');
				} else {
					//取消选择,移除对应项
					$('.selectedBranchItem li').each(function(){
						if($(this).attr('data') == value) {
							$(this).remove();
						}
					})
				}
				e.stopPropagation();
			});

			//右侧x点击删除事件
			$("body").on('click', '.selectedBranchItem li span', function(){
				var value = $(this).parent().attr("data");
				$(this).parent().remove(); //删除右侧选项

				//同时需要把左侧的选中项反选
				$('.branchItemChild :checkbox').each(function(){
					if(value == $(this).val()) {
						$(this)[0].checked = true;
						$(this).trigger('click');
					}
				})
			});

			//阻止冒泡
			$("body").on('click', '.branchItemChild li', function(e){
				e.stopPropagation();
			});
		})
        // =======================================  联动JS 勿动 =======================================
        function multipleShop(){
            $('#shop_parts').modal('show');
        }

        function queryMultipleShop() {
           // 查询门店信息
            var keyword = $("#keyword").val();
            if (!keyword){
                AlertMsg("请输入门店编码或名称查询！");
                return;
            }
            var url = '${ctxPath}/renew/chooseShop/findMultipleShop.action?type=renew';
            var params = {
                keyword:keyword
            };
            ajaxSyncInSameDomain(url, params, function (result) {
                var json = eval(result);
                var length = json.length;
                var html = "";
                for (var i = 0; i < length; i++){
                    html += '<li class="pr">';
                    html += '<input class="selectAllChilds" type="checkbox" />';
                    html += '<span class="mr15">'+ json[i].shopcode +'</span>';
                    html += '<span class="mr15">'+ json[i].shopname +'</span>';
                    html += '<span class="glyphicon glyphicon-menu-up pa"></span>';
                    html += '<ul class="branchItemChild dn">';
                    var branchList = json[i].branchlist;
                    var branchlength = branchList.length;
                    for (var j = 0; j < branchlength; j++) {
                        html += '<li>';
                        html += ' <label>';
                        html += '   <input type="checkbox" ' +
                                'expirestime="'+ branchList[j].expirestime +'" ' +
                                'shopcode="'+ json[i].shopcode +'" ' +
                                'shopname="'+ json[i].shopname +'" ' +
                                'branchcode="'+ branchList[j].branchcode +'" ' +
                                'branchname="'+ branchList[j].branchname +'" ' +
                                'value="'+json[i].shopcode + '-'+branchList[j].branchcode +'-'+ branchList[j].branchname +'">';

                        html += '   <span class="mr15">'+branchList[j].branchcode+'</span>';
                        html += '   <span>'+branchList[j].branchname+'</span>';
                        html += '  </label>';
                        html += '</li>';
                    }
                    html += '</ul></li>';
                }
                // 追加
                $('.branchItemList ul').html(html);
            });
        }

        // 保存按钮
        function finish() {
            var html = '';
            if ($('.selectedBranchItem li').length == 0){
                AlertMsg("请选择需要续费的门店!");
                return false;
            }
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

            var index = 1;
            $('.selectedBranchItem li').each(function () { // 所有的li标签
                var shopcode = "";
                var shopname = "";
                var branchcode = "";
                var branchname = "";
                var expirestime = "";
                $(this).find("input").each(function () { // li标签下所有的input标签
                    var name = $(this).attr("name");
                    var value = $(this).val();
                    switch (name){
                        case "shopcode" : shopcode = value;
                            break;
                        case "shopname" : shopname = value;
                            break;
                        case "branchcode" : branchcode = value;
                            break;
                        case "branchname" : branchname = value;
                            break;
                        case "expirestime" : expirestime = value;
                            break;
                    }
                });
                html += '<tr id ="'+ shopcode + branchcode +'" name="data">';
                html += ' <td> '+index+'</td>';
                html += ' <td> '+shopcode+'</td>';
                html += ' <td> '+shopname+'</td>';
                html += ' <td> '+branchcode+'</td>';
                html += ' <td> '+branchname+'</td>';
                html += ' <td> '+expirestime+'</td>';
                // 续费年限
                html += ' <td>'
                html += '<input type="text" hidden name="shopcode" value="'+ shopcode+'" />';
                html += '<input type="text" hidden name="shopname" value="'+ shopname+'" />';
                html += '<input type="text" hidden name="branchcode" value="'+ branchcode+'" />';
                html += '<input type="text" hidden name="branchname" value="'+ branchname+'" />';
                html += '<input type="text" hidden name="expirestime" value="'+ expirestime+'" />';
                for (var i = 0 ; i < allYeas.length ;i++){
                    html += "<input class='yearRadio' type='radio' onclick='radioClick(this)' name = '"+ shopcode + branchcode +"' price='"+ allYeas[i].price +"' value='"+ allYeas[i].year +"'/>" +  allYeas[i].year +"年 &nbsp;&nbsp;"
                }
                html += '</td>';
                html += " <td><input onblur='writeDiscount(this)' class='form-control'  name = 'discount' id='discount' value='100'/></td>"
                html += ' <td>0</td>';
                html += "<td><a href='JavaScript:void(0)' data='"+ $(this).attr("data") +"' onclick='deleteColumn(this)'>删除</a></td>"
                html += '</tr>';
                index++;
            });

            html +='<tr>';
            html +='<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>';
            html +="<td>合计总价:</td><td id='totalamount'>0元</td>";
            html +='</tr>';
            $("table tbody").html(html);
            $('#shop_parts').modal('hide');
            // 清空所有的额选中
            $("input[name='allYear']").each(function () {
                this.checked = false;
            });
        }

        function deleteColumn(e) {
            var parentId = $(e).parent().parent().attr("id");
            var amount =  parseFloat($(e).parent().prev().html()) * 100;
            var totalamount = parseFloat($('#totalamount').html()) * 100;
            $("table tbody tr[id='"+parentId+"']").remove();
            var data = $(e).attr("data");
            // 删除
            $('.selectedBranchItem li[data="'+ data +'"]').remove();
            $('.branchItemChild li input[value="'+ data +'"]')[0].checked = false;
            $('.branchItemChild li input[value="'+ data +'"]').parent().parent().parent().parent().find(".selectAllChilds")[0].checked = false;
            if($("table tbody").children().length == 1){
                var html = "<tr><td valign='top' colspan='11' class='dataTables_empty'>暂无数据</td></tr>"
                $("table tbody").html(html);
            }else{
                totalamount = totalamount - amount;
                $('#totalamount').html((totalamount / 100)+ "元");
            }
        }

    function writeDiscount(e) {
        var discount = $(e).val();
        var flag = isRealNum(discount);
        var serverdiscount = parseFloat($("#serverdiscount").val());
        if(!flag || discount > 100 ){
            AlertMsg("请输入"+serverdiscount+"%到100%之间的折扣比例!");
            discount = 100;
            $(e).val(100);
        }
        if (discount < serverdiscount){
            AlertMsg("请输入"+serverdiscount+"%到100%之间的折扣比例!");
            discount = serverdiscount;
            $(e).val(serverdiscount);
        }
        // 计算金额
        var productprice = parseFloat($(e).parent().prev().find("input[type='radio']:checked").attr("price")) * 100;
        if (!productprice){
            productprice = 0;
        }
        var oldprice = parseFloat($(e).parent().next().html()) * 100;
        var newprice = (productprice * discount / 100 / 100).toFixed(2) * 100;
        // 修改后面的金额
        $(e).parent().next().html(newprice / 100);
        $("#totalamount").html(((parseFloat($("#totalamount").html())*100 - oldprice + newprice)/100) + "元");
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
    
    function allRadioClick(e) {
        var year = $(e).val();
        var price = parseFloat($(e).attr("price")) * 100;
        var totalamount = 0;
        // 修改所有的复选框
        $("table tbody input[value='"+year+"']").each(function () {
            this.checked = "checked";
            var discount =  parseFloat($(this).parent().next().find("input[name='discount']").val());
            var subtotal = (discount * price / 100  / 100).toFixed(2) * 100;
            // 修改后面的金额
            totalamount += subtotal
            $(this).parent().next().next().html(subtotal / 100);
        })
        $("#totalamount").html( (totalamount / 100)+ "元");
    }
        
    function radioClick(e) {
        // 清空所有的额选中
        $("input[name='allYear']").each(function () {
            this.checked = false;
        });
        var flag = true;
        var year = "";
        var index = 0;

        if(($("table tbody tr").length - 1) == $("table tbody input[type='radio']:checked").length){
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
        // 获取当前的原价格
        var oldPrice = parseFloat($(e).parent().next().next().html()) * 100;
        var price =  parseFloat($(e).attr("price")) * 100;
        var discount = parseFloat($(e).parent().next().find("input[name='discount']").val());
        var newPrice = (price * discount / 100/ 100).toFixed(2) * 100;
        $(e).parent().next().next().html(newPrice / 100);
        $("#totalamount").html(((parseFloat($("#totalamount").html())*100 - oldPrice + newPrice) / 100) + "元");
    }

    function submitOrder(){
        var productcode = $('#productcode').val(); // 产品code
        // 获取tbody下的所有的tr 标签
        var radioLength = $("table tbody tr[name='data'] input[class='yearRadio']:checked").length;
        var dataLength = $("table tbody tr[name='data']").length;
        if (dataLength == 0){
            AlertMsg("请选择门店！");
            return;
        }
        if (radioLength != dataLength){
            AlertMsg("请选择续费年限！");
            return;
        }
        var param = new Object();
        param.productcode = productcode;
        param.type = 1;
        var objArr = new Array();
        $("table tbody tr[name='data']").each(function () {
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
                    window.location = "${ctxPath}/renew/order/toPayView.action?billcode=" + result.data
                }else{
                    AlertMsg(result.errorMsg,function () {
                        $("#sumbitButton").attr("disabled",false);
                    });
                }
            }
        };
        $('#submitForm').ajaxSubmit(ajax_option);


    }

    function restSingleShop() {
        var html = "<tr><td valign='top' colspan='11' class='dataTables_empty'>暂无数据</td></tr>"
        $("table tbody").html(html);
        // 删除
        $('.selectedBranchItem li').remove();
        $(".branchItemList input[type='checkbox']").each(function () {
            this.checked = false;
        })
    }

    </script>
</@override>
<@override name="right">
<div class="row">
    <input hidden type="text" value="${serverdiscount}" id="serverdiscount">
    <input type="text" hidden value="${productInfo.componentcode}" name="productcode" id = "productcode" />
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
                        <div class="col-md-12" style="padding-left: 0px">
                            <div class="col-md-8"  style="margin-bottom:15px;margin-top:15px;padding-left: 0px">
                                ${productInfo.componentname}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12" style="padding-left: 0px">
                        <label class="control-label col-md-12"><h5 style="font-weight:bold"><img src="${ctxPath}/images/label.png" style="width: 5px;margin-right: 5px;"/>选择门店</h5></label>
                        <div class="col-md-12" style="padding-bottom: 0px">
                            <div class="col-md-12" style="margin-bottom:15px;padding-left: 0px;">
                                <button type="button" class="btn btn-primary" onclick="multipleShop()"><span style="color: white">+选择门店</span></button>
                                <button type="button" onclick="restSingleShop()" class="btn btn-primary" style="background-color: grey"><span>重置</span></button>
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
                                    <th> 门店编号</th>
                                    <th> 门店名称</th>
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
     <div id="shop_parts" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
         <div class="modal-dialog" style="width: 800px;height:800px">
             <div class="modal-content">
                 <div class="modal-header">
                     <h3>
                         添加门店
                         <button type="button" class="btn btn-primary btn-default  pull-right" data-dismiss="modal" aria-hidden="true" style="background-color: grey">关闭</button>
                         <button type="button" class="btn btn-primary btn-default  pull-right" style="margin-right: 10px;" onclick="finish()">保存</button>
                     </h3>
                 </div>
                 <div class="modal-body">
                     <form action="#" class="form-horizontal" method="post">
                         <div class="shoplist">
                             <div class="shoplistLeft">
                                 <div class="shopSearchContent pr">
                                     <input style="width: 193px;" class="form-control" id="keyword" name="keyword" placeholder="输入商户ID、名称查询">
                                     <button type="button" class="btn btn-default pa" onclick="queryMultipleShop();" style="top:0px; right:0px;" >
                                         <i class="fa fa-search"></i> 查询
                                     </button>
                                 </div>
                                 <div class="branchItemList">
                                     <ul>
                                     </ul>
                                 </div>
                             </div>
                             <div class="shoplistRight">
                                 <p class="alreadySelectedShop">已选择门店</p>
                                 <ul class="selectedBranchItem">
                                 </ul>
                             </div>
                         </div>
                     </form>
                 </div>
             </div>
         </div>
     </div>
</@override>
<@extends name="../base_main.ftl"/>