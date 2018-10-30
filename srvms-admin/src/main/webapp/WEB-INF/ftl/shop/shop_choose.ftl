<#include "../default_cfg.ftl"/>
<script>

    function refreshShopList(params) {
        var url = '${ctxPath}/srv/shop/list.action';
        ajaxInSameDomain(url, params, function (result) {
            $('#module-menus').html(result);
        }, 'html')
    }

    function searchShop() {
        var params = {
            keyword:$('.modal-body #keyword').val()
        };
        refreshShopList(params);
        $('#formID').serialize()
    }

</script>
<div class="modal-header">
    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
    <h3>选择商户</h3>
</div>
<div class="modal-body">
    <form action="#" id="searchForm" class="form-horizontal" method="post">
        <div class="form-body">
            <div class="row">
                <div class="col-md-6 col-sm-6">

                    <div class="form-group">
                        <label class="control-label col-md-3">关键字</label>

                        <div class="col-md-9">
                            <input type="text" id="keyword" name="keyword" value="" class="form-control"
                                   placeholder="可输入商户名称/编码进行查询">
                        </div>
                    </div>
                </div>

                <div class="col-md-2 col-sm-6">
                    <button type="button" class="btn btn-default " onclick="searchShop()">
                        <i class="fa fa-search"></i> 搜索
                    </button>
                </div>
            </div>
        </div>
    </form>
    <div id="module-menus" style="padding-top:5px;">
    <#include "./shop_list.ftl"/>
    </div>
</div>
<div class="modal-footer">
    <a href="#" class="btn btn-default" data-dismiss="modal" aria-hidden="true">关闭</a>
</div>