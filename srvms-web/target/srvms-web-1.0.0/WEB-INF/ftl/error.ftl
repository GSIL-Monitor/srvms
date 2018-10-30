<@override name="cssfile">
<link href="http://091801.zhonglunnet.com/web/assets/pages/css/error.min.css?version=1.0.0" rel="stylesheet" type="text/css"/>
</@override>
<@override name="content">
<div class="row">
    <div class="col-md-12 page-500">
        <div class=" details">
            <h3>系统异常！</h3>
            <p>${error!''}<p>
            <a href="http://localhost:8088//index.action" class="btn red btn-outline">返回首页</a>
            <br></p>
        </div>
    </div>
</div>
</@override>
<@extends name="./base_error.ftl"/>