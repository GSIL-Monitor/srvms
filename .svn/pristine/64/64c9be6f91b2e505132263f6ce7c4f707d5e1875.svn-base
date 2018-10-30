<#include "../default_cfg.ftl"/>
<@override name="jsfile">
    <script type="text/javascript" charset="utf-8" src="${ctxPath}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctxPath}/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" src="${ctxPath}/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script src="${ctxPath}/js/jquery.form.js" type="text/javascript"></script>
</@override>
<@override name="cssfile">
    <link href="${ctxPath}/ueditor/themes/default/css/ueditor.css" type="text/css" rel="stylesheet">
</@override>
<@override name="jstext">
<script>
    function saveMessage() {

        var content = UE.getEditor('myEditor').getContent();
        var servercode = $("#servercode").val();
        var title =  $("#title").val();


        if(!(servercode || $("#allserver").is(":checked"))){
            alert("请输入服务商编码");
            return;
        }

        if(!title){
            alert("请输入标题");
            return;
        }

        if(!content){
            alert("请输入内容");
            return;
        }

        $("#data").val(content);

        var ajax_option={
            success:function(data){
                var result = eval(data);
                if (result.success) {
                    AlertMsg(result.data, function () {
                        window.location.href = '${ctxPath}/adminMesssage/toAdminMessage.action'
                    });
                }
            }
        };
        $('#searchForm').ajaxSubmit(ajax_option);
    }
    $(function () {
        var ue = UE.getEditor('myEditor',{
            imageUrl: "${ctxPath}/upload/controller.action" //图片上传提交后台对应的地址
        });
        $("#allserver").on("click",function () {
            if($("#allserver").is(":checked")){
                $("#servercode").attr("readonly" ,true);
                $("#servercode").val("");
            }else{
                $("#servercode").attr("readonly" ,false);
            }
        });
    })

</script>
</@override>
<@override name="right">
<form action="${ctxPath}/adminMesssage/saveOrUpdate.action" method="post" class="form-horizontal" role="form" id="searchForm">
    <input type="text" id="data" name="data" hidden="hidden" />
    <#if message?? >
        <input type="text" id="id" name="id" hidden="hidden" value="${message.id!''}" />
    </#if>
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
                                        <td>&nbsp;&nbsp;&nbsp;<input type="checkbox" disabled="disabled" id="allserver" <#if (message.allserver!'') == '1'> checked = "checked"</#if>
                                                   name="allserver"  value="1" />所有服务商</td>
                                    </table>
                                    <#else>
                                     <table>
                                         <td><input type="text" class="form-control" id="servercode" name="servercode"  /></td>
                                         <td>&nbsp;&nbsp;&nbsp;<input type="checkbox" id="allserver" name="allserver"  value="1" />所有服务商</td>
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
                                <#if message?? >
                                    <input type="text" class="form-control" aria-describedby="basic-addon2"
                                           name="title" id="title" value="${message.title!''}">
                                    <#else>
                                        <input type="text" class="form-control" aria-describedby="basic-addon2"
                                               name="title" id="title" >
                                </#if>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-4">消息内容</label>
                            <div class="col-md-2">
                                <div class="input-txt">
                                 <#if message?? >
                                     <script type="text/plain" id="myEditor" style="width:1000px;height:240px;">
                                         ${message.data!''}
                                     </script>
                                    <#else>
                                        <script type = "text/plain" id="myEditor" style="width:1000px;height:240px;">

                                         </script>
                                 </#if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group col-sm-12">
        <input type="button" value="提交" class="btn btn-primary col-lg-1" onclick="saveMessage()">
        <input type="button" onclick="back()" style="margin-left:10px;" value="返回"
               class="btn btn-default">
    </div>
</form>
</@override>
<@extends name="../base_main.ftl"/>