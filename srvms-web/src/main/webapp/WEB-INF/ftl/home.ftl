<@override name="jstext">
<style>
    .home_panel_heading {
        background-color: #dedef8;
        box-shadow: inset 1px -1px 1px #444,inset -1px 1px 1px #444;
    }
</style>
<script>
    $(function () {
        $("#showtime").each(function () {
            var elm = this;
            $(this).daterangepicker({
                format: "YYYY-MM-DD",
                timePicker: true,
                timePicker12Hour: false,
                timePickerIncrement: 1,
                minuteStep: 1
            }, function (start, end) {
                $(elm).val(start.toDateTimeStr() + " 至 " + end.toDateTimeStr());
                $(elm).next().val(start.toDateTimeStr());
                $(elm).next().next().val(end.toDateTimeStr());
            });
        });

        $(".datetimepicker").each(function () {
            var option = {
                lang: "zh",
                step: 1,
                showSecond: true,
                timepicker: false,
                closeOnDateSelect: true,
                format: 'yyyy-mm-dd'
            };
            $(this).datetimepicker(option);
        });

        // 设置时间初始值
        var starttime = formatTime(new Date(new Date(new Date().toLocaleDateString()).getTime()),'yyyy-MM-dd HH:mm');

        var endtime = formatTime(new Date(new Date(new Date().toLocaleDateString()).getTime()+24*60*60*1000-1),'yyyy-MM-dd HH:mm');

        $("#starttime").val(starttime);
        $("#endtime").val(endtime);
        $("#showtime").val(starttime + " 至 " + endtime)
    });


    function expireBranchCount(e){
        var url = '${ctxPath}/getExpireBranchCount.action';
        var exprieDays =  $("#exprieDays").val();
        var params = {
            exprieDays: exprieDays
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result.code == "0000") {
                $("#expireBranchCount").html(result.data)
            }else{
                alert(result.message);
            }
        })
    }

    function countBranchInfo() {
        var url = '${ctxPath}/getStoreCount.action';
        var startTime = $("#starttime").val();
        var endTime = $("#endtime").val();
        var params = {
            startTime: startTime,
            endTime:endTime
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result.code == "0000") {
                var data = result.data;
                $("#newStoreTotal").html(data.newStore.total);
                $("#paymentStore_new").html(data.newStore.paymentStore);
                $("#noPaymentStore_new").html(data.newStore.noPaymentStore);

                $("#lossallbranchnum").html(data.lossStore.lossallbranchnum);
                $("#lossbranchnum").html(data.lossStore.lossbranchnum);
                $("#lossnewbranchnum").html(data.lossStore.lossnewbranchnum);
            }else{
                alert(result.message);
            }
        })


    }

    var formatTime = function(time, format){
        var t = new Date(time);
        var tf = function(i){return (i < 10 ? '0' : '') + i};
        return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a){
            switch(a){
                case 'yyyy':
                    return tf(t.getFullYear());
                    break;
                case 'MM':
                    return tf(t.getMonth() + 1);
                    break;
                case 'mm':
                    return tf(t.getMinutes());
                    break;
                case 'dd':
                    return tf(t.getDate());
                    break;
                case 'HH':
                    return tf(t.getHours());
                    break;
                case 'ss':
                    return tf(t.getSeconds());
                    break;
            }
        })
    }
</script>
</@override>
<@override name="right">
<div class="container">
    <div class="container">
        <div class="row col-md-9" style="padding-right: 30px;box-sizing: border-box;">
            <div class="row col-md-6 panel " style="height: 200px;padding-left: 0;    background: #faf9f8;">
                <div class="row panel " style="height: 150px;margin:0px;">
                    <table style="text-align: center;width: 100%;height: 100%;">
                        <tr>
                            <th style="text-align:center;">
                                <span style="color: #333;font-size:20px;font-weight: normal;">门店总数</span>
                            </th>
                        </tr>
                        <tr>
                            <th style="text-align:center;font-weight: normal;font-size:20px;">${storeCount.total}</th>
                        </tr>
                    </table>
                </div>
                <div class="row panel " style="height: 50px;margin:0px;">
                    <div class="row panel  col-md-6" style="height: 47px;margin:0px;">
                        <table style="text-align: left;width: 100%;">
                            <tr>
                                <td>
                                    <span>缴费门店数</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>${storeCount.paymentStore}</span>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="row panel  col-md-6" style="height: 47px;margin:0px;">
                        <table style="text-align: right;width: 100%;">
                            <tr>
                                <td>
                                    <span>未缴费门店数</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>${storeCount.noPaymentStore}</span>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row col-md-6 panel " style="height: 200px;">
                <table  style="text-align: center;width: 100%;height: 100%;">
                    <tr>
                        <td>
                            <label style="padding:30px  0px;">
                                <input type="text" class="form-control col-md-2" id="exprieDays" onchange="expireBranchCount(this);" style="width:60px;height: 30px;" value="10"/>
                                <span style="color: #333;font-size:20px;font-weight: normal;">天后将会到期门店总数</span>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span  style="font-weight: normal;font-size:20px; padding-bottom: 70px;
    display: block;" id = "expireBranchCount">${expireBranchCount}</span>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="row col-md-12 panel" style="padding: 0px;margin: 0px;background: #f9f9f9;">
                <div class="row col-md-12 panel " style="height: 40px">
                    <table style="width: 100%;height: 100%;align:center;">
                        <tr>
                            <td>
                                统计日期
                            </td>
                            <td>
                                <div class="col-md-9">
                                    <input class="form-control active" placeholder="选择日期"
                                           readonly="readonly" id="showtime" name="showtime" value="" style="height: 25px;">
                                    <input name="starttime" id="starttime" type="hidden" value="">
                                    <input name="endtime" id="endtime" type="hidden" value="">

                            </td>
                            <td>
                               		<button type="button" class="btn btn-info" style="padding: 0 15px;" onclick="countBranchInfo(this)">统计</button>
                                 </div>
                            </td>
                        </tr>
                    </table>

                </div>
                <div class="row col-md-6 panel " style="height: 200px;padding-left: 0;background: none;">
                    <div class="row panel " style="height: 150px;margin:0px;">
                        <table style="text-align: center;width: 100%;height: 100%;">
                            <tr>
                                <th style="text-align:center;">
                                    <span style="color: #333;font-weight: normal;font-size:20px">新增门店总数</span>
                                </th>
                            </tr>
                            <tr>
                                <th style="text-align:center;color: #333;font-size:40px;"  id="newStoreTotal">${newStoreCount.newStore.total}</th>
                            </tr>
                        </table>
                    </div>
                    <div class="row panel " style="height: 50px;margin:0px;">
                        <div class="row panel  col-md-6" style="height: 47px;margin:0px;">
                            <table style="text-align: left;width: 100%;">
                                <tr>
                                    <td>
                                        <span>缴费门店数</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span id="paymentStore_new">${newStoreCount.newStore.paymentStore}</span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="row panel  col-md-6" style="height: 47px;margin:0px;">
                            <table style="text-align: right;width: 100%;">
                                <tr>
                                    <td>
                                        <span>未缴费门店数</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span id = "noPaymentStore_new">${newStoreCount.newStore.noPaymentStore}</span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="row col-md-6 panel " style="height: 200px;padding: 0px;margin:0px;">
                    <div class="row panel " style="height: 150px;margin:0px;">
                        <table style="text-align: center;width: 100%;height: 100%;">
                            <tr>
                                <th style="text-align:center;">
                                    <span style="color: #333;font-weight: normal;font-size:20px">流失门店数</span>
                                </th>
                            </tr>
                            <tr>
                                <th style="text-align:center;">
                                    <span id ="lossallbranchnum" style="color: #333;font-size:40px">
                                    ${newStoreCount.lossStore.lossallbranchnum}
                                    </span>
                                </th>
                            </tr>
                        </table>
                    </div>
                    <div class="row panel " style="height: 50px;margin:0px;">
                        <div class="row panel  col-md-6" style="height: 47px;">
                            <#--<table style="text-align: left;width: 100%;">-->
                                <#--<tr>-->
                                    <#--<td>-->
                                        <#--<span>流失率（%）</span>-->
                                    <#--</td>-->
                                <#--</tr>-->
                                <#--<tr>-->
                                    <#--<td style="align: center">-->
                                        <#--<span id = "lossbranchnum">-->
                                        <#--${newStoreCount.lossStore.lossbranchnum}-->
                                        <#--</span>-->
                                    <#--</td>-->
                                <#--</tr>-->
                            <#--</table>-->
                        </div>
                        <div class="row panel col-md-6" style="height: 47px;margin:0px;">
                            <#--<table style="text-align: right;width: 100%;">
                                <tr>
                                    <td>
                                        <span>新增流失率（%）</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span id = "lossnewbranchnum">
                                        ${newStoreCount.lossStore.lossnewbranchnum}
                                        </span>
                                    </td>
                                </tr>
                            </table>-->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row col-md-3" style="padding: 0px;margin:0px;">
            <div class="row col-md-12 " style="height: 480px;padding: 0px;margin:0px;border-radius: 5px;background: #a3ccfb;">
                <div class="row " style="height: 100px;padding: 0px">
                    <table  style="text-align: center;width: 100%;height: 100%;background: #a3ccfb;border-top-left-radius: 5px;border-top-right-radius: 5px;border-bottom: 1px solid #fff;">
                        <tbody>
                        <tr>
                            <td><span style="font-weight: bold;font-size: 15px;">消息公告</span></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="row " style="height: 300px;padding: 0px;background: #a3ccfb;margin:0px;border-bottom-left-radius: 5px;border-bottom-right-radius: 5px;">
                    <ul>
                        <div class="row panel " style="padding 0px;background: #a3ccfb">
                            <li>
                                <a <#if auth = true> href="${ctxPath}/equipmonitor/toManage.action"<#else>href="javascript:void(0)"</#if>>待处理硬件故障(${deviceBugCount})</a>
                            </li>
                        </div>
                        <#if messageList?? && messageList?size gt 0>
                            <#list messageList as message>
                                <div class="row panel " style="padding 0px;background: #a3ccfb;">
                                    <li>
                                        <a href='${ctxPath}/message/queryMessageDetail.action?id=${message.id}'>
                                        ${message.title!''}
                                        </a>
                                    </li>
                                </div>
                            </#list>
                        </#if>
                    </ul>
                    <div class="row panel " style="padding 0px;background: #a3ccfb">
                        <table style="width: 100%;text-indent: 10%;">
                            <tr>
                                <td>
                                    <a href='${ctxPath}/message/toManage.action'>
                                        更多消息 >
                                    </a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

</@override>
<@override name="window">
</@override>
<@extends name="./base_main.ftl"/>
<#include "base_js.ftl"/>