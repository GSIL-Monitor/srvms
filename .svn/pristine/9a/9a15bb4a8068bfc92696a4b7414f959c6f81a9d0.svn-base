<@override name="csstext">
</@override>
<@override name="jstext">
<script>

    function updateRole() {

        alert(111);
        var rolename = $('#rolename').val();
        var roleid = $('#roleid').val();

        if (rolename == '') {
            AlertMsg('角色名不能为空！');
            return;
        }

        var url = '${ctxPath}/role/update.action';
        var params = {
            id: roleid,
            rolename: rolename
        };
        alert(params);
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                AlertMsg("保存成功!",function(){
                    back();
                });
            }
        })
    }
</script>
</@override>
<@override name="right">
<form action="#" method="post" class="form-horizontal" role="form" id="searchForm">
    <div class="panel panel-default">
        <div class="panel-heading main-content-title"></div>
        <div class="panel-body">
            <div class="form-body">

                <div class="form-group">
                    <label class="control-label col-md-3">角色名称
                        <span class="required" aria-required="true"> * </span></label>

                    <div class="col-md-4">
                        <input id="roleid" name="roleid" type="hidden" value="${role.id!''}">
                        <input id="rolename" name="rolename" type="text" class="form-control" value="${role.name!''}">
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="form-group col-sm-12">
        <input type="button" value="提交" class="btn btn-primary col-lg-1" onclick="updateRole()">
        <input type="button" onclick="back()" style="margin-left:10px;" value="返回列表"
               class="btn btn-default">
    </div>


</form>
</@override>
<@override name="window">
</@override>
<@extends name="../base_main.ftl"/>
