<@override name="cssfile">
<link href="${zl.web.resource.address}/assets/pages/css/error.min.css?version=${zl.web.resource.version}" rel="stylesheet" type="text/css"/>
</@override>
<@override name="content">
<div class="row">
    <div class="col-md-12 page-500">
        <div class=" number font-red"> 500</div>
        <div class=" details">
            <h3>系统异常！</h3>
            <p>${error!''}<p>
            <a href="${ctxPath}/" class="btn red btn-outline">返回登录</a>
            <br></p>
        </div>
    </div>
</div>
</@override>
<@extends name="./base_error.ftl"/>




