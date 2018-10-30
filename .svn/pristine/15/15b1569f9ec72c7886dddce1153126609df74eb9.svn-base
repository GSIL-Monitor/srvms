<@override name="jstext">
<script>


    function select_current(obj,spec) {

        $(".select_button").removeClass("active");

        $(obj).addClass("active");

        $('#account').val(spec);
    }

    function saveFillPayBill() {

        var shopcode = $('#shopcode').val();
        var account = $('#account').val();
        var filetype = $(".form-group .active").attr("data-value");
        if (account == '0.00') {
            AlertMsg('请选择所购买空间规格！');
            return;
        }

        var url = '${ctxPath}/shop/filePay.action';
        var params = {
            shopcode: shopcode,
            filetype: filetype
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                AlertMsg("付款成功!", function () {
                    window.location.href = '${ctxPath}/shop/system.action';
                });
            }
        })
    }

</script>
<style>
    .select_button {
        display: block;
        float: left;
        width: 121px;
        height: 35px;
        text-align: center;
        padding: 4px 15px;
        line-height: 24px;
        border-radius: 4px;
        background-color: #e8e8e8;
        margin-right: 5px;
        color: #727272;
    }

    .active {
        background-color: #43bfe3;
        color: white;
    }
</style>
</@override>
<@override name="right">
<!-- BEGIN FORM-->
<form action="#" method="post" class="form-horizontal" role="form" id="searchForm">

    <div class="panel panel-default">
        <div class="panel-body">
            <div class="form-body">
                <div class="row">
                    <div class="col-md-12">

                        <div class="form-group">
                            <div class="col-md-12" >
                                <label class="control-label col-md-2">空间规格 : </label>

                                <div class="select_button " id="spec100MB" data-value="100"
                                     onclick="select_current(this,'100')">
                                    100元/10G
                                </div>

                                <div class="select_button " id="spec300MB" data-value="300"
                                     onclick="select_current(this,'300')">
                                    300元/30G
                                </div>

                                <div class="select_button " id="spec500MB" data-value="500"
                                     onclick="select_current(this,'500')">
                                    500元/50G
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                &nbsp;

                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-2">总计 :</label>

                            <div class="col-md-6">
                                <input style="border:none;width:100px;height:35px;" readonly
                                       name="account"
                                       id="account"
                                       value="0.00"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="form-group col-sm-12">
        <input type="button" value="提交" class="btn btn-primary col-lg-1" onclick="saveFillPayBill()">
        <input type="button" onclick="back()" style="margin-left:10px;" value="返回"
               class="btn btn-default">
    </div>

</form>


</@override>
<@override name="window">
</@override>
<@extends name="base_main.ftl"/>
