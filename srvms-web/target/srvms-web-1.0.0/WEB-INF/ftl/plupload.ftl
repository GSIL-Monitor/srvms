<#include "./default_cfg.ftl"/>
<#assign uploadlabel = (RequestParameters.label!'文件')>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <ul class="nav nav-pills" role="tablist">
        <li id="li_upload" class="active" role="presentation">
            <a href="#upload" aria-controls="upload" role="tab" data-toggle="tab">上传${uploadlabel}</a>
        </li>
    </ul>
</div>
<div class="modal-body tab-content">
    <div role="tabpanel" class="tab-pane upload active" id="upload">

        <div id="uploader" class="uploader">
            <div class="queueList">
                <div id="dndArea" class="placeholder">
                    <div id="filePicker" class="webuploader-container">
                        <div class="webuploader-pick" id="selectfiles">点击选择${uploadlabel}</div>
                    </div>
                </div>
                <ul class="filelist" style="display: none;"></ul>
            </div>
            <div class="statusBar">
                <div class="btns">
                    <div class="uploadBtn btn btn-primary state-pedding" id="postfiles"
                         style="margin-top: 4px;">确定使用
                    </div>
                    <div class="modal-button-upload" style="float: right; margin-left: 5px;">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function () {
        $.fn.FileUploader.createUploader();
    })

</script>