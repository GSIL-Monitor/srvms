<@override name="jstext">
<script>

    function addObject() {

        var title = $('#title').val();
        var detail = $('#detail').val();
        if (title == '') {
            AlertMsg('请输入标题！');
            return;
        }
        if (!/^([\u4E00-\uFA29]|[\uE7C7-\uE7F3]|[a-zA-Z0-9_-]){1,25}$/.test(title)) {
            AlertMsg('标题不能超过25个字符且不能有空格与中文特殊字符!');
            return;
        }

        if (detail.length > 150) {
            AlertMsg('详情在150字内！');
            return;
        }

        var url = '${ctxPath}/feedback/add.action';
        var params = {
            title: title,
            detail: detail
        };

        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                AlertMsg("问题反馈已提交!", function () {
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
                    <label class="control-label col-md-3">标题
                        <span class="required" aria-required="true"> * </span></label>

                    <div class="col-md-4">
                        <input id="title" name="title" type="text" class="form-control" value="">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">详情</label>

                    <div class="col-md-4">
                        <textarea id="detail" name="detail" style="height:80px;resize: none;"
                                  class="form-control"></textarea>
                        <span class="help-block"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="form-group col-sm-12">
        <input type="button" value="提交" class="btn btn-primary col-lg-1" onclick="addObject()">
    </div>
</form>

</@override>

<@extends name="../base_main.ftl"/>
