<@override name="jstext">
<script>

    function updateUser() {

        var userid = $('#userid').val();
        var headpic = $('#headpic').val();

        if (headpic == '') {
            AlertMsg('请选择头像！');
            return;
        }

        var url = '${ctxPath}/portal/user/updateHeadPic.action';
        var params = {
            id: userid,
            headpic: headpic
        };

        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                AlertMsg('保存成功',function(){
                    window.location.reload();
                });
            }
        })
    }

    function chooseBranch(e) {
        ChooseBranch.open(null, function (data) {
            $(e).parent().prev().prev().val(data.name);
            $(e).parent().prev().val(data.id);
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
                    <label class="control-label col-md-3">头像
                        <span class="required" aria-required="true"> * </span>
                    </label>

                    <div class="col-md-4">
                        <input id="userid" name="userid" type="hidden" value="${userInfo.id}">

                        <div class="input-group">
                            <input id="headpic" name="headpic" type="text"
                                   class="form-control upload-control"
                                   value="${userInfo.headpic!''}">
                                <span class="input-group-btn">
                                        <button class="btn btn-default"
                                                onclick="$.fn.FileUploader.openUploadFile(this,{type:'image',limit:100})"
                                                type="button">
                                            选择图片
                                        </button>
                                </span>
                        </div>
                        <div class="input-group multi-img-details" style="margin-top:.5em;"></div>
                        <div class="help-block"> 图片最大为100KB;图片必须为png或jpg格式</div>
                        <div class="help-block"> 修改头像后，请重新登录进行查看</div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    </div>

    <div class="form-group col-sm-12">
        <input type="button" value="提交" class="btn btn-primary col-lg-1" onclick="updateUser()">
    </div>
</form>

</@override>
<@override name="window">
    <#include "../pluploader.ftl"/>
</@override>
<@extends name="../base_main.ftl"/>
