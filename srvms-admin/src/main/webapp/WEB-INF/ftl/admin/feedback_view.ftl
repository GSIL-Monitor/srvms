<@override name="jstext">
<script>

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
                        <input readonly disabled type="text" class="form-control" value="${feedback.title!''}">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-3">问题详情</label>

                    <div class="col-md-4">
                        <textarea  style="height:80px;resize: none;" readonly disabled
                                  class="form-control">${feedback.detail!''}</textarea>
                        <span class="help-block"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="form-group col-sm-12">
        <input type="button" onclick="back()" style="margin-left:10px;" value="返回列表"
               class="btn btn-default">
    </div>
    </div>
</form>

</@override>

<@extends name="../base_main.ftl"/>
