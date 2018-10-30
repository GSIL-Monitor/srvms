<#include "../default_cfg.ftl"/>
<script>

    function updateUser() {
        var userid = $('#userid').val();
        var account = $('#account').val();
        var username = $('#username').val();
        var fullname = $('#fullname').val().trim();
        var fixtel = $('#fixtel').val();
        var email = $('#email').val();
        var mobilephone = $('#mobilephone').val();
        var userflag = $('input:radio[name="userflag"]:checked').val();


        if (fullname == '') {
            AlertMsg('姓名不能为空！');
            return;
        }

        if (!/^([\u4E00-\uFA29]|[\uE7C7-\uE7F3]|[a-zA-Z0-9_-]){1,20}$/.test(fullname)) {
            AlertMsg('姓名不能超过20个字符且不能有空格与中文特殊字符!');
            return;
        }

        if (username == '') {
            AlertMsg('用户名不能为空！');
            return;
        }

        if (!/^\d{4}$/.test(username)) {
            AlertMsg('用户名必须为4位数字！');
            return;
        }

        if (fixtel != '') {
            if (!/^0\d{2,3}-[1-9]\d{6,7}$/.test(fixtel)) {
                AlertMsg('请输入有效的固定电话！');
                return false;
            }
        }

        if (mobilephone != '') {
            if (!/^1[1,2,3,4,5,6,7,8,9,0][\d]{9}$/.test(mobilephone)) {
                AlertMsg('请输入有效的手机号！');
                return false;
            }
        }
        var checkEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

        if (email != '') {
            if (!checkEmail.test(email)) {
                AlertMsg('请输入正确的邮箱！');
                return true;
            }
        }
        var userrole = '';
        $("input[name=userrole]:checked").each(function (i, item) {
            if (userrole != '') {
                userrole += ',';
            }
            userrole += this.value;
        });
        if (userrole == '') {
            AlertMsg('请设置用户角色！');
            return;
        }

        var url = '${ctxPath}/srv/user/update.action';
        var params = {
            id: userid,
            account: account,
            username: username,
            fullname: fullname,
            fixtel: fixtel,
            email: email,
            tel: mobilephone,
            userrole: userrole,
            flag: userflag
        };

        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                AlertMsg("保存成功!", function () {
                    $('#user_modal').modal('hide');
                    zlf.common.search();
                });
            }
        })
    }

    $(function () {

        $('input:checkbox[name="userrole"]').click(function () {
            updateCheckAll('userrole', 'userrolecheckall');
        })

        updateCheckAll('userrole', 'userrolecheckall');
    })

</script>

<div class="modal-header">
    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
    <h3>修改用户</h3>
</div>
<div class="modal-body">
    <!-- BEGIN FORM-->
    <form action="" method="post" class="form-horizontal " role="form" id="form-user">
        <ul class="nav nav-tabs">
            <li class="active">
                <a href="#tab_1" data-toggle="tab" aria-expanded="true"> 基本信息 </a>
            </li>
            <li class="">
                <a href="#tab_2" data-toggle="tab" aria-expanded="false"> 用户角色 </a>
            </li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane active in" id="tab_1">

                <div class="form-body">
                    <div class="form-group">
                        <label class="control-label col-md-3">姓名
                            <span class="required" aria-required="true"> * </span></label>

                        <div class="col-md-6">
                            <input id="fullname" name="fullname" type="text" class="form-control"
                                   value="${user.fullname!''}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">用户名
                            <span class="required" aria-required="true"> * </span>
                        </label>

                        <div class="col-md-6">
                            <input id="userid" name="userid" type="hidden" value="${user.id!''}">
                            <input id="account" name="account" type="hidden" value="${user.account!''}">
                            <input id="username" name="username" readonly="readonly"
                                   type="text"
                                   class="form-control"
                                   value="${user.username!''}">

                            <div class="help-block">用户名必须为4位数字</div>
                        </div>
                    </div>

                <#if user??&&user.username!=1001>
                    <div class="form-group">
                        <label class="control-label col-md-3">状态
                        </label>

                        <div class="col-md-6">

                            <label class="radio-inline">
                                <input type="radio" name="userflag" value="1"
                                       <#if (user.flag!0) == 1>checked</#if>> 正常
                                <span></span>
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="userflag" value="0"
                                       <#if (user.flag!0) == 0>checked</#if>> 停用
                                <span></span>
                            </label>

                        </div>
                    </div>
                </#if>
                    <div class="form-group">
                        <label class="control-label col-md-3">固定电话
                        </label>

                        <div class="col-md-7">
                            <input id="fixtel" name="fixtel" type="text"
                                   class="form-control" value="${user.fixtel!''}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-3">手机
                        </label>

                        <div class="col-md-7">
                            <input id="mobilephone" name="mobilephone" type="text"
                                   class="form-control" value="${user.tel!''}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">邮箱
                        </label>

                        <div class="col-md-7">
                            <input id="email" name="email" type="text"
                                   class="form-control" value="${user.email!''}">
                        </div>
                    </div>


                </div>

            </div>
            <div class="tab-pane fade" id="tab_2">
                <div class="form-body">
                    <div class="form-group">
                        <label class="control-label col-md-3">用户角色
                        </label>

                        <div class="col-md-6">

                            <div class="checkbox-inline-inline">
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="userrolecheckall"
                                           onclick="checkAllEvent(this,'userrole','userrolecheckall');">
                                    全选
                                    <span></span>
                                </label>
                            </div>

                            <div class="checkbox-inline-inline" id="userRoles">
                            <#if roleList?? && roleList?size gt 0>
                                <#list roleList as role>
                                    <label class="checkbox-inline">
                                        <input type="checkbox" name="userrole"
                                               code="${role.rolecode!''}" ${role.checked!''}
                                               value="${role.id!''}"> ${role.rolename!''}
                                        <span></span>
                                    </label>
                                </#list>
                            </#if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<div class="modal-footer">
    <a href="javascript:void(0)" onclick="updateUser()" class="btn btn-primary">保存</a>
    <a href="#" class="btn btn-default" data-dismiss="modal" aria-hidden="true">关闭</a>
</div>