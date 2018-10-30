<@override name="jstext">
<script>
    zlf.common.initSearchUrl('${ctxPath}/branchRenew/showShopTableDetail.action');
    $(function () {
        zlf.common.search();
    })
    function renew(shopcode) {
      $("#shopcodeForm").val(shopcode);
      $("#renewForm").submit();
    }
    function extendProbation(shopcode) {
        $("#extendProbationShopcodeForm").val(shopcode);
        $("#extendProbationForm").submit();
    }
    function queryReset() {
        $("#shopcode").val("");
        $("#shopname").val("");
        zlf.common.search();
    }
</script>
</@override>
<@override name="right">
<div class="panel panel-info">
    <form action="${ctxPath}/branchRenew/branchRenewToView.action" id="renewForm" method="post">
        <input type="text" name="shopcode" id="shopcodeForm"  hidden="hidden"/>
    </form>
    <form action="${ctxPath}/branchRenew/extendProbationToView.action" id="extendProbationForm" method="post">
        <input type="text" name="shopcode" id="extendProbationShopcodeForm"  hidden="hidden"/>
    </form>
    <div class="panel-heading">筛选</div>
    <div class="panel-body">
        <form action="#" method="post" class="form-horizontal" role="form" id="searchForm">
            <div class="form-body">
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="control-label col-md-3">商户ID</label>
                            <div class="col-md-9">
                                <input type="text" id="shopcode" name="shopcode"
                                       value="${RequestParameters.shopcode!''}" class="form-control"
                                       placeholder="请输入商户编号">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="control-label col-md-3">商户名称</label>
                            <div class="col-md-9">
                                <input type="text" id="shopname" name="shopname"
                                       value="${RequestParameters.shopname!''}" class="form-control"
                                       placeholder="请输入商户名称">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-1">
                        <button type="button" class="btn btn-default " onclick="zlf.common.search()">
                            <i class="fa fa-search"></i> 搜索
                        </button>
                    </div>
                    <div class="col-md-1">
                        <button type="button" class="btn btn-default " onclick="queryReset()">
                            <i class="fa"></i> 重置
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body table-responsive zl-content-container">
        <#include "branch_table.ftl" />
    </div>
</div>
</@override>

<@extends name="../base_main.ftl"/>