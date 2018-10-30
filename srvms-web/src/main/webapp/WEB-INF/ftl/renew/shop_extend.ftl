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
            var productcode = $('#productcode').val(); // 产品code
            var url = '${ctxPath}/renew/chooseShop/findMultipleShop.action?type=extend&';
            if (productcode == 0){
                url += "single=single";
            }
            if (productcode == 1){
                url += "multiple=multiple";
            }
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
                html += ' <td> '+expirestime;
                // 续费年限
                html += '<input type="text" hidden name="shopcode" value="'+ shopcode+'" />';
                html += '<input type="text" hidden name="shopname" value="'+ shopname+'" />';
                html += '<input type="text" hidden name="branchcode" value="'+ branchcode+'" />';
                html += '<input type="text" hidden name="branchname" value="'+ branchname+'" />';
                html += '<input type="text" hidden name="expirestime" value="'+ expirestime+'" />';
                html += '</td>';
                html += "<td><a href='JavaScript:void(0)' data='"+ $(this).attr("data") +"' onclick='deleteColumn(this)'>删除</a></td>"
                html += '</tr>';
                index++;
            });
            $("table tbody").html(html);
            $('#shop_parts').modal('hide');
        }

    function deleteColumn(e) {
        var parentId = $(e).parent().parent().attr("id");
        var amount =  parseInt($(e).parent().prev().html());
        var totalamount = parseInt($('#totalamount').html());
        $("table tbody tr[id='"+parentId+"']").remove();
        var data = $(e).attr("data");
        // 删除
        $('.selectedBranchItem li[data="'+ data +'"]').remove();
        $('.branchItemChild li input[value="'+ data +'"]')[0].checked = false;
        $('.branchItemChild li input[value="'+ data +'"]').parent().parent().parent().parent().find(".selectAllChilds")[0].checked = false;
        if($("table tbody").children().length == 0){
            var html = "<tr><td valign='top' colspan='11' class='dataTables_empty'>暂无数据</td></tr>"
            $("table tbody").html(html);
        }
    }
    function submitOrder(){
        var productcode = $('#productcode').val(); // 产品code
        // 获取tbody下的所有的tr 标签
        var dataLength = $("table tbody tr[name='data']").length;

        if (dataLength == 0){
            AlertMsg("请选择门店！");
            return;
        }
        $('#remark_model').modal('show');
    }
    function finishExtend(){
        var remark = $('#remark').val();
        if (!remark || remark == ''){
            AlertMsg("请输入备注!");
            return;
        }
        if (remark.length > 500){
            AlertMsg("请输入500字以为的备注信息!");
            return;
        }
        var productcode = $('#productcode').val(); // 产品code
        var param = new Object();
        param.productcode = productcode;
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
                }
            });
            objArr.push(obj);
        });
        param.items = objArr;
        param.remark = remark;
        $("#extendInfo").val(JSON.stringify(param));
        //$("#submitForm").submit();
        $("#sumbitButton").attr("disabled",true)
        var ajax_option={
            success:function(data){
                var result = eval(data);
                if (result.success == 1){
                    AlertMsg(result.data,function () {
                        window.location = "${ctxPath}/renew/extend/extendManage.action"
                    });
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
        var html = "<tr><td valign='top' colspan='7' class='dataTables_empty'>暂无数据</td></tr>"
        $("table tbody").html(html);
        // 删除
        $('.selectedBranchItem li').remove();
        $(".branchItemList li").remove();
    }
    </script>
</@override>
<@override name="right">
<div class="row">
    <div class="col-md-12">
        <div class="portlet light ">
            <div class="portlet-title">
                <div class="caption font-dark">
                    <span class="caption-subject bold uppercase main-content-title">延长试用期</span>
                </div>
            </div>
            <div class="panel-body">
                <form action="${ctxPath}/renew/extend/saveExtendInfo.action" method="post" id="submitForm">
                    <input type="text" id="extendInfo" name="extendInfo" hidden />
                    <div class="col-md-12">
                        <label class="control-label col-md-12" style="padding-left: 0px"><h5 style="font-weight:bold"><img src="${ctxPath}/images/label.png" style="width: 5px;margin-right: 5px;"/>选择产品</h5></label>
                        <div class="col-md-12" style="padding-left: 0px;margin-top: 20px;margin-bottom:  20px">
                            <div class="col-md-1" style="padding-left: 0px ;padding-top :7px">
                               <p>产品名称：</p>
                            </div>
                            <div class="col-md-3" tyle="padding-left: 0px;">
                                <select onchange="restSingleShop()" style="width: 200px" class="form-control" name="productcode" id="productcode" tyle="padding-left: 0px;" >
                                    <option value="0">商户后台-标准版</option>
                                    <option value="1">商户后台-连锁版</option>
                                </select>
                            </div>
                            <div class="col-md-1" style="padding-left: 0px;padding-top :7px">
                                <span>延长天数：</span>
                            </div>
                            <div class="col-md-4" style="padding-left: 0px;padding-top :7px">
                                <span>7天</span>
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
                        <button type="button"  class="btn btn-primary btn-default  center-block" id = "sumbitButton" style="margin-right: 10px;" onclick="submitOrder()">延长试用期</button>
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
    <!-- 备注 -->
    <div id="remark_model" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
        <div class="modal-dialog" style="width: 500px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>
                        延长试用期
                    </h3>
                </div>
                <div class="modal-body" style="height: 240px">
                    <form action="#" class="form-horizontal" method="post">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-3" style="margin-top: 50px"><span style="color: red">*</span>备注</label>
                                <div class="col-md-9">
                                    <textarea class="form-control" rows="5" name="remark" id="remark" ></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12" style="padding-top: 50px;padding-left: 170px">
                            <button type="button" class="btn btn-primary btn-default" style="margin-right: 10px;" onclick="finishExtend()">保存</button>
                            <button type="button" class="btn btn-primary btn-default" data-dismiss="modal" aria-hidden="true" style="background-color: grey">关闭</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</@override>
<@extends name="../base_main.ftl"/>