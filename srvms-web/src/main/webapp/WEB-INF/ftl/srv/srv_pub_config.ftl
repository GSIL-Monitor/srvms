    <@override name="jsfile">
<script type="text/javascript" src="https://webapi.amap.com/maps?v=1.3&key=${gd.mapapi.key}"></script>
</@override>
<@override name="jstext">
<script>


</script>
</@override>
<@override name="right">
<form action="#" method="post" class="form-horizontal" role="form" id="addForm">
    <div class="panel panel-default">
        <div class="panel-heading main-content-title">基本信息</div>
        <div class="panel-body">

            <div class="form-body">
                <div class="form-group">
                    <label class="control-label col-md-1">服务商名称</label>
                    <div class="col-md-2">
                        <input readonly id="servername" name="servername" type="text" class="form-control" value="${data.servername!""}">
                    </div>
                    <label class="control-label col-md-2">联系人</label>

                    <div class="col-md-2">
                        <input id="contact" readonly name="contact" type="text" class="form-control" value="${data.contact!""}">
                    </div>

                    <label class="control-label col-md-2">联系手机</span></label>

                    <div class="col-md-2">
                        <input id="tel" maxlength="11" readonly name="tel" type="text" class="form-control" value="${data.tel!""}">
                    </div>

                </div>

                <div class="form-group">
                    <label class="control-label col-md-1">所属售后</label>

                    <div class="col-md-2">
                        <input id="aftersalesname" readonly maxlength="aftersalesname" name="tel" type="text" class="form-control" value="${data.aftersalesname!""}">
                    </div>

                    <label class="control-label col-md-2">所属区域</label>

                    <div class="col-md-2">
                        <input id="area" maxlength="area"  readonly name="tel" type="text" class="form-control" value="${data.area!""}">
                    </div>
                </div>

                <div class="form-group">

                    <label class="control-label col-md-1">状态</label>

                    <div class="col-md-2">
                        <select readonly disabled class="form-control" name="flag" id="flag" val="${data.flag!""}">
                            <option value="">请选择</option>
                            <option value="1"<#if data.flag == 1>selected</#if>>正常</option>
                            <option value="0"<#if data.flag == 0>selected</#if>>禁用</option>
                        </select>
                    </div>
                    <label class="control-label col-md-2">续费最低折扣</label>
                    <div class="col-md-2">
                        <input id="appdiscountratio" readonly maxlength="" name="tel" type="text" class="form-control" value="${data.appdiscountratio!""}%">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading main-content-title">基本信息</div>
        <div class="panel-body">
            <div class="form-group">
                <label class="control-label col-md-1">结算银行卡</label>

                <div class="col-md-2">
                    <input id="bankcard" readonly name="bankcard" type="text" class="form-control" value="${data.bankcard!""}">
                </div>
                <label class="control-label col-md-2">卡主姓名</label>

                <div class="col-md-2">
                    <input id="bankcardname"  readonly name="bankcardname" type="text" class="form-control" value="${data.bankcardname!""}">
                </div>

                <label class="control-label col-md-2">结算卡卡号</label>

                <div class="col-md-2">
                    <input id="bankcardno" readonly name="bankcardno" type="text" class="form-control" value="${data.bankcardno!""}">
                </div>

            </div>
            <div class="form-group">
                <label class="control-label col-md-1">所属支行</label>

                <div class="col-md-2">
                    <input id="subordinatebranch"  readonly name="subordinatebranch" type="text" class="form-control" value="${data.subordinatebranch!""}">
                </div>
                <label class="control-label col-md-2">预留手机号</label>

                <div class="col-md-2">
                    <input id="obligatetel" readonly name="obligatetel" type="text" class="form-control" value="${data.obligatetel!""}">
                </div>
            </div>

        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">收益内容</div>
        <div class="panel-body">
            <div class="form-group">
                <div class="col-md-12">
                    <div class="table-scrollable">
                        <table class="table table-hover table-bordered">
                            <thead>
                            <tr>
                                <th> 收单类型</th>
                                <th> 收单内容</th>
                                <th> 收益比例(%)</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr class="odd gradeX">
                                <td>收单收益</td>
                                <td>支付宝收单</td>
                                <td><input style="width: 126px;" readonly id="alirevenuescale" name="alirevenuescale" type="text"
                                           class="form-control" value="${data.alirevenuescale!""}"></td>
                            </tr>
                            <tr class="odd gradeX">
                                <td>收单收益</td>
                                <td>微信收单</td>
                                <td><input style="width: 126px;" readonly id="weixirevenuescale" name="weixirevenuescale" type="text"
                                           class="form-control" value="${data.weixirevenuescale!""}"></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
</@override>
<@override name="window">
</@override>
<@extends name="../base_main.ftl"/>