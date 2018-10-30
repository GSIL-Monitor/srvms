<@override name="jstext">
<script>
    function search() {
        $("#searchForm").attr('action', '${ctxPath}/lucre/income/incomeByMonthDetail.action');
        $("#searchForm").submit();
    }

    function exportExcel() {
        $("#searchForm").attr('action', '${ctxPath}/lucre/income/incomeByMonthDetailexport.action');
        var pageform = $('.tdtd')[0];
        console.log(pageform)
        if(pageform==undefined){
            AlertMsg('暂无数据可导出！');
            return;
        }
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

    function reset() {
        $("#searchForm").reset();
    }
    function queryReset() {
        $("#servername").val("");
        $("#shopname").val("");
        $("#branchname").val("");
        $("#searchForm").attr('action', '${ctxPath}/lucre/income/incomeByMonthDetail.action');
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
        $("#month").val("");
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
                <div class="caption font-dark">
                    <i class="icon-settings font-dark"></i>
                    <span class="caption-subject bold uppercase main-content-title">收单收益详情</span>
                </div>
                <div class="actions">
                    <button type="button" class="btn default" onclick="fanhui()">返回</button>
                </div>
                <div class="actions">
                    <button type="button" class="btn btn-default  btn-sm" onclick="exportExcel()">
                        <i class="icon-doc"></i> 下载明细
                    </button>
                </div>

            </div>

            <div class="portlet-body form">
                <form class="search-form form-horizontal" action="${ctxPath}/lucre/income/incomeByMonthDetail.action"
                      id="searchForm"
                      method="post">
                    <input type="hidden" id="paymethod" name="paymethod"
                           value="${paymethod!''}" class="paymethod">
                    <input type="hidden" id="month" name="month"
                           value="${month!''}" class="month">
                    <div class="form-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label col-md-4">服务商</label>

                                    <div class="col-md-8">
                                        <input type="text" id="servername" name="servername"
                                               value="${RequestParameters.servername!''}" class="form-control"
                                        >
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label col-md-4">商户</label>

                                    <div class="col-md-8">
                                        <input type="text" id="shopname" name="shopname"
                                               value="${RequestParameters.shopname!''}" class="form-control"
                                        >
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label col-md-4">门店</label>

                                    <div class="col-md-8">
                                        <input type="text" id="branchname" name="branchname"
                                               value="${RequestParameters.branchname!''}" class="form-control"
                                        >
                                    </div>
                                </div>
                            </div>
                            <div class="row">

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
                            <th> 门店名称</th>
                            <th> 所属商户</th>
                            <th> 所属服务商</th>
                            <th> 有效收单金额（元）</th>
                            <th> 有效退款金额（元）</th>
                            <th>服务商收益比例</th>
                            <th> 服务收益总额（元)</th>
                            <th>平台总收益（元)</th>
                        </tr>
                        </thead>
                        <tbody>
                            <#if pageInfo?? && pageInfo.list??>
                                <#import "../rownum.ftl" as q>
                                <#list pageInfo.list as user>

                                <tr>
                                    <td class="tdtd"> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=user_index /></td>
                                    <td>${user.branchname!''}</td>
                                    <td>${user.shopname!''}</td>
                                    <td>${user.servername!""}</td>
                                    <td>${user.relpayamount!""}</td>
                                    <td>
                                        ${user.returnmoney!""}
                                    </td>
                                    <td>
                                        ${user.settlerate!""}
                                    </td>
                                    <td>${user.sshouldpayamount!""}</td>
                                    <td>${user.shouldpayamount!""}</td>
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
			                    <@q.pager page=pageInfo.page pageSize=pageInfo.pageSize totalRecords=pageInfo.totalRecords toURL="${ctxPath}/shop/manage.action" pageid="user_list_form"/>
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
