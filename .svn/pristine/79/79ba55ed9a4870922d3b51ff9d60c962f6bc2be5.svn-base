<@override name="jstext">
<script>
    function search() {
        $("#searchForm").attr('action', '${ctxPath}/service/serviceincome/manage.action');
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
        $("#servername").val("");
        $("#month").val("");
        $("#paymethod").val("");
        $("#searchForm").attr('action', '${ctxPath}/service/serviceincome/manage.action');
        $("#searchForm").submit();
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
            </div>
            <div class="portlet-body form">
                <form class="search-form form-horizontal" action="${ctxPath}/service/serviceincome/manage.action"
                      id="searchForm"
                      method="post">
                    <div class="form-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label col-md-4">选择服务商</label>

                                    <div class="col-md-8">
                                        <input type="text" id="servername" name="servername"
                                               value="${RequestParameters.servername!''}" class="form-control"
                                               placeholder="服务商名称"
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
                                                   readonly="readonly" class="datetimepicker form-control" date-format="Y-m"
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
                            <th width="48px"> 序号</th>
                            <th> 日期</th>
                            <th> 服务商名称</th>
                            <th> 收单方式</th>
                            <th> 有效收单金额（元）</th>
                            <th> 有效收单笔数（笔）</th>
                            <th> 有效退款金额（元）</th>
                            <th> 有效退款笔数（笔）</th>
                            <th> 有效收益基数（元）</th>
                            <th> 收益比例（%）</th>
                            <th> 收益金额（元）</th>
                            <th> 操作</th>
                        </tr>
                        </thead>
                        <tbody>
                            <#if pageInfo?? && pageInfo.list??>
                                <#import "../rownum.ftl" as q>
                                <#list pageInfo.list as user>
                                <tr>
                                    <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=user_index /></td>
                                    <td>${user.month!''}</td>
                                    <td>${user.servername!''}</td>
                                    <td>
                                        <#if (user.paymethod!'') == '1'>
                                            <span class="label label-success">支付宝</span>
                                        <#else>
                                        <span class="label label-danger">微信</span>
                                        </#if>
                                    </td>
                                    <td>${user.spayrelamount!""}</td>
                                    <td>${user.stransactionno!""}</td>
                                    <td>
                                        ${user.sreturnmoney!""}
                                    </td>
                                    <td>
                                        ${user.sreturnpercent!""}
                                    </td>
                                    <td>${user.sshouldpayamount!""}</td>
                                    <td>${user.settlerate!""}</td>
                                    <td>${user.shouldpayamount!""}</td>
                                    <td>
                                        <a href="javascript:goto('${ctxPath}/service/serviceincome/payBillDetail.action?servercode=${user.servercode}&&paymethod=${user.paymethod}&&month=${user.month}','searchForm');"
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
			                    <@q.pager page=pageInfo.page pageSize=pageInfo.pageSize totalRecords=pageInfo.totalRecords toURL="${ctxPath}/service/serviceincome/manage.action" pageid="user_list_form"/>
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
