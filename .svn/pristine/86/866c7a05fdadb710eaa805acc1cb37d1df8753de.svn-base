<#include "../default_cfg.ftl"/>
<script>
    //分页
    function jumpPage(pageid, no, url) {
        var pageCount = 0;
    <#if pageInfo??>
        pageCount = ${((pageInfo.totalRecords+pageInfo.pageSize -1)/pageInfo.pageSize)?int};
    </#if>
        if (no > pageCount) {
            no = pageCount;
        }
        if (no < 1) {
            no = 1;
        }

        $.fn.FileUploader.refreshHistoryList(no);
    }
</script>
<div class="history-content" style="height:310px">
    <ul class="img-list clearfix">
    <#assign fileType=(RequestParameters.fileType!'')>

    <#if pageInfo?? && pageInfo.list??>
        <#list pageInfo.list as fileInfo>
            <li class="img-item" title="${fileInfo.name!''}" url="${fileInfo.url!''}"
                onclick="$.fn.FileUploader.singleChoose(this)">

                <#if fileType == 'video'>
                    <div class="img-container" style="width: 100px;height: 100px;">
                        <video width="100" height="100" preload="none" controls="controls">
                            <source src="${attachUrl}/${fileInfo.url!''}" type="video/mp4">
                            Your browser does not support the video tag.
                        </video>
                        <div class="select-status"><span></span></div>
                    </div>

                <#elseif fileType == 'image'>

                    <div class="img-container"
                         style="background-image: url('${attachUrl}/${fileInfo.url!''}');">
                        <div class="select-status"><span></span></div>
                    </div>

                <#elseif fileType == 'apk'>

                    <div class="img-container"
                         style="background-image: url('${zl.admin.resource.address}/images/android.png');">
                        <div class="select-status"><span></span></div>
                    </div>

                </#if>
            </li>
        </#list>
    </#if>
    </ul>
</div>
<div class="modal-footer portlet light ">
<#if pageInfo?? && pageInfo.totalRecords gt 0>
    <div class="row">
        <div class="col-md-12 col-sm-12">
            <form id="file_list_form" method="post">
                <#import "../pager.ftl" as q>
			                    <@q.pager page=pageInfo.page pageSize=pageInfo.pageSize totalRecords=pageInfo.totalRecords toURL="${ctxPath}/file/list.action" pageid="file_list_form"/>
            </form>
        </div>
    </div>
</#if>
    <div style="float: right;">
        <button type="button" class="btn btn-primary" onclick="$.fn.FileUploader.multiChoose()">确认</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
    </div>
</div>