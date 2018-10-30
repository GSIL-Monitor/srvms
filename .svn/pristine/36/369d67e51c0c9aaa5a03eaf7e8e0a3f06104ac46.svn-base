<@override name="jstext">
<script>
    zlf.common.initSearchUrl('${ctxPath}/srv/shop/willExpireBranchListDetail.action');

    $(function(){
        zlf.common.search();
    })
</script>
</@override>
<@override name="right">
<div class="panel panel-info">
    <div class="panel-heading">筛选</div>
    <div class="panel-body">
        <form action="#" method="post" class="form-horizontal" role="form" id="searchForm">
            <div class="form-body">
                <div class="row">
                    <div class="col-md-4">

                        <div class="form-group">
                            <label class="control-label col-md-3">关键字</label>

                            <div class="col-md-9">
                                <input type="text" id="keyword" name="keyword"
                                       value="${RequestParameters.keyword!''}" class="form-control"
                                       placeholder="请输入商户ID进行查询">
                            </div>
                        </div>

                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-default " onclick=" zlf.common.search();">
                            <i class="fa fa-search"></i> 搜索
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body table-responsive zl-content-container">
        <#include "./will_expire_branch_detail.ftl">
    </div>
</div>
</@override>
<@override name="window">
</@override>
<@extends name="../base_main.ftl"/>