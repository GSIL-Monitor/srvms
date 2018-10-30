<@override name="jsfile">
</@override>
<@override name="jstext">
<script>
    function addRegAfterSale() {
        var userid = $('#userid').val();
        var username = $('#username').val();
        var phone = $('#phone').val();
        var telephone = $('#telephone').val();
        var email = $('#email').val();
        var area = $('#area').val();
        var status = $('#status').val();


        var phoneReg = /^0\d{2,3}-?\d{7,8}$/;
        var emailReg=/^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;

        if(telephone){
            if(!phoneReg.test(telephone)){
                AlertMsg('请输入正确的固定电话！');
                return;
            }
        }
        if(email){
            if(!emailReg.test(email)){
                AlertMsg('请输入正确的邮箱！');
                return;
            }
        }

        var areas = '';
        $("input[name=areas]:checked").each(function (i, item) {
            if (areas != '') {
                areas += ',';
            }
            areas += this.value;
        });
        if (userid == '') {
            AlertMsg('售后人编号不能为空！');
            return;
        }

        if(userid<1000){
            AlertMsg('请输入四位有效数字');
            return;
        }
        if (username == '') {
            AlertMsg('请输入售后人名称！');
            return;
        }

        if (username.length > 6) {
            AlertMsg('联系人名称过长！');
            return;
        }

        if (phone == '') {
            AlertMsg('请输入手机号！');
            return;
        }

        if (!checkEmpty(phone)) {
            var reg = /^1[0-9][\d]{9}$/;
            if (!reg.test(phone)) {
                AlertMsg('请输入有效的手机号！');
                return false;
            }
        }

        if (!checkEmpty(email)) {
            var reg = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            if (!reg.test(email)) {
                AlertMsg('请输入有效的邮箱！');
                return false;
            }
        }

        if (status == '') {
            AlertMsg('请选择状态！');
            return;
        }

        if (areas == '') {
            AlertMsg('请选择服务区域！');
            return;
        }

        var url = '${ctxPath}/aftersale/addReg.action';
        var params = {
            username: username,
            userid: userid,
            area: areas,
            phone: phone,
            telephone: telephone,
            status: status,
            email: email
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                AlertMsg("创建成功!", function () {
                    window.history.back();
                });
            }
        })
    }
    function isMobile(mobile) {
        var reg = /^1[0-9][\d]{9}$/;
        if (reg.test(mobile)) {
            return true;
        } else {
            return false;
        }
    }
</script>
</@override>
<@override name="right">
<form action="#" method="post" class="form-horizontal" role="form" id="addForm">
    <div class="panel panel-default">
        <div class="panel-heading main-content-title">基本信息 </div>
        <div class="panel-body">
            <div class="form-body">
                <div class="form-group">
                    <label class="control-label col-md-1">人员编号
                        <span class="required" aria-required="true"> * </span></label>

                    <div class="col-md-2">
                        <input id="userid" name="userid" type="text" class="form-control" value="" placeholder="编号值1000-9999"
                             maxlength="4"  minlength="4" onkeyup="value=value.replace(/[^\d]/g,'')">
                    </div>

                    <label class="control-label col-md-1">姓名
                        <span class="required" aria-required="true"> * </span></label>

                    <div class="col-md-2">
                        <input id="username" name="username" type="text" class="form-control" value=""
                               data-val-required="姓名是必须的." data-val="true"
                               data-val-length="姓名 必须是最大长度为 64 的字符串。"
                               data-val-length-max="64">
                    </div>
                    <label class="control-label col-md-1">联系手机
                        <span class="required" aria-required="true"> * </span></label>

                    <div class="col-md-2">
                        <input id="phone" name="phone" maxlength="11" type="text" class="form-control" value="">
                    </div>
                </div>

                <div class="form-group">

                    <label class="control-label col-md-1">固定电话</label>

                    <div class="col-md-2">
                        <input id="telephone" name="telephone" type="text" class="form-control" value="">
                    </div>

                    <label class="control-label col-md-1">邮箱
                    </label>

                    <div class="col-md-2">
                        <input id="email" name="email" type="text" class="form-control" value="">
                    </div>

                    <label class="control-label col-md-1">状态
                        <span class="required" aria-required="true"> * </span></label>

                    <div class="col-md-2">
                        <select class="form-control" name="status" id="status" >
                            <option value="">请选择</option>
                            <option value="0">正常</option>
                            <option value="1">禁用</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading main-content-title">服务区域 </div>
        <div class="panel-body">
            <div class="form-body">
                <div class="form-group">
                    <div class="col-md-6">
                        <div class="checkbox-inline-inline">
                            <label class="checkbox-inline">
                                <input type="checkbox" name="userrolecheckall" style="font-weight: 700"
                                       onclick="checkAllEvent(this,'areas','userrolecheckall');">
                                全选
                            </label>
                        </div>
                        <#--display:inline-block;padding-left:20px;margin-bottom:0;font-weight:400;vertical-align:middle;cursor:pointer-->
                        <div class="checkbox-inline" id="areas">
                            <#if areaList?? && areaList?size gt 0>
                                <#list areaList as area>
                                    <label  style=" width:100px" >
                                        <div style="cursor:pointer">
                                            <input type="checkbox" name="areas"  value="${area.provienceid!''}"> ${area.provience!''}
                                        </div>
                                    </label>
                                </#list>
                            </#if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="form-group col-sm-12">
        <input type="button" value="创建" class="btn btn-primary col-lg-2" onclick="addRegAfterSale()">
    </div>
</form>

</@override>

<@extends name="../base_main.ftl"/>
