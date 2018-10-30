<@override name="jstext">
<script>
    zlf.common.initSearchUrl('${ctxPath}/srv/shop/reg/manage/detail.action');

    $(function () {
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
                                       placeholder="请输入手机号/商户id/商户名称/区域地址进行查询">
                            </div>
                        </div>

                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-default " onclick="zlf.common.search()">
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
        <#include "../shop/shop_manage_detail.ftl" />
    </div>
</div>
</@override>
<@override name="window">
<div id="follow_update" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" style="width: 600px">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                <h3>标注商户</h3>
            </div>
            <div class="modal-body">
                <form action="#" class="form-horizontal" method="post">
                    <div class="form-body">
                        <div class="form-group">
                            <label class="control-label col-md-3">跟进标注 :
                            </label>

                            <div class="col-md-7">
                                <select class="form-control" name="followlabel">
                                    <option value="0">在试用</option>
                                    <option value="1">有意向</option>
                                    <option value="2">已购买</option>
                                    <option value="3">已流失</option>
                                </select>
                                <input id="shopcode" name="shopcode" type="hidden" value="">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3">跟进备注 :
                            </label>

                            <div class="col-md-7">
                                              <textarea id="followremark" name="followremark"
                                                        style="height:80px;resize: none;"
                                                        class="form-control"></textarea>
                                <span class="help-block"></span>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <a href="#" class="btn btn-primary" onclick="updateShopfollow()">确定</a>
                <a href="#" class="btn btn-default" data-dismiss="modal" aria-hidden="true">关闭</a>
            </div>
        </div>
    </div>
</div>
</@override>
<@extends name="../base_main.ftl"/>