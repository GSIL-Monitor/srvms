<@override name="jstext">
<script>
    zlf.common.initSearchUrl('${ctxPath}/srv/manage/detail.action');

    function undatePassword(tel) {
        ConfirmMsg("确定要重置该服务商的密码？", function (yes) {
            if (yes) {
                var url = '${ctxPath}/srv/updatePassword.action';
                var params = {
                    account: tel
                };
                ajaxSyncInSameDomain(url, params, function (result) {
                    if (result) {
                        AlertMsg(result);
                    } else {
                        AlertMsg("密码已重置,重置密码为123456");
                        zlf.common.search();
                    }
                })
            }
        });
    }
    function update(servercode){
        window.location.href='${ctxPath}/srv/toUpdate.action?servercode='+servercode;
    }
    function updateFlag(e, servercode,tel, tag) {
        var url = '${ctxPath}/srv/updateFlag.action';
        var params = {
            servercode: servercode,
            tel: tel,
        };
        var flag = $(e).attr('data') == '1' ? "0" : "1";
        params[tag] = flag;

        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                if (flag == "1") {
                    $(e).html('正常');
                    $(e).removeClass("label-default").addClass("label-success");
                    $(e).attr('data', "1");
                    zlf.common.search();
                } else {
                    $(e).removeClass("label-success").addClass("label-danger");
                    $(e).html('已禁用');
                    $(e).attr('data', "0");
                    zlf.common.search();
                }
            }
        })
    }

    function srvShop(servercode, issrvreg) {
        ChooseShop.open({
            servercode: servercode,
            issrvreg: issrvreg
        }, function () {

        });
    }

    $(function () {
        zlf.common.search();
    })
    
    function toAssociationView(servercode) {
        window.location.href='${ctxPath}/srv/association/toAssociationView.action?servercode='+servercode;
    }
</script>
</@override>
<@override name="right">
<div class="panel panel-info">
    <div class="panel-heading">筛选</div>
    <div class="panel-body">
        <form action="#" method="post" class="form-horizontal" role="form" id="searchForm">
            <div class="form-body">
                <div class="row">
                    <div class="col-md-4">

                        <div class="form-group">
                            <label class="control-label col-md-3">关键字</label>

                            <div class="col-md-9">
                                <input type="text" id="keyword" name="keyword"
                                       value="${RequestParameters.keyword!''}" class="form-control"
                                       placeholder="请输入服务商名称/ID/手机号码进行查询">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-default " onclick="zlf.common.search()">
                            <i class="fa fa-search"></i> 搜索
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body">
        <a class="btn btn-default" href="javascript:goto('${ctxPath}/srv/toReg.action','searchForm');"><i
                class="fa fa-plus"></i> 添加服务商</a>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body table-responsive zl-content-container">
        <#include "srv_manage_detail.ftl"/>
    </div>
</div>

</@override>
<@override name="window">
    <#include "../shop/choose-shop.ftl"/>
</@override>
<@extends name="../base_main.ftl"/>