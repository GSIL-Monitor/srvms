<@override name="jstext">
<script>

    function batchImportCallBack(dataList) {
        debugger;
        if (dataList.length == 0) {
            AlertMsg('请求失败');
        } else {
            var data = dataList[0];
            var success = data.success;
            if (success == '0') {
                AlertMsg(data.errorMsg);
            } else if (success == '1') {

                AlertMsg('导入成功，共导入了' + data.successCount + "条数据", function () {
                    zlf.common.search();
                });

            } else if (success == '2') {

                refreshAndShowImportError('导入全部失败<br/>导入失败了' + data.errorCount + '条商品数据', data.errorList);

            } else if (success == '3') {

                refreshAndShowImportError('导入部分成功<br/>导入成功了' + data.successCount + '条商品数据<br/>导入失败了' + data.errorCount + '条商品数据', data.errorList);
            }
        }
    }

    function refreshAndShowImportError(msg, errorList) {

        $('#importErrorTbody').empty();
        $('#importMsg').html(msg);

        for (var index in errorList) {
            $('#importErrorTbody').append('<tr><td>' + errorList[index].rownum + '</td><td>' + errorList[index].errorMsg + '</td></tr>');
        }

        $('#modal-close').modal('show');
        $('#modal-close').unbind('hide.bs.modal').bind('hide.bs.modal', function () {
            window.location.reload();
        })
    }

    //上传回调函数
    function uploadCallBack(dataList, domId) {
        createImageList(dataList, domId);
    }
</script>
</@override>
<@override name="right">
<div class="panel panel-default">
    <div class="panel-body">
        <a class="btn btn-default"
           onclick="$.fn.FileUploader.openUploadFile(this, {type:'xls',callback:batchImportCallBack,limit:1024,server:'${ctxPath}/import/wxBillImport.action?branchcode=001'})">
            <i class="fa fa-upload"></i> 微信收益账单导入</a>
    </div>

</div>
<div class="panel panel-default">
    <div class="panel-body">
        <a class="btn btn-default"
           onclick="$.fn.FileUploader.openUploadFile(this, {type:'xls',callback:batchImportCallBack,limit:1024,server:'${ctxPath}/import/wxBillDetailsImport.action?branchcode=001'})">
            <i class="fa fa-upload"></i> 商户微信支付流水导入</a>
    </div>
    <div class="panel panel-default">
        <div class="panel-body">
            <a class="btn btn-default"
               onclick="$.fn.FileUploader.openUploadFile(this, {type:'xls',callback:batchImportCallBack,limit:1024,server:'${ctxPath}/import/aliBillImport.action?branchcode=001'})">
                <i class="fa fa-upload"></i> 商户微信支付流水导入</a>
        </div>

</div>
</@override>
<@override name="window">
<div id="modal-close" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <form class="form-horizontal form" action="#" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="">

        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                    <h3>导入结果</h3>
                </div>
                <div class="modal-body" style="height:400px;overflow-y:scroll;">
                    <div class="portlet-body form">
                    </div>
                    <div id="module-menus" style="padding-top:5px;">

                        <div id="importMsg" style="color: red;font-weight: bold;"></div>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th width="80px">行数</th>
                                    <th>异常信息</th>
                                </tr>
                                </thead>
                                <tbody id="importErrorTbody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <a href="#" class="btn btn-default" data-dismiss="modal" aria-hidden="true">关闭</a>
                </div>
            </div>
        </div>
    </form>
</div>
    <#include "../pluploader.ftl"/>
</@override>
<@extends name="../base_main.ftl"/>