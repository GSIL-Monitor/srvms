<@override name="jstext">
<script>
    function changePassword() {
        var oldPassword = $('#oldPwd').val();
        if (oldPassword == '') {
            AlertMsg('旧密码不能为空！');
            $('#oldPwd').focus();
            return;
        }

        var newPassword = $('#newPwd').val();

        if (!/^(\S){6,18}$/.test(newPassword)) {
            AlertMsg('密码必须为6-18位数字、字母、符号！');
            $('#newPwd').focus();
            return;
        }

        var cfmPassword = $('#cfmPwd').val();
        if (cfmPassword == '') {
            AlertMsg('确认密码不能为空！');
            $('#cfmPwd').focus();
            return;
        }

        if (newPassword != cfmPassword) {
            AlertMsg('两次输入密码不一致，请重新设置！');
            $('#newPwd').focus();
            return;
        }

        // 更新密码
        var url = '${ctxPath}/changepwd/changePassword.action';
        var params = {
            oldPassword: oldPassword,
            newPassword: newPassword
        }
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                AlertMsg("密码已修改!", function () {
                    window.location.reload();
                });
            }
        })
    }
</script>
</@override>
<@override name="right">
<form action="#" method="post" class="form-horizontal" role="form" id="addForm">
    <div class="panel panel-default">
        <div class="panel-heading main-content-title"></div>
        <div class="panel-body">

            <div class="form-body">
                <div class="form-group">
                    <label class="control-label col-md-3">旧密码
                        <span class="required" aria-required="true"> * </span>
                    </label>

                    <div class="col-md-4">
                        <input id="oldPwd" name="oldPwd" type="password" class="form-control" value="">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">新密码
                        <span class="required" aria-required="true"> * </span>
                    </label>

                    <div class="col-md-4">
                        <input id="newPwd" name="newPwd" type="password" class="form-control" value="">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">确认新密码
                        <span class="required" aria-required="true"> * </span>
                    </label>

                    <div class="col-md-4">
                        <input id="cfmPwd" name="cfmPwd" type="password" class="form-control" value="">
                    </div>
                </div>

                <div class="form-group col-sm-12">
                    <input type="button" value="提交" class="btn btn-primary col-lg-1" onclick="changePassword()">
                </div>
            </div>
        </div>
    </div>

</form>

</@override>

<@extends name="../base_main.ftl"/>