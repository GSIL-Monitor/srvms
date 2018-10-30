<#include "../default_cfg.ftl"/>
<script>

    function refreshAdminUserList(params) {
        var url = '${ctxPath}/renew/chooseShop/findSingleShop.action';
        ajaxInSameDomain(url, params, function (result) {
            $('#module-menus').html(result);
        },'html')

    }

    function searchSingleShop() {
        var params = {
            shopcode:$("#shopcode").val(),
            shopname:$("#shopname").val(),
            branchname:$("#branchname").val()
        };
        refreshAdminUserList(params);
    }
    
    $(function () {
        refreshAdminUserList(null);
    });
    
    function checkAll() {
        // 判断是否被选
        var checkAllStatus = document.getElementById("checkAll").checked
        $("table tbody input[type=checkbox]").each(function (e) {
            this.checked = checkAllStatus;
        });
    }
    
    function singleCheck() {
        var checkAllStatus = true;
        $("table tbody input[type=checkbox]").each(function (e) {
            var singleCheckStatus = this.checked
            checkAllStatus = checkAllStatus && singleCheckStatus;
            if(!checkAllStatus){
                return false
            }
        });
        $("#checkAll")[0].checked = checkAllStatus;
    }
    
    function finish() {
        var arr = new Array();
        var bean;
        $("table tbody input[type=checkbox]:checked").each(function (e) {
            bean = new Object();
            $(this).parent().find("input[type=text]").each(function () {
               var name = this.name;
               var value = this.value;
               switch (name){
                   case "shopcode" : bean.shopcode = value;
                        break;
                   case "shopname" : bean.shopname = value;
                       break;
                   case "branchcode" : bean.branchcode = value;
                       break;
                   case "branchname" : bean.branchname = value;
                       break;
                   case "expiretime" : bean.expiretime = value;
                       break;
               }
            })
            arr.push(bean);
        });
       ChooseSingleShop.callback(arr);
    }


</script>
<div class="modal-header">
    <h3>
        添加门店
        <button type="button" class="btn btn-primary btn-default  pull-right" data-dismiss="modal" aria-hidden="true" style="background-color: grey">关闭</button>
        <button type="button" class="btn btn-primary btn-default  pull-right" style="margin-right: 10px;" onclick="finish()">保存</button>
    </h3>

</div>
<div class="modal-body">
    <form action="" id="searchForm" class="form-horizontal" method="post">
        <div class="form-body">
            <div class="row">
                <div class="col-md-3 col-sm-3">
                    <div class="form-group">
                        <label class="control-label col-md-4">商户ID</label>
                        <div class="col-md-7">
                            <input type="text" id="shopcode" name="shopcode" class="form-control" value="${RequestParameters.shopcode!''}">
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-3">
                    <div class="form-group">
                        <label class="control-label col-md-5">商户名称</label>
                        <div class="col-md-7">
                            <input type="text" id="shopname" name="shopname" class="form-control" value="${RequestParameters.shopname!''}">
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-3">
                    <div class="form-group">
                        <label class="control-label col-md-5">门店名称</label>
                        <div class="col-md-7">
                            <input type="text" id="branchname" name="branchname" class="form-control" value="${RequestParameters.branchname!''}">
                        </div>
                    </div>
                </div>
                <div class="col-md-1 col-sm-1">
                    <button type="button" class="btn btn-default " onclick="searchSingleShop();">
                        <i class="fa fa-search"></i> 搜索
                    </button>
                </div>
            </div>
        </div>
    </form>
    <div id="module-menus" style="padding-top:5px;">
        <#include "single_shop_table.ftl"/>
    </div>
</div>
