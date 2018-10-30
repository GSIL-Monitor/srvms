<@override name="jstext">
<script>
    function search() {
        $("#searchForm").attr('action', '${ctxPath}/lucre/income/incomebymonth.action');
        $("#searchForm").submit();
    }

    function exportExcel() {
        $("#searchForm").attr('action', '${ctxPath}/lucre/income/incomebymonthExport.action');
        var pageform = $('.tdtd')[0];
        console.log(pageform)
        if(pageform==undefined){
            AlertMsg('暂无数据可导出！');
            return;
        }
        $("#searchForm").submit();
    }



    function reset() {
        $("#searchForm").reset();
    }
    function queryReset() {
        $("#paymethod").val("");
        $("#month").val("");
        $("#searchForm").attr('action', '${ctxPath}/lucre/income/incomebymonth.action');
        $("#searchForm").submit();
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
                });

            } else if (success == '2') {

                refreshAndShowImportError('导入全部失败<br/>导入失败了' + data.errorCount + '条商品数据', data.errorList);

            } else if (success == '3') {

                refreshAndShowImportError('导入部分成功<br/>导入成功了' + data.successCount + '条商品数据<br/>导入失败了' + data.errorCount + '条商品数据', data.errorList);
            }
        }
    }

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
    function fanhui() {
        $("#paymethod").val("");
        $("#searchForm").attr('action', '${ctxPath}/lucre/income/incomebymonth.action');
        $("#searchForm").submit();
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
                        <i class="icon-doc"></i> 导出数据
                    </button>
                </div>
            </div>
            <div class="portlet-body form">
                <form class="search-form form-horizontal" action="${ctxPath}/lucre/income/incomebymonth.action"
                      id="searchForm"
                      method="post">
                    <div class="form-body">
                        <div class="row">
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
                            <div class="row">
                                <div class="row">
                                    <div class="col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">结算月份</label>

                                            <div class="col-md-9">
                                                <input type="text" name="month" id="month"
                                                       value="${RequestParameters.month!''}"
                                                       placeholder="请选择日期"
                                                       readonly="readonly" class="datetimepicker form-control" date-format="Y-m"
                                                       style="padding-left:12px;" >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">

                                        <div class="form-actions">
                                            <div class="col-md-offset-10 col-md-2">
                                                <button type="button" class="btn btn-default " onclick="search()">
                                                    <i class="fa fa-search"></i> 搜索
                                                </button>
                                                <button type="button" onclick="queryReset()" class="btn default">重置
                                                </button>
                                            </div>
                                        </div>
                                    </div>
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
                            <th> 日期</th>
                            <th> 收单方式</th>
                            <th> 有效收单金额（元）</th>
                            <th> 有效退款金额（元）</th>
                            <th> 有效收益基数（元）</th>
                            <th> 服务收益总额（元）</th>
                            <th>平台净收益总额（元）</th>
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
                                    <td>
                                        <#if (user.paymethod!'') == '1'>
                                            <span class="label label-success">支付宝</span>
                                        <#else>
                                        <span class="label label-danger">微信</span>
                                        </#if>
                                    </td>

                                    <td>${user.spayrelamount!""}</td>
                                    <td>${user.sreturnmoney!""}</td>
                                    <td>
                                        ${user.sshouldpayamount!""}
                                    </td>
                                    <td>
                                        ${user.shouldpayamount!""}
                                    </td>
                                    <td>
                                        ${user.ssshouldpayamount!""}
                                    </td>
                                    <td>
                                        <a href="javascript:goto('${ctxPath}/lucre/income/incomeByMonthDetail.action?month=${user.month}&&paymethod=${user.paymethod}','searchForm');"
                                           data-original-title="详情">
                                            详情
                                        </a>
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
			                    <@q.pager page=pageInfo.page pageSize=pageInfo.pageSize totalRecords=pageInfo.totalRecords toURL="${ctxPath}/lucre/income/incomebymonth.action" pageid="user_list_form"/>
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
