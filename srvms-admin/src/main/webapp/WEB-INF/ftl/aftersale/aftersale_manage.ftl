<@override name="jstext">
<script>
    zlf.common.initSearchUrl('${ctxPath}/aftersale/aftermanage.action');

    function edit(userid){
                var url = '${ctxPath}/aftersale/toUpdate.action?userid='+userid;
              window.location.href=url;

    }

    function updateFlag(e, userid, tag) {
        var url = '${ctxPath}/aftersale/updateFlag.action';
        var params = {
            userid: userid
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

    $(function () {
        zlf.common.search();
    })
</script>
</@override>
<@override name="right">
<div class="panel panel-info">
    <div class="panel-heading">筛选</div>
    <div class="panel-body">
        <form action="#" method="post" class=" form-inline" role="form" id="searchForm">
            <div class="form-body">
                <div class="form-group">
                    <label for="">售后姓名</label>
                    <input type="text" id="username" name="username"  value="${RequestParameters.username!''}" class="form-control"
                    >
                </div>
                <div class="form-group" style="padding-left: 15px">
                    <label for="">售后人员编号</label>
                    <input type="text" id="userid" name="userid"
                           value="${RequestParameters.userid!''}" class="form-control">
                </div>
                <div class="form-group" style="padding-left: 15px">
                    <label class="control-label ">状态</label>
                    <select class="form-control" style="width: 150px" name="status" id="status" >
                        <option value="">请选择</option>
                        <option value="1">正常</option>
                        <option value="0">禁用</option>
                    </select>
                </div>
                <div class="form-group" style="padding-left: 30px">
                    <button type="button" class="btn btn-default " onclick="zlf.common.search()">
                        <i class="fa fa-search"></i> 搜索
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>


<div class="panel panel-default">
    <div class="panel-body">
        <a class="btn btn-default" href="javascript:goto('${ctxPath}/aftersale/toReg.action','searchForm');"><i
                class="fa fa-plus"></i> 新增</a>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body table-responsive zl-content-container">
        <#include "aftersale_manage_detail.ftl"/>
    </div>
</div>

</@override>
<@extends name="../base_main.ftl"/>