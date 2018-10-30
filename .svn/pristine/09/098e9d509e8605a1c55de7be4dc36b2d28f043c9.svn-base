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
                    <div class="col-md-12" >
                        <label class="control-label col-md-3" style="color:#0000FF;font-weight:bold;font-size:16px;">通知对象</label>
                    </div>
                </div>
                </br>
                </br>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-4">服务商编号</label>
                            <div class="col-md-6">
                                <#if message?? >
                                    <table>
                                        <td><input type="text" class="form-control" readonly id="servercode" name="servercode"
                                                   value="${message.servercode!''}" /></td>
                                        <td>&nbsp;&nbsp;&nbsp;<input type="checkbox" readonly disabled="disabled" id="allserver" <#if (message.allserver!'') == '1'> checked = "checked"</#if>
                                                                     name="allserver"  value="1" />所有服务商</td>
                                    </table>
                                </#if>
                            </div>
                        </div>
                    </div>
                </div>
                </br>
                </br>
                <div class="row">
                    <div class="col-md-12" >
                        <label class="control-label col-md-3" style="color:#0000FF;font-weight:bold;font-size:16px;">消息内容</label>
                    </div>
                </div>
                </br>
                </br>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-4">消息标题</label>
                            <div class="col-md-2">
                                <div class="input-txt">
                                    <input type="text" class="form-control" readonly="readonly" aria-describedby="basic-addon2"
                                           name="title" id="title" value="${message.title!''}">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-4">消息内容</label>
                            <div class="col-md-2">
                                <div class="input-txt">
                                   <script type="text/plain" id="myEditor" style="width:1000px;height:240px;">
                                       ${message.data!''}
                                   </script>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <div class="form-group col-sm-12">
            <input type="button" onclick="back()" style="margin-left:10px;" value="返回"
                   class="btn btn-default">
        </div>
</form>

</@override>
<@extends name="../base_main.ftl"/>