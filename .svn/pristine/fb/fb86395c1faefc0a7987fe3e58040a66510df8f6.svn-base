<@override name="jstext">
<script>
    zlf.common.initSearchUrl('${ctxPath}/srv/user/manage/detail.action');

    function delUser(id) {

        ConfirmMsg("确定要删除此用户？", function (yes) {
            if (yes) {
                var url = '${ctxPath}/srv/user/delUser.action';
                var params = {
                    id: id
                };
                ajaxSyncInSameDomain(url, params, function (result) {
                    if (result) {
                        AlertMsg(result);
                    } else {
                        AlertMsg("删除成功!", function () {
                            zlf.common.search();
                        });
                    }
                })
            }
        });
    }
    
    function resetUserPassword(id) {
        ConfirmMsg("是否要重置该用户密码？", function (yes) {
            if (yes) {
                var url = '${ctxPath}/srv/user/resetUserPassword.action';
                var params = {
                    id: id
                };
                ajaxSyncInSameDomain(url, params, function (result) {
                    if (result) {
                        AlertMsg(result);
                    } else {
                        AlertMsg("重置密码成功!", function () {
                            zlf.common.search();
                        });
                    }
                })
            }
        });
    }

    //打开新增用户弹框
    function openAddUser() {
        $('#user_modal').modal({
            remote: "${ctxPath}/srv/user/toAdd.action"
        })
        $("#user_modal").on("hidden.bs.modal", function () {
            $(this).removeData("bs.modal");
            $(this).find('.modal-content').empty()
        });
    }

    //打开修改用户弹框
    function openUpdateUser(id) {
        $('#user_modal').modal({
            remote: "${ctxPath}/srv/user/toUpdate.action?id=" + id
        })
        $("#user_modal").on("hidden.bs.modal", function () {
            $(this).removeData("bs.modal");
            $(this).find('.modal-content').empty()
        });
    }

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
                                       placeholder="请输入用户名/姓名进行查询">
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
        <a class="btn btn-default" href="javascript:openAddUser()"><i
                class="fa fa-plus"></i> 添加用户</a>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body table-responsive zl-content-container">
        <#include "./user_manage_detail.ftl" />
    </div>
</div>

</@override>
<@override name="window">
<div id="user_modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" style="width: 600px">
        <div class="modal-content">
        </div>
    </div>
</div>
</@override>
<@extends name="../base_main.ftl"/>