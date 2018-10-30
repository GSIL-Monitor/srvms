<@override name="jstext">
<script>
    zlf.common.initSearchUrl('${ctxPath}/role/manage/detail.action');

    function delRole(id) {

        ConfirmMsg("确定要删除此角色？", function (yes) {
            if (yes) {
                var url = '${ctxPath}/role/delRole.action';
                var params = {
                    id: id
                };
                ajaxSyncInSameDomain(url, params, function (result) {
                    if (result) {
                        AlertMsg("删除成功", function () {
                            window.location.href = '${ctxPath}/role/manage.action';
                        });
                    } else {
                        AlertMsg(result.data);
                    }
                })
            }
        });
    }

    //打开新增角色弹框
    function openAddRole() {
        $('#role_add').modal('show');
    }

    function addRole() {

        var rolename = $('#role_add [name="rolename"]').val();
        if (rolename == '') {
            AlertMsg('角色名不能为空！');
            return;
        }

        var url = '${ctxPath}/role/add.action';
        var params = {
            rolename: rolename
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                $('#role_add').modal('hide');
                AlertMsg("保存成功", function () {
                    $('#role_add form')[0].reset();
                    zlf.common.search();
                });
            }
        })
    }

    //打开修改角色弹框
    function openUpdateRole(id) {

        var url = '${ctxPath}/role/getObject.action';
        var params = {
            roleid: id
        };

        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                $('#role_update  [name="roleid"]').val(id);
                $('#role_update  [name="rolename"]').val(result.data.rolename || '');
                $('#role_update').modal('show');
            }
        })
    }

    function updateRole() {

        var rolename = $('#role_update [name="rolename"]').val();
        var roleid = $('#role_update [name="roleid"]').val();

        if (rolename == '') {
            AlertMsg('角色名不能为空！');
            return;
        }

        var url = '${ctxPath}/role/update.action';
        var params = {
            roleid: roleid,
            rolename: rolename
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (!result) {
                AlertMsg(result);
            } else {
                $('#role_update').modal('hide');

                AlertMsg("修改成功", function () {
                    $('#role_update form')[0].reset();
                    zlf.common.search();
                });
            }
        })
    }

    $(function(){
        zlf.common.search();
    })
</script>
</@override>
<@override name="right">

<div class="panel panel-info">

    <div class="panel-heading">
        <i class="icon-settings font-dark"></i>
        <span class="caption-subject bold uppercase main-content-title">角色列表 </span>
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
    <div class="panel-body">
        <a class="btn btn-default" href="javascript:openAddRole()"><i
                class="fa fa-plus"></i> 添加角色</a>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body table-responsive zl-content-container">
        <#include "./role_manage_detail.ftl">
    </div>
</div>

</@override>
<@override name="window">
<div id="role_add" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" style="width: 600px">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                <h3>添加角色</h3>
            </div>
            <div class="modal-body">
                <form action="#" class="form-horizontal" method="post">
                    <div class="form-body">
                        <div class="form-group">
                            <label class="control-label col-md-3">角色名称
                                <span class="required" aria-required="true"> * </span></label>

                            <div class="col-md-7">
                                <input  name="rolename" type="text" class="form-control" value="">
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <a href="#" class="btn btn-primary" onclick="addRole()">确定</a>
                <a href="#" class="btn btn-default" data-dismiss="modal" aria-hidden="true">关闭</a>
            </div>
        </div>
    </div>
</div>
<div id="role_update" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" style="width: 600px">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                <h3>修改角色</h3>
            </div>
            <div class="modal-body">
                <form action="#" class="form-horizontal" method="post">
                    <div class="form-body">
                        <div class="form-group">
                            <input type="hidden" name="roleid">
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3">角色名称
                                <span class="required" aria-required="true"> * </span></label>

                            <div class="col-md-7">
                                <input  name="rolename" type="text" class="form-control" value="">
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <a href="#" class="btn btn-primary" onclick="updateRole()">确定</a>
                <a href="#" class="btn btn-default" data-dismiss="modal" aria-hidden="true">关闭</a>
            </div>
        </div>
    </div>
</div>
</@override>
<@extends name="../base_main.ftl"/>
