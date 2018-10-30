<#include "../default_cfg.ftl"/>
<@override name="jsfile">
    <script type="text/javascript" charset="utf-8" src="${ctxPath}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctxPath}/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" src="${ctxPath}/ueditor/lang/zh-cn/zh-cn.js"></script>
</@override>
<@override name="cssfile">
    <link href="${ctxPath}/ueditor/themes/default/css/ueditor.css" type="text/css" rel="stylesheet">
</@override>
<@override name="jstext">
    <script>
        $(function () {
            var ue = UE.getEditor('myEditor',{
                readonly:true
            });
        })
    </script>
</@override>
<@override name="right">
<form action="${ctxPath}/adminMesssage/saveOrUpdate.action" method="post" class="form-horizontal" role="form" id="searchForm">
    <div class="panel panel-default">
        <div class="panel-heading main-content-title"></div>
        <div class="panel-body">
            <div class="form-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-3">消息标题</label>
                            <div class="col-md-2">
                                <div class="input-txt">
                                        <div style="padding-top:7px">
                                             ${message.title!''}
                                        </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                    <div class="form-group">
                        <label class="control-label col-md-3">创建时间</label>
                        <div class="col-md-2">
                            <div class="input-txt">
                                <div style="padding-top:7px">
                                    ${message.createtime!''}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-3">消息内容</label>
                            <div class="col-md-9">
                                <div class="input-txt">
                                       ${message.data!''}
                                </div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</form>
<div class="form-group col-sm-12">
        <input type="button" onclick="back()" style="margin-left:10px;" value="返回"
               class="btn btn-default">
        </div>
</@override>
<@extends name="../base_main.ftl"/>