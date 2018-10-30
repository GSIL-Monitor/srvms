<#include "../default_cfg.ftl"/>
<@override name="jsfile">
</@override>
<@override name="cssfile">
</@override>
<@override name="jstext">
<script>

</script>
</@override>
<@override name="right">
<form action="${ctxPath}/branchRenew/branchRenew.action" method="post" class="form-horizontal" role="form" id="searchForm">

    <input type="hidden" name="branchList" id="branchList" value=""/>

    <input type="hidden" name="sumyear" id="sumyear" value=""/>

    <input type="hidden" name="payflag" id="payflag" value="PAY_FLAG_PLATFORM_RENEW"/>

    <div class="panel panel-default">
        <div class="panel-heading main-content-title"></div>
        <div class="panel-body">
            <div class="form-body">
                <div class="row">
                    <div class="col-md-12" >
                        <label class="control-label col-md-3" style="color:#0000FF;font-weight:bold;font-size:16px;">商户信息</label>
                    </div>
                </div>
                </br>
                </br>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-3">商户编号</label>
                            <div class="col-md-2">
                                <input class="form-control" readonly
                                       name="shopcode"
                                       id="shopcode"
                                       value="${obj.shopcode!''}"/>
                            </div>
                            <label class="control-label col-md-1">商户名称</label>
                            <div class="col-md-2">
                                <input class="form-control" readonly
                                       name="shopname"
                                       id="shopname"
                                       value="${obj.shopname!''}"/>
                            </div>
                        </div>
                    </div>
                </div>
                </br>
                </br>
                <div class="row">
                    <div class="col-md-12" >
                        <label class="control-label col-md-3" style="color:#0000FF;font-weight:bold;font-size:16px;">选择产品</label>
                    </div>
                </div>
                </br>
                </br>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-3">产品类型</label>
                            <div class="col-md-2">
                                <select class="form-control">
                                    <option value = "1">标准软件</option>
                                </select>
                            </div>
                            <label class="control-label col-md-1">产品名称</label>
                            <div class="col-md-2">
                                <select class="form-control" id="productname" name="productname">
                                    <option value = "1">中仑零售标准版</option>
                                </select>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-3">单价(元)</label>
                            <div class="col-md-2">
                                <div class="input-txt">
                                    <input type="text" class="form-control" readonly aria-describedby="basic-addon2"
                                           name="price" id="price" value="${obj.account!''}">
                                </div>
                            </div>
                            <label class="control-label col-md-1">延长天数</label>
                            <div class="col-md-2">
                                <div class="input-txt">
                                    <input type="text" class="form-control" readonly aria-describedby="basic-addon2"
                                           name="price" id="price" value="${obj.extendTime!''}">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </br>
                </br>
                <div class="row">
                    <div class="col-md-12" >
                        <label class="control-label col-md-3" style="color:#0000FF;font-weight:bold;font-size:16px;">选择门店</label>
                    </div>
                </div>
                </br>
                </br>
                <div class="row">
                    <div class="col-md-12" >
                            <button type="button"
                                    class="btn btn-info"
                                    onclick="batchExtendProbation('${obj.shopcode}','${obj.extendTime}')">
                                        批量延长
                            </button>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-13">
                        <label class="control-label col-md-3" style="color:#0000FF;font-weight:bold;font-size:16px;"></label>
                        <div class="form-group">
                            <div class="col-lg-8 col-xs-6 col-sm-6">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div class="tab-pane active">
                                            <div class="table-responsive">
                                                <table class="table table-hover ">
                                                    <thead>
                                                    <tr>
                                                        <th style="text-align:center;vertical-align:middle">
                                                            <input type="checkbox" id="selectAll" />全选
                                                        </th>
                                                        <th style="text-align:center;vertical-align:middle">序号</th>
                                                        <th style="text-align:center;vertical-align:middle"> 分店编号</th>
                                                        <th style="text-align:center;vertical-align:middle"> 分店名称</th>
                                                        <th style="text-align:center;vertical-align:middle"> 到期时间</th>
                                                        <th style="text-align:center;vertical-align:middle"> 延长天数</th>
                                                        <th style="text-align:center;vertical-align:middle"> 是否已延期</th>
                                                        <th style="text-align:center;vertical-align:middle"> 操作</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody id="branchTbody">
                                                        <#if listInfo?? && listInfo?size gt 0>
                                                            <#list listInfo as branch>
                                                            <tr branchcode="${branch.branchcode!''}"
                                                                branchname="${branch.branchname!''}">
                                                                <td>
                                                                    <input type="checkbox" <#if (branch.extendprobation!-1) == 0> readonly disabled="disabled"  </#if> name="selectBranch" value="${branch.branchcode!''}">
                                                                </td>
                                                                <td style="text-align:center;vertical-align:middle">${branch_index + 1}</td>
                                                                <td style="text-align:center;vertical-align:middle"> ${branch.branchcode!""}</td>
                                                                <td style="text-align:center;vertical-align:middle"> ${branch.branchname!""}</td>

                                                                <td style="text-align:center;vertical-align:middle"> ${branch.expirestime!""}</td>
                                                                <td style="text-align:center;vertical-align:middle"> ${branch.extendtime!""}</td>
                                                                <td style="text-align:center;vertical-align:middle">
                                                                    <#if (branch.extendprobation!-1) == 0>
                                                                            是
                                                                    </#if>
                                                                    <#if (branch.extendprobation!-1) == 1>
                                                                                否
                                                                    </#if>
                                                                <td style="text-align:center;vertical-align:middle">
                                                                   <#if (branch.extendprobation!-1) == 1>
                                                                        <a href="javascript:extendProbation('${obj.shopcode}','${branch.branchcode}','${obj.extendTime}');"
                                                                           class="btn btn-default  btn-sm tooltips"
                                                                           data-original-title="延长试用期">延长试用期
                                                                        </a>
                                                                   <#else>
                                                                       <a href="javascript:void();"
                                                                          class="btn btn-default  btn-sm tooltips"
                                                                          style="opacity: 0.2"
                                                                          data-original-title="延长试用期">延长试用期
                                                                       </a>
                                                                   </#if>
                                                                </td>

                                                            </tr>
                                                            </#list>
                                                        </#if>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="form-group col-sm-12">
        <input type="button" onclick="skipBrancRenew()" style="margin-left:10px;" value="返回"
               class="btn btn-default">
    </div>
</form>
<script>
    $(function() {
        $("#selectAll").on("click" ,function() {
            $('input[name="selectBranch"]').each(function () {
                    if (!$(this).prop("disabled")){
                        $(this)[0].checked = $("#selectAll").is(':checked');
                    }
                });
        });
    });


    function batchExtendProbation(shopcode,extendtime){

        var allSelectBranch = $('input[name="selectBranch"]');
        var branchcodes = new Array();
        for (var i = 0; i < allSelectBranch.length; i++){
            var selectBranch = allSelectBranch.get(i);
            var checked = $(selectBranch).is(':checked');
            if($(selectBranch).is(':checked')){
                branchcodes.push($(selectBranch).val());
            }
        }
        if(branchcodes.length == 0){
            alert("请选择门店");
            return;
        }
        var url = '${ctxPath}/branchRenew/extendProbation.action';
        var params = {
            shopcode: shopcode,
            branchcodes: branchcodes.join(","),
            extendtime:extendtime
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                AlertMsg("延期成功!", function () {
                    zlf.common.search();
                    self.location.href = '${ctxPath}/branchRenew/extendProbationToView.action?shopcode='+shopcode;
                });
            }
        })
    }


    function extendProbation(shopcode ,branchcode ,extendtime) {
        ConfirmMsg("确定要延长" + branchcode + "门店试用期？", function (yes) {
            if (yes) {
                var url = '${ctxPath}/branchRenew/extendProbation.action';
                var branchcodes = new Array();
                branchcodes.push(branchcode);
                var params = {
                    shopcode: shopcode,
                    branchcodes: branchcodes.join(","),
                    extendtime:extendtime
                };
                ajaxSyncInSameDomain(url, params, function (result) {
                    if (result) {
                        AlertMsg(result);
                    } else {
                        AlertMsg("延期成功!", function () {
                            self.location.href = '${ctxPath}/branchRenew/extendProbationToView.action?shopcode='+shopcode;
                        });
                    }
                })
            }
        });
    }
    
    function checkExtendProbationCondition(shopcode ,branchcodes) {
        var url = '${ctxPath}/branchRenew/checkExtendProbationCondition.action';
        var params = {
            shopcode: shopcode,
            branchcodes: branchcodes,
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                ConfirmMsg(result, function (yes) {
                    if (yes){
                       return true;
                    }else {
                        return false;
                    }
                });
            } else {
                return true;
            }
        });

    }

    function skipBrancRenew(){
        self.location.href = '${ctxPath}/branchRenew/showShopTable.action';
    }
</script>
</@override>
<@extends name="../base_main.ftl"/>