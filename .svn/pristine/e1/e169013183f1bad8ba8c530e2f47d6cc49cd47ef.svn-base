<@override name="jstext">
<script>
    function search() {
        $("#searchForm").attr('action', '${ctxPath}/auth/manage.action');
        $('#searchForm').submit();
    }
</script>
</@override>
<@override name="right">

<div class="panel panel-info">

<div class="panel-heading">

        <i class="icon-settings font-dark"></i>
        <span class="caption-subject bold uppercase main-content-title">角色授权 </span>
</div>


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
                                       placeholder="请输入角色名/角色编码进行查询">
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
                    <th width="160px"> 编码</th>
                    <th> 角色名称</th>
                    <th> 操作</th>
                </tr>
                </thead>
                <tbody>
                    <#if pageInfo?? && pageInfo.list??>
                        <#import "../rownum.ftl" as q>
                        <#list pageInfo.list as role>
                        <tr class="odd gradeX">
                            <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=role_index /></td>
                            <td> ${role.rolecode!''}</td>
                            <td> ${role.rolename!''}</td>
                            <td>
                                <a href="javascript:goto('${ctxPath}/auth/toUpdate.action?roleid=${role.id}','searchForm');"
                                   class="btn btn-default  btn-sm tooltips" data-original-title="修改"> 授权
                                    <i class="fa fa-edit"></i>
                                </a>
                            </td>
                        </tr>
                        </#list>
                    <#else>
                    <tr>
                        <td valign="top" colspan="4" class="dataTables_empty">暂无数据</td>
                    </tr>
                    </#if>

                </tbody>
            </table>


            <#if pageInfo?? && pageInfo.totalRecords gt 0>
                <div class="row">
                    <div class="col-md-12 col-sm-12">
                        <form id="user_list_form" method="post">
                            <#import "../pager.ftl" as q>
                                <@q.pager page=pageInfo.page pageSize=pageInfo.pageSize totalRecords=pageInfo.totalRecords toURL="${ctxPath}/auth/manage.action" pageid="user_list_form"/>
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