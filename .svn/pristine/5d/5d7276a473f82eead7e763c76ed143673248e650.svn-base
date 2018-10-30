<@override name="jstext">
<script>
    zlf.common.initSearchUrl('${ctxPath}/srv/association/manage/detail.action');
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
                    <div class="col-md-3">

                        <div class="form-group">
                            <label class="control-label col-md-3">关键字</label>

                            <div class="col-md-9">
                                <input type="text" id="keyword" name="keyword"
                                       value="${RequestParameters.keyword!''}" class="form-control"
                                       placeholder="请输入服务商编码进行查询">
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3">

                        <div class="form-group">
                            <label class="control-label col-md-3">审核状态</label>

                            <div class="col-md-9">
                                <select class="form-control" id="status" name="status">
                                    <option value="">全部</option>
                                    <option value="0">待审核</option>
                                    <option value="1">审核通过</option>
                                    <option value="2">审核不通过</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3">

                        <div class="form-group">
                            <label class="control-label col-md-3">申请日期</label>

                            <div class="col-md-9">
                                <input class="form-control daterange daterange-time active" placeholder="选择日期" readonly="readonly" id="showtime" name="showtime" value="">
                                <input name="starttime" id="starttime" type="hidden" value="">
                                <input name="endtime" id="endtime" type="hidden" value="">
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
        <#include "association_manage_detail.ftl"/>
    </div>
</div>

</@override>
<@override name="window">
</@override>
<@extends name="../base_main.ftl"/>