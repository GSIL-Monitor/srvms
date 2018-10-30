<#include "./default_cfg.ftl"/>
<#assign uploadlabel = (RequestParameters.label!'文件')>
<#assign showhistory = (RequestParameters.showhistory!'1')>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <ul class="nav nav-pills" role="tablist">
        <li id="li_upload" class="active" role="presentation">
            <a href="#upload" aria-controls="upload" role="tab" data-toggle="tab">上传${uploadlabel}</a>
        </li>
    <#if showhistory == '1'>
        <li id="li_history_file" class="" role="presentation">
            <a href="#history_file" aria-controls="history_file" role="tab" data-toggle="tab">浏览${uploadlabel}</a>
        </li>
    </#if>
    </ul>
</div>
<div class="modal-body tab-content">
    <div role="tabpanel" class="tab-pane history" id="history_file">
    </div>
    <div role="tabpanel" class="tab-pane upload active" id="upload">
        <div id="uploader" class="uploader">
            <div class="queueList">
                <div id="dndArea" class="placeholder">
                    <div id="filePicker"></div>
                </div>
                <ul class="filelist">
                </ul>
            </div>
            <div class="statusBar">
                <div class="infowrap">
                    <div class="progress" style="display: none;">
                        <span class="text">0%</span>
                        <span class="percentage" style="width: 0%;"></span>
                    </div>
                    <div class="info">选择0个${uploadlabel}，共0B</div>
                    <div class="accept"></div>
                </div>
                <div class="btns">
                    <div class="uploadBtn btn btn-primary state-pedding"
                         onclick="fileUploader.uploader.upload()"
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

    <#if showhistory == '1'>
    $('#modal-webuploader #li_history_file').unbind('shown.bs.tab').bind('shown.bs.tab', function (e) {
        $.fn.FileUploader.refreshHistoryList(1);
    });
    </#if>

    $(function () {
        $.fn.FileUploader.createUploader();
        $('#filePicker').mouseenter(function(){
            fileUploader.uploader.refresh();
        })
    })
</script>