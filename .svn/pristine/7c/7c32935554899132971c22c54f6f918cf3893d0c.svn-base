<@override name="jstext">
<script>
    function search() {
        $("#searchForm").attr('action', '${ctxPath}/lucre/manage.action');
        $("#searchForm").submit();
    }

    function exportExcel() {
    var   keyword=  $("#keyword").val()
    var  month = $("#month").val();
    var paymethod= $("#paymethod").val();
      var settlestate= $("#settlestate").val();
        var pageform = $('.tdtd')[0];
        console.log(pageform)
        if(pageform==undefined){
            AlertMsg('暂无数据可导出！');
            return;
        }
        $("#searchForm").attr('action', '${ctxPath}/lucre/getPayIncomeListExport.action');
        $("#searchForm").submit();
    }

    function chooseShop(e) {
        ChooseShop.open(null, function (data) {
            var shopname = checkEmpty(data.name) ? data.code : data.code + "-" + data.name;
            $(e).parent().prev().prev().prev().val(shopname);
            $(e).parent().prev().prev().val(data.id);
            $(e).parent().prev().val(data.code);
        })
    }
    function queryReset() {
        $("#keyword").val("");
        $("#month").val("");
        $("#paymethod").val("");
        $("#settlestate").val("");
        $("#searchForm").attr('action', '${ctxPath}/lucre/manage.action');
        $("#searchForm").submit();
    }

    function reset() {
        $("#searchForm").reset();
    }
    function batchImportCallBack(dataList) {
        debugger;
        if (dataList.length == 0) {
            AlertMsg('请求失败');
        } else {
            var data = dataList[0];
            var success = data.success;
            if (success == '0') {
                AlertMsg(data.errorMsg);
            } else if (success == '1') {

                AlertMsg('导入成功，共导入了' + data.successCount + "条数据", function () {
                    zlf.common.search();
                    queryReset();
                });

            } else if (success == '2') {

                refreshAndShowImportError('导入全部失败<br/>导入失败了' + data.errorCount + '条商品数据', data.errorList);

            } else if (success == '3') {

                refreshAndShowImportError('导入部分成功<br/>导入成功了' + data.successCount + '条商品数据<br/>导入失败了' + data.errorCount + '条商品数据', data.errorList);
            }
        }

    }
  /*  $('.form_date').datetimepicker({
        language:  'zh-CN',
        weekStart: 1,
        todayBtn:  1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 3,
        minView: 4,
        forceParse: 0,
        todayHighlight:true
    });*/
    $(function(){
        $('.form_date').datetimepicker('setEndDate', new Date());
        $('#starttimeselect')
                .datetimepicker()
                .on('changeDate', function(ev){
                    var starttime = $('#starttime').val();
                    if(starttime){
                        $('#endtimeselect').datetimepicker('setStartDate', starttime);
                    }
                });

        $('#endtimeselect')
                .datetimepicker()
                .on('changeDate', function(ev){
                    var endtime = $('#endtime').val();
                    if(endtime){
                        $('#starttimeselect').datetimepicker('setEndDate', endtime);
                    }
                });

    });

    function refreshAndShowImportError(msg, errorList) {

        $('#importErrorTbody').empty();
        $('#importMsg').html(msg);

        for (var index in errorList) {
            $('#importErrorTbody').append('<tr><td>' + errorList[index].rownum + '</td><td>' + errorList[index].errorMsg + '</td></tr>');
        }

        $('#modal-close').modal('show');
        $('#modal-close').unbind('hide.bs.modal').bind('hide.bs.modal', function () {
            window.location.reload();
        })
    }

    //上传回调函数
    function uploadCallBack(dataList, domId) {
        createImageList(dataList, domId);
    }

</script>
</@override>
<@override name="right">

<div class="row">
    <div class="col-md-12">
        <div class="portlet light">
            <div class="portlet-title">
                    <div class="panel-heading">筛选</div>
                <div class="actions">
                    <button type="button" class="btn btn-default  btn-sm" onclick="exportExcel()">
                        <i class="icon-doc"></i> 导出
                    </button>
                </div>
            </div>

            <div class="portlet-body form">
                <form class="search-form form-horizontal" action="${ctxPath}/lucre/manage.action"
                      id="searchForm"
                      method="post">
                    <div class="form-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label col-md-4">服务商</label>

                                    <div class="col-md-8">
                                        <input type="text" id="keyword" name="keyword"   placeholder="服务商，服务商编号，电话号码"
                                               value="${RequestParameters.keyword!''}" class="form-control"
                                             >
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">结算月份</label>

                                        <div class="col-md-9">
                                            <input type="text" name="month" id="month"
                                                   value="${RequestParameters.month!''}"
                                                   placeholder="请选择日期"
                                                   readonly="readonly" class=" datetimepicker form-control"  date-format="Y-m" endDate: new Date()
                                                   style="padding-left:12px;" >
                                        </div>
                                    </div>
                                </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label col-md-4">收单方式</label>

                                    <div class="col-md-8">
                                        <select class="form-control" name="paymethod" id="paymethod">
                                            <option value="">全部</option>
                                            <option value="0"
                                                <#if (RequestParameters.paymethod!'') == '0'>selected</#if>>
                                                微信
                                            </option>
                                            <option value="1"
                                                <#if (RequestParameters.paymethod!'') == '1'>selected</#if>>
                                                支付宝
                                            </option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label col-md-4">结算状态</label>
                                    <div class="col-md-8">
                                        <select class="form-control" name="settlestate" id="settlestate">
                                            <option value="">全部</option>
                                            <option value="0"
                                                <#if (RequestParameters.settlestate!'') == '0'>selected</#if>>
                                                未结算
                                            </option>
                                            <option value="1"
                                                <#if (RequestParameters.settlestate!'') == '1'>selected</#if>>
                                                已结算
                                            </option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-actions">
                                <div class="row margin-top-10">
                                    <div class="col-md-offset-10 col-md-2">
                                        <button type="button" class="btn btn-default " onclick="search()">
                                            <i class="fa fa-search"></i> 搜索
                                        </button>
                                        <button type="button" onclick="queryReset()" class="btn default">重置
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                            <div class="col-md-4">
                                <a class="btn btn-default"
                                   onclick="$.fn.FileUploader.openUploadFile(this, {type:'xls',callback:batchImportCallBack,limit:1024,server:'${ctxPath}/import/wxBillImport.action?branchcode=001'})">
                                    <i class="fa fa-upload"></i> 微信结算导入</a>
                                <a class="btn btn-default"
                                   onclick="$.fn.FileUploader.openUploadFile(this, {type:'xls',callback:batchImportCallBack,limit:1024,server:'${ctxPath}/import/aliBillImport.action?branchcode=001'})">
                                    <i class="fa fa-upload"></i> 支付宝结算导入</a>
                            </div>
                            <#--<div id="starttimeselect" class="input-group date form_date col-md-5" data-date="" data-date-format="yyyy-mm" data-link-field="starttime" data-link-format="yyyy-mm-dd">
                                <input class="form-control" size="16" type="text" value="" readonly>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                            </div>-->
                        <#--<div class="row">

                            <div class="col-md-4">
                                <button type="button" class="btn btn-default " onclick="search()">
                                    <i class="fa fa-search"></i> 搜索
                                </button>
                            </div>
                        </div>-->
                    </div>
                </form>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th style="width:48px;"> 序号</th>
                            <th> 结算月份</th>
                            <th> 服务商编号</th>
                            <th> 服务商</th>
                            <th> 收单方式</th>
                            <th> 有效收单金额（元）</th>
                            <th> 有效笔数（笔）</th>
                            <th> 有效退款金额（元）</th>
                            <th>有效退款笔数（笔）</th>
                            <th> 有效收益基数（元）</th>
                            <th> 有效交易净笔数（笔）</th>
                            <th>收益比例(%)</th>
                            <th>收益金额（元）</th>
                            <th>结算时间</th>
                            <th>结算状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                            <#if pageInfo?? && pageInfo.list??>
                                <#import "../rownum.ftl" as q>
                                <#list pageInfo.list as user>
                                <tr>
                                    <td class="tdtd"> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=user_index /></td>
                                    <td>${user.month!''}</td>
                                    <td>${user.servercode!''}</td>
                                   <td>
                                    <#if (user.servercode)??>
                                    <a href="javascript:goto('${ctxPath}/service/serviceincome/payBillDetailforcheck.action?servercode=${user.servercode}&&paymethod=${user.paymethod}&&month=${user.month}','searchForm');">
                                        <span>${user.servername!''}</span>
                                    </a>
                                    </#if>
                                </td>
                                    <td>
                                        <#if (user.paymethod!'') == '1'>
                                        <span class="label label-success">支付宝</span>
                                      <#else>
                                        <span class="label label-danger">微信</span>
                                      </#if>
                                    </td>
                                    <td>${user.relpayamount!""}</td>
                                    <td>${user.Transactionno!""}</td>
                                    <td>
                                        ${user.returnmoney!""}
                                    </td>
                                    <td>
                                        ${user.returnpercent!""}
                                    </td>
                                    <td>${user.shouldpayamount!""}</td>
                                    <td>${user.Transactionno!""}</td>
                                    <td>${user.settlerate!""}</td>
                                    <td>${user.sshouldpayamount!""}</td>
                                    <td>${user.updatetime!""}</td>
                                    <td>
                                      <#if (user.settlestate!'') == '1'>
                                        <span class="label label-success">已结算</span>
                                      <#else>
                                        <span class="label label-danger">未结算</span>
                                      </#if>

                                    </td>
                                    <td>

                                    <#if user.settlepic??>
                                          <div class="input-group">
                                              <button   style="display:none" class="btn btn-default"  id="bth"
                                                         onclick="$.fn.FileUploader.openUploadFile(this,{type:'image',callback:queryReset,limit:100,server:'${ctxPath}/import/uploadImageFile.action?id=${user.id!""}'})"
                                                         type="button">
                                                  上传凭证
                                              </button>
                                          </div>
                                        <a href=${user.settlepic!""}   target="_blank"  >  查看结算凭证</a>
                                    <#else>
                                        <div class="input-group">
                                            <button   class="btn btn-default"
                                                      onclick="$.fn.FileUploader.openUploadFile(this,{type:'image',callback:queryReset,limit:100,server:'${ctxPath}/import/uploadImageFile.action?id=${user.id!""}'})"
                                                      type="button">
                                                上传凭证
                                            </button>
                                        </div>
                                        <a href=${user.settlepic!""}   target="_blank"   style="display:none" >  查看结算凭证</a>
                                    </#if>


                                    </td>
                                </tr>
                                </#list>
                            <#else>
                            <tr>
                                <td valign="top" colspan="10" class="dataTables_empty">暂无数据</td>
                            </tr>
                            </#if>

                        </tbody>
                    </table>
                </div>
            </div>
            <#if pageInfo?? && pageInfo.totalRecords gt 0>
                <div class="row">
                    <div class="col-md-12 col-sm-12">
                        <form id="user_list_form" method="post">
                            <#import "../pager.ftl" as q>
			                    <@q.pager page=pageInfo.page pageSize=pageInfo.pageSize totalRecords=pageInfo.totalRecords toURL="${ctxPath}/lucre/manage.action" pageid="user_list_form"/>
                        </form>
                    </div>
                </div>
            </#if>
        </div>
    </div>
</div>
</@override>
<@override name="window">
    <#include "../shop/choose-shop.ftl"/>
    <#include "../pluploader.ftl"/>
</@override>
<@extends name="../base_main.ftl"/>
