<@override name="jstext">
<script>
    var SelectComponentParams = {
        industry_0: {
            url: '/industry/getList.action?type=0&servercode=${servercode!""}',
            text: '零售行业'
        }
    }
    zlf.common.initSearchUrl('${ctxPath}/srv/shop/querySrvShopPage.action');
    $(function () {
        //初始化
         zlf.common.search();
        initSelectComponent('${ctxPath}', 'industryid', SelectComponentParams.industry_0, true);
    })

    //初始化下拉框控件
    function initSelectComponent(ctxPath, id, obj, not_empty) {
        var params = {};
        ajaxInSameDomain(ctxPath + obj.url, params, function (result) {
            if (result) {
                loadSelectItem(id, result, obj.text, not_empty || false);
            }
        })
    }

    /**
     * 加载数据到select上
     * @param id
     * @param items
     */
    function loadSelectItem(id, items, text, not_empty) {
        var options = $("#" + id);
        var optionHtml = '';
        if (!not_empty) {
            text = "请选择" + (text || '');
            optionHtml += '<option value="">' + text + '</option>';
        }
        var defaultVal = options.attr("val");
        if (options && items) {
            for (var index in   items) {
                var item = items[index];
                if (item.id == defaultVal) {
                    optionHtml += ' <option selected="selected" value="' + item.id + '" >' + item.name + '</option>';
                } else {
                    optionHtml += ' <option value="' + item.id + '">' + item.name + '</option>';
                }
            }
            options.empty().append(optionHtml);
        }
    }
   function resetSearch() {
        $("#keyword").val("");
        $("#softwaretype").val("");
        $("#industryid").val("");
        zlf.common.search();
   }
</script>
</@override>
<@override name="right">
<div class="panel panel-info">
    <div class="panel-heading">筛选</div>
    <div class="panel-body">
        <form action="#" method="post" class="form-horizontal" role="form" id="searchForm">
            <input hidden value="${servercode!''}" name="servercode">
            <div class="form-body">
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="control-label col-md-4">商户关键字
                            </label>
                            <div class="col-md-8">
                                <input type="text" id="keyword" name="keyword"
                                       value="${RequestParameters.keyword!''}" class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="control-label col-md-4">经营类型</label>
                            <div class="col-md-8">
                            <select class="form-control" name="softwaretype" id="softwaretype" value="${RequestParameters.softwaretype!''}">
                                <option value="">全部</option>
                                <option value="1">标准版</option>
                                <option value="2">连锁版</option>
                            </select>
                        </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="control-label col-md-4">经营行业</label>
                            <div class="col-md-8">
                                <select class="form-control" name="industryid" id="industryid"
                                        value="${RequestParameters.softwaretype!''}>
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-default " onclick="zlf.common.search()">
                            <i class="fa fa-search"></i> 搜索
                        </button>
                        <button type="button" class="btn btn-default " onclick="resetSearch()">
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
        <#include "srv_shop_list.ftl"/>
    </div>
</div>

</@override>
<@override name="window">
    <#include "../shop/choose-shop.ftl"/>
</@override>
<@extends name="../base_main.ftl"/>