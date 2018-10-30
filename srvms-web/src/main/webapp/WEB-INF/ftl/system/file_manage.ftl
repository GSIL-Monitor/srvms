<@override name="jstext">
<script>

    function delBranch(id) {

        ConfirmMsg("确定要删除此文件？", function (yes) {
            if (yes) {
                var url = '${ctxPath}/file/delFile.action';
                var params = {
                    id: id
                };
                ajaxSyncInSameDomain(url, params, function (result) {
                    if (result) {
                        AlertMsg(result);
                    } else {
                        AlertMsg("删除成功!", function () {
                            window.location.reload();
                        });

                    }
                })
            }
        });
    }

    function search() {
        $("#searchForm").attr('action','${ctxPath}/file/manage.action');
        $("#searchForm").submit();
    }

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
                                       placeholder="请输入文件名进行查询">
                            </div>
                        </div>

                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-default " onclick="search()">
                            <i class="fa fa-search"></i> 搜索
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body table-responsive">

        <table class="table table-hover">
            <thead>
            <tr>
                <th width="48px"> 序号</th>
                <th> 文件名</th>
                <th width="150"> 创建时间</th>
                <th> 操作</th>
            </tr>
            </thead>
            <tbody>
                <#if pageInfo?? && pageInfo.list??>
                    <#import "../rownum.ftl" as q>
                    <#list pageInfo.list as file>
                    <tr>
                        <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=file_index /></td>
                        <td> <image class="table_td_thumbnail" src="${zl.web.resource.address}/images/file/image.png" /> ${file.name!''}</td>
                        <td> ${file.createtime!''}</td>
                        <td>
                            <a class="btn btn-default  btn-sm tooltips"
                               href="javascript:delBranch(${file.id});" data-original-title="删除"><i
                                    class="fa fa-times"></i>
                            </a>
                        </td>
                    </tr>
                    </#list>
                <#else>
                <tr>
                    <td valign="top" colspan="8" class="dataTables_empty">暂无数据</td>
                </tr>
                </#if>
            </tbody>
        </table>

        <#if pageInfo?? && pageInfo.totalRecords gt 0>
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <form id="file_list_form" method="post">
                        <#import "../pager.ftl" as q>
			                    <@q.pager page=pageInfo.page pageSize=pageInfo.pageSize totalRecords=pageInfo.totalRecords toURL="${ctxPath}/file/manage.action" pageid="file_list_form"/>
                    </form>
                </div>
            </div>
        </#if>
    </div>
</div>
</@override>
<@override name="window">
</@override>
<@extends name="../base_main.ftl"/>