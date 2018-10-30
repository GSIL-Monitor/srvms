<@override name="jstext">
<script>
    zlf.common.initSearchUrl('${ctxPath}/renew/extend/queryExtendInfoList.action');
    function extendProcess() {
        window.location ="${ctxPath}/renew/extend/jumpShopExtend.action";
    }
    $(function(){
        zlf.common.search()
    });

    function resetQuery(){
        $('#extendbillcode').val("");
        $('#shopkey').val("");
        $('#branchkey').val("");
        zlf.common.search();
    }
</script>
</@override>
<@override name="right">
<div class="panel panel-info">
    <div class="panel-heading">筛选</div>
    <div class="panel-body">
        <div class="portlet-body form">
            <form action="#" id="searchForm" class="form-horizontal" method="post">
                <div class="form-body">
                    <div class="row">
                        <div class="col-md-3 col-sm-3">
                            <div class="form-group">
                                <label class="control-label col-md-4">订单编号</label>
                                <div class="col-md-7">
                                    <input type="text" id="extendbillcode" name="extendbillcode" class="form-control" value="${RequestParameters.extendbillcode!''}">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-3">
                            <div class="form-group">
                                <label class="control-label col-md-5">商户ID/名称</label>
                                <div class="col-md-7">
                                    <input type="text" id="shopkey" name="shopkey" class="form-control" value="${RequestParameters.shopkey!''}">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-3">
                            <div class="form-group">
                                <label class="control-label col-md-5">门店ID/名称</label>
                                <div class="col-md-7">
                                    <input type="text" id="branchkey" name="branchkey" class="form-control" value="${RequestParameters.branchkey!''}">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-1 col-sm-1">
                            <button type="button" class="btn btn-default " onclick="zlf.common.search()">
                                <i class="fa fa-search"></i> 搜索
                            </button>
                        </div>
                        <div class="col-md-1 col-sm-1">
                            <button type="button" class="btn btn-default " onclick="resetQuery();">重置</button>
                        </div>
                    </div>
                </div>
            </form>
            <div>
                <button type="button" class="btn btn-primary" onclick="extendProcess()">延长试用期</button>
            </div>
        </div>
    </div>

</div>
<div class="panel panel-default">
    <div class="panel-body table-responsive zl-content-container">
        <#include "order_manage_table.ftl" />
    </div>
</div>
</@override>
<@override name="window">
</@override>
<@extends name="../base_main.ftl"/>