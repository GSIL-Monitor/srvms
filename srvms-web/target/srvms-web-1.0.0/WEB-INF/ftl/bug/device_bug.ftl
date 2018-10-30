<@override name="jsfile">
</@override>
<@override name="jstext">
<script>
    $(function () {
        search();
    })

    var OnlineDeviceAnalyzeData = [];
    var OnlineDeviceAnalyzeDate = [];
    var HardwareBugCountData = [];
    var HardwareBugCountDate = [];

        <#if onlineDeviceAnalyzeData?? && onlineDeviceAnalyzeData?size gt 0>
            <#list onlineDeviceAnalyzeData as onlineCount>
            OnlineDeviceAnalyzeData.push(parseInt('${onlineCount.onlinecount!0}'));
            OnlineDeviceAnalyzeDate.push('${onlineCount.createtime!''}');
            </#list>
        </#if>

        <#if hardwareBugCountData?? && hardwareBugCountData?size gt 0>
            <#list hardwareBugCountData as bugCount>
            HardwareBugCountData.push(parseInt('${bugCount.bugnum!0}'));
            HardwareBugCountDate.push('${bugCount.datetime!''}');
            </#list>
        </#if>





    function search() {
        generateDeviceDataCountChart(OnlineDeviceAnalyzeDate, OnlineDeviceAnalyzeData);
        generateHardwareBugCountChart(HardwareBugCountDate, HardwareBugCountData);

    }

    function searchDeviceDataCount() {
        var starttime = $('#deviceDataCountStartTime').val();
        var endtime = $('#deviceDataCountEndTime').val();
        var devicetype = $('#deviceDataCountdevicetype').val();

        var url = '${ctxPath}/device/bug/getDeviceDataCount.action';
        var params = {
            starttime: starttime,
            endtime: endtime,
            devicetype: devicetype
        };

        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                $('#onlineDeviceNum').html(result.onlineDeviceNum + ' 台' || '0 台');
                $('#deviceBugHardwareNum').html(result.deviceBugHardwareNum + ' 条' || '0 条');
                $('#deviceBugSoftwareNum').html(result.deviceBugSoftwareNum + ' 条' || '0 条');
            }
        })
    }

    function searchOnlineDeviceAnalyzeData() {
        var starttime = $('#onlineDeviceAnalyzeDataStartTime').val();
        var endtime = $('#onlineDeviceAnalyzeDataEndTime').val();

        if (starttime == '') {
            AlertMsg('开始时间不能为空！');
            return;
        }
        if (endtime == '') {
            AlertMsg('结束时间不能为空！');
            return;
        }

        var url = '${ctxPath}/device/bug/getOnlineDeviceAnalyzeData.action';
        var params = {
            starttime: starttime,
            endtime: endtime
        };

        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                var newOnlineDeviceAnalyzeCountData = [];
                var newOnlineDeviceAnalyzeDate = [];
                for (var i = 0; i < result.length; i++) {
                    var current_item = result[i];
                    newOnlineDeviceAnalyzeDate.push(current_item.createtime);
                    newOnlineDeviceAnalyzeCountData.push(parseInt(current_item.onlinecount));
                }
                generateDeviceDataCountChart(newOnlineDeviceAnalyzeDate, newOnlineDeviceAnalyzeCountData);
            }
        })
    }

    function searchHardwareBugCountData() {
        var starttime = $('#hardwareBugCountDataStartTime').val();
        var endtime = $('#hardwareBugCountDataEndTime').val();
        var devicetype = $('#hardwareBugCountDataDevicetype').val();

        var url = '${ctxPath}/device/bug/getHardwareBugCountData.action';
        var params = {
            starttime: starttime,
            endtime: endtime,
            devicetype:devicetype
        };

        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                var newHardwareBugCountData = [];
                var newHardwareBugCountDate = [];
                for (var i = 0; i < result.length; i++) {
                    var current_item = result[i];
                    newHardwareBugCountDate.push(current_item.datetime);
                    newHardwareBugCountData.push(parseInt(current_item.bugnum));
                }
                generateHardwareBugCountChart(newHardwareBugCountDate, newHardwareBugCountData);
            }
        })
    }



    function generateDeviceDataCountChart(categories, dataNewArr) {
        var myChart = echarts.init(document.getElementById('onlineDeviceAnalyzeDataEcharts'));

        var option = {
            tooltip: {
                trigger: 'axis'
            },
            toolbox: {
                show: true,
                feature: {
                    mark: {show: true},
                    dataView: {show: true, readOnly: false},
                    magicType: {show: true, type: ['line', 'bar']},
                    restore: {show: true},
                    saveAsImage: {show: true}
                }
            },
            calculable: true,
            xAxis: [
                {
                    type: 'category',
                    boundaryGap: false,
                    data: categories
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    axisLabel: {
                        formatter: '{value} /台'
                    }
                }
            ],
            series: [
                {
                    name: '在线设备',
                    type: 'line',
                    data: dataNewArr
                }
            ]
        };
        //清除echarts缓存
        // myChart.clear();
        // 为echarts对象加载数据
        myChart.setOption(option, true);
    }

    function generateHardwareBugCountChart(categories, dataNewArr) {
        var myChart = echarts.init(document.getElementById('hardwareBugCountDataEcharts'));

        var option = {
            tooltip: {
                trigger: 'axis'
            },
            toolbox: {
                show: true,
                feature: {
                    mark: {show: true},
                    dataView: {show: true, readOnly: false},
                    magicType: {show: true, type: ['line', 'bar']},
                    restore: {show: true},
                    saveAsImage: {show: true}
                }
            },
            calculable: true,
            xAxis: [
                {
                    type: 'category',
                    boundaryGap: false,
                    data: categories
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    axisLabel: {
                        formatter: '{value} /条'
                    }
                }
            ],
            series: [
                {
                    name: '故障数量',
                    type: 'line',
                    data: dataNewArr
                }
            ]
        };
        //清除echarts缓存
        // myChart.clear();
        // 为echarts对象加载数据
        myChart.setOption(option, true);
    }




</script>
</@override>
<@override name="right">
<div class="row">
    <div class="col-lg-12 col-xs-12 col-sm-12">
        <!-- BEGIN PORTLET-->
        <div class="portlet light ">
            <div class="portlet-title">
                <div class="form-group">
                    <div class="caption">

                        <div class="col-md-3">
                            <span class="control-span"style="font-size: 16px;font-weight: 900;">概要数据</span>
                        </div>

                        <div class="col-md-3">
                            <input class="form-control daterange daterange-time active" placeholder="选择日期"
                                   readonly="readonly"
                                   id="" name="" value="">
                            <input name="deviceDataCountStartTime" id="deviceDataCountStartTime" type="hidden"
                                   value="">
                            <input name="deviceDataCountEndTime" id="deviceDataCountEndTime" type="hidden"
                                   value="">

                        </div>

                        <div class="col-md-3">
                            <select class="form-control" name="deviceDataCountdevicetype" id="deviceDataCountdevicetype">
                                <option value="">全部</option>
                                <option value="1">收银机</option>
                                <option value="2">广告机</option>
                            </select>

                        </div>

                        <div class="col-md-1">
                            <button type="button"
                                    class="btn btn-default" onclick="searchDeviceDataCount()">
                                <i class="fa fa-search"></i> 搜索
                            </button>

                        </div>
                    </div>
                    <span class="caption-helper"></span>
                </div>
            </div>

            <div class="portlet-body">
                <div class="row widget-row">
                    <div class="col-md-4">
                        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 ">
                            <h4 class="widget-thumb-heading">在线设备数</h4>

                            <div class="widget-thumb-wrap">
                                <i class="widget-thumb-icon bg-green icon-bulb"></i>

                                <div class="widget-thumb-body">
                                    <span class="widget-thumb-subtitle">总计</span>
                                    <span class="widget-thumb-body-stat" data-counter="counterup"
                                          data-value="" id="onlineDeviceNum"><#if deviceDataCount??>${deviceDataCount.onlineDeviceNum!0}<#else>
                                        0</#if>
                                        台</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 ">
                            <h4 class="widget-thumb-heading">硬件故障总数</h4>

                            <div class="widget-thumb-wrap">
                                <i class="widget-thumb-icon bg-red icon-layers"></i>

                                <div class="widget-thumb-body">
                                    <span class="widget-thumb-subtitle">总计</span>
                                    <span class="widget-thumb-body-stat" data-counter="counterup"
                                          data-value=""
                                          id="deviceBugHardwareNum"><#if deviceDataCount??>${deviceDataCount.deviceBugHardwareNum!0}<#else>
                                        0</#if> 条</span>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- END PORTLET-->
    </div>
</div>

<div class="row">
    <div class="col-lg-12 col-xs-12 col-sm-12">
        <!-- BEGIN PORTLET-->
        <div class="portlet light ">

            <div class="portlet-title">
                <div class="form-group">
                    <div class="caption">

                        <div class="col-md-3">
                            <span class="control-span"style="font-size: 16px;font-weight: 900;">在线设备分析</span>
                        </div>

                        <div class="col-md-3">
                            <input class="form-control daterange daterange-time active" placeholder="选择日期"
                                    id="" readonly="readonly"
                                   name="" value="">
                            <input name="onlineDeviceAnalyzeDataStartTime" id="onlineDeviceAnalyzeDataStartTime" type="hidden"
                                   value="">
                            <input name="onlineDeviceAnalyzeDataEndTime" id="onlineDeviceAnalyzeDataEndTime" type="hidden"
                                   value="">

                        </div>

                        <div class="col-md-3">

                        </div>

                        <div class="col-md-1">
                            <button type="button"
                                    class="btn btn-default" onclick="searchOnlineDeviceAnalyzeData()">
                                <i class="fa fa-search"></i> 搜索
                            </button>

                        </div>
                    </div>
                    <span class="caption-helper"></span>
                </div>
            </div>

            <div class="portlet-body">
                <div id="onlineDeviceAnalyzeDataEcharts" style="height:400px"></div>
            </div>
        </div>
        <!-- END PORTLET-->
    </div>
</div>

<div class="row">
    <div class="col-lg-12 col-xs-12 col-sm-12">
        <!-- BEGIN PORTLET-->
        <div class="portlet light ">

            <div class="portlet-title">
                <div class="form-group">
                    <div class="caption">

                        <div class="col-md-3">
                            <span class="control-span"style="font-size: 16px;font-weight: 900;">硬件故障分析</span>
                        </div>

                        <div class="col-md-3">
                            <input class="form-control daterange daterange-time active" placeholder="选择日期"
                                    readonly="readonly" id=""
                                   name="" value="">
                            <input name="hardwareBugCountDataStartTime" id="hardwareBugCountDataStartTime" type="hidden"
                                   value="">
                            <input name="hardwareBugCountDataEndTime" id="hardwareBugCountDataEndTime" type="hidden"
                                   value="">

                        </div>

                        <div class="col-md-3">
                            <select class="form-control" name="hardwareBugCountDataDevicetype" id="hardwareBugCountDataDevicetype">
                                <option value="">全部</option>
                                <option value="1">收银机</option>
                                <option value="2">广告机</option>
                            </select>

                        </div>

                        <div class="col-md-1">
                            <button type="button"
                                    class="btn btn-default" onclick="searchHardwareBugCountData()">
                                <i class="fa fa-search"></i> 搜索
                            </button>

                        </div>
                    </div>
                    <span class="caption-helper"></span>
                </div>
            </div>

            <div class="portlet-body">
                <div id="hardwareBugCountDataEcharts" style="height:400px"></div>
            </div>
        </div>
        <!-- END PORTLET-->
    </div>
</div>



</@override>
<@override name="window">
</@override>
<@extends name="../base_main.ftl"/>