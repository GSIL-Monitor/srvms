<#include "../default_cfg.ftl"/>
<@override name="jsfile">
</@override>
<@override name="cssfile">
</@override>
<@override name="jstext">
<script>


    function billOnClickShow(e) {
        $("#commonbill").show();
    }

    function billOnClickHide(e) {
        $("#commonbill").hide();
    }

    function saveRechargeBill() {

        var isbill = $('input:radio[name="isbill"]:checked').val();
        var invoiceconsignee = $('#invoiceconsignee').val();
        var invoicetitle = $('#invoicetitle').val();
        var taxpayerid = $('#taxpayerid').val();
        var invoicetel = $('#invoicetel').val();
        var receivingadd = $('#receivingadd').val();

        var account = $('#account').val();
        var sumyear = 0;
        $('.expirestyear').each(function () {
            if ($(this).is(':checked')) {
                sumyear += parseInt($(this).val());
            }
        })
        if (sumyear == 0) {
            AlertMsg('请选择要续费的门店！');
            return;
        }
        if (isbill == 1) {
            if (invoiceconsignee == '') {
                AlertMsg('未填写收货人！');
                return;
            }
            if (invoicetel == '') {
                AlertMsg('未填写联系电话！');
                return;
            }
            if (invoicetitle == '') {
                AlertMsg('未填写发票抬头！');
                return;
            }
            if (taxpayerid == '') {
                AlertMsg('未填写纳税人识别号！');
                return;
            }
            if (receivingadd == '') {
                AlertMsg('未填写收货地址！');
                return;
            }
        }

        var branchArr = [];
        $('#branchTbody tr').each(function () {
            branchArr.push({
                branchcode: $(this).attr('branchcode'),
                branchname: $(this).attr('branchname'),
                expirestyear: $('input:checkbox[name="expirestyear_' + $(this).attr('branchcode') + '"]:checked').val()
            });
        })

        var msg  = '需要缴费:' + account + '元<br/>';
        msg += '是否需要继续？';


        ConfirmMsg(msg, function (yes) {
            if (yes) {
                $("#branchList").val(JSON.stringify(branchArr));
                $("#sumyear").val(sumyear);
                $("#searchForm").submit();
            }
        });
    }


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
                        <label class="control-label col-md-3" style="color:#0000FF;font-weight:bold;font-size:16px;">产品详情</label>
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
                            <label class="control-label col-md-1">价格(元)</label>
                            <div class="col-md-1">
                                <div class="input-txt">
                                    <input type="text" class="form-control" readonly aria-describedby="basic-addon2"
                                           name="price" id="price" value="${obj.account!''}">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </br>
                </br>
                <div class="row">
                    <div class="col-md-12" >
                        <label class="control-label col-md-3" style="color:#0000FF;font-weight:bold;font-size:16px;">续费门店</label>
                    </div>
                </div>
                </br>
                </br>
                <div class="row">
                    <div class="col-md-12" id="selectExpirestYear">
                         <label class="control-label col-md-3">选择年限(全选)</label>
                        &nbsp;
                                <label class="checkbox-inline">
                                    <input type="checkbox"
                                           class="selectexpirestyear"
                                           onclick="selectYearBox(this)"
                                           value=1> 1年
                                </label>
                                <label class="radio-inline">
                                    <input type="checkbox"
                                           class="selectexpirestyear"
                                           onclick="selectYearBox(this)"
                                           value=2> 2年
                                </label>
                                <label class="radio-inline">
                                    <input type="checkbox"
                                           class="selectexpirestyear"
                                           onclick="selectYearBox(this)"
                                           value=3> 3年
                                </label>
                                <label class="radio-inline">
                                    <input type="checkbox"
                                           class="selectexpirestyear"
                                           onclick="selectYearBox(this)"
                                           value=4> 4年
                                </label>
                                <label class="radio-inline">
                                    <input type="checkbox"
                                           class="selectexpirestyear"
                                           onclick="selectYearBox(this)"
                                           value=5> 5年
                                </label>
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
                                                        <th style="text-align:center;vertical-align:middle">序号</th>
                                                        <th style="text-align:center;vertical-align:middle"> 分店编号</th>
                                                        <th style="text-align:center;vertical-align:middle"> 分店名称</th>
                                                        <th style="text-align:center;vertical-align:middle"> 到期时间</th>
                                                        <th style="text-align:center;vertical-align:middle"> 单价(元)</th>
                                                        <th style="text-align:center;vertical-align:middle"> 选择续费年限</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody id="branchTbody">
                                                        <#if listInfo?? && listInfo?size gt 0>
                                                            <#list listInfo as branch>
                                                            <tr branchcode="${branch.branchcode!''}"
                                                                branchname="${branch.branchname!''}">
                                                                <td style="text-align:center;vertical-align:middle">${branch_index + 1}</td>
                                                                <td style="text-align:center;vertical-align:middle"> ${branch.branchcode!""}</td>
                                                                <td style="text-align:center;vertical-align:middle"> ${branch.branchname!""}</td>
                                                                <td style="text-align:center;vertical-align:middle"> ${branch.expirestime!""}</td>
                                                                <td style="text-align:center;vertical-align:middle">${obj.account!''}</td>
                                                                <td style="text-align:center;vertical-align:middle">
                                                                    <div class="form-group">
                                                                        <div class="col-md-3" id="test">
                                                                            <label class="checkbox-inline">
                                                                                <input type="checkbox"
                                                                                       onclick="calOnClick(this)"
                                                                                       class="expirestyear"
                                                                                       name="expirestyear_${branch.branchcode!''}"
                                                                                       value=1> 1年
                                                                            </label>
                                                                            <label class="radio-inline">
                                                                                <input type="checkbox"
                                                                                       onclick="calOnClick(this,'expirestyear_${branch.branchcode!''}')"
                                                                                       class="expirestyear"
                                                                                       name="expirestyear_${branch.branchcode!''}"
                                                                                       value=2> 2年
                                                                            </label>
                                                                            <label class="radio-inline">
                                                                                <input type="checkbox"
                                                                                       onclick="calOnClick(this)"
                                                                                       class="expirestyear"
                                                                                       name="expirestyear_${branch.branchcode!''}"
                                                                                       value=3> 3年
                                                                            </label>
                                                                            <label class="radio-inline">
                                                                                <input type="checkbox"
                                                                                       onclick="calOnClick(this)"
                                                                                       class="expirestyear"
                                                                                       name="expirestyear_${branch.branchcode!''}"
                                                                                       value=4> 4年
                                                                            </label>
                                                                            <label class="radio-inline">
                                                                                <input type="checkbox"
                                                                                       onclick="calOnClick(this)"
                                                                                       class="expirestyear"
                                                                                       name="expirestyear_${branch.branchcode!''}"
                                                                                       value=5> 5年
                                                                            </label>
                                                                        </div>
                                                                    </div>
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
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-3">合计总价</label>
                            <div class="col-md-6">
                                <div class="input-group">
                                    <input type="text" class="form-control" readonly aria-describedby="basic-addon2"
                                           name="account" id="account" value="0.00">
                                    <span class="input-group-addon" id="basic-addon2">元</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-3"> 发票类型</label>

                            <div class="col-md-6">
                                <div style="float: left">
                                    <label class="radio-inline">
                                        <input type="radio" name="isbill"
                                               id="isbill" checked onclick="billOnClickHide(this)"
                                               value=0> 不开发票
                                        <span></span>
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="isbill"
                                               id="isbill" onclick="billOnClickShow(this)"
                                               value=1> 纸质增值税普通发票
                                        <span></span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row" id="commonbill" style="display:none;">

                    <div class="form-group">
                        <label class="control-label col-md-3"><span style="color: red;">*</span>收货人</label>

                        <div class="col-md-6">
                            <input class="form-control"
                                   name="invoiceconsignee"
                                   id="invoiceconsignee"
                                   value=""/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-3"><span style="color: red;">*</span>联系电话</label>

                        <div class="col-md-6">
                            <input class="form-control"
                                   name="invoicetel"
                                   id="invoicetel"
                                   value=""/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-3"><span style="color: red;">*</span>发票抬头</label>

                        <div class="col-md-6">
                            <input class="form-control"
                                   name="invoicetitle"
                                   id="invoicetitle"
                                   value=""/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-3"><span style="color: red;">*</span>纳税人识别号</label>

                        <div class="col-md-6">
                            <input class="form-control"
                                   name="taxpayerid"
                                   id="taxpayerid"
                                   value=""/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-3"><span style="color: red;">*</span>收货地址</label>

                        <div class="col-md-6">
                            <input class="form-control"
                                   name="receivingadd"
                                   id="receivingadd"
                                   value=""/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="form-group col-sm-12">
        <input type="button" value="提交" class="btn btn-primary col-lg-1" onclick="saveRechargeBill()">
        <input type="button" onclick="back()" style="margin-left:10px;" value="返回"
               class="btn btn-default">
    </div>
</form>
<script>

    function selectYearBox(e) {
        //计算金额
        var amount =  getDecimal('${obj.account!''}');
        var year = 0;
        // 设置成单选
        $(e).parent().parent().find(".selectexpirestyear").each(function () {
            if($(this).val() != $(e).val()){
                $(this)[0].checked = false;
            }
        });
        // 设置门店后面的选项
        $("#branchTbody").find(".expirestyear").each(function () {
            if($(this).val() != $(e).val()){
                $(this)[0].checked = false;
            }else{
                $(this)[0].checked = $(e)[0].checked;
                if($(e)[0].checked){
                    year += parseInt($(this).val());
                }
            }
        });
        var totalAmount = floatTool.multiply(amount, year);
        $('#account').val(totalAmount);
    }


    //更新计算结果
    function calOnClick(e) {
        $(e).parent().parent().find(".expirestyear").each(function () {
            if ($(this).val() != $(e).val()) {
                $(this)[0].checked = false;
            }
        });
        var sumyear = 0;
        $('.expirestyear').each(function () {
            if ($(this).is(':checked')) {
                sumyear += parseInt($(this).val());
            }
        })

        var renewAccount = getDecimal('${obj.account!''}');
        var account = floatTool.multiply(renewAccount, sumyear);

        $('#account').val(account);

        $("#selectExpirestYear").find(".selectexpirestyear").each(function () {
            $(this)[0].checked = false;
        });

    }
</script>
</@override>

<@override name="window">
</@override>
<@extends name="../base_main.ftl"/>