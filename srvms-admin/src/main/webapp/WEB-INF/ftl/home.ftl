<@override name="jsfile">
<script src="${zl.admin.resource.address}/js/hightcharts/highcharts.js?version=${zl.admin.resource.version}"></script>
</@override>
<@override name="jstext">
<script>
    $(function () {
        search();
    })

    var dataNewArr = [];
    var categories = [];
    <#if supplierCountList?? && supplierCountList?size gt 0>
        <#list supplierCountList as supplierCount>
        dataNewArr.push(parseInt('${supplierCount.datacountnew!0}'));
        categories.push('${supplierCount.countdate!''}');
        </#list>
    </#if>


    function search() {
        generateChart(categories, [
            {
                name: '新增商户数量',
                data: dataNewArr
            }
        ]);
    }

    function generateChart(categories, series) {

        var chart = new Highcharts.Chart('container', {
            title: {
                text: '商户新增数量',
                x: -20
            },
            xAxis: {
                categories: categories
            },
            yAxis: {
                title: {
                    text: '个数'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y}个</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0
            },
            series: series
        });
    }
</script>
</@override>
<@override name="right">
<div>

    <div class="row widget-row">
        <div class="col-md-3">
            <!-- BEGIN WIDGET THUMB -->
            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 ">
                <h4 class="widget-thumb-heading">商户数量</h4>

                <div class="widget-thumb-wrap">
                    <i class="widget-thumb-icon bg-green icon-bulb"></i>

                    <div class="widget-thumb-body">
                        <span class="widget-thumb-subtitle">总计</span>
                        <span class="widget-thumb-body-stat" data-counter="counterup" data-value="">${newestCountMap.suppliercount!0}</span>
                    </div>
                </div>
            </div>
            <!-- END WIDGET THUMB -->
        </div>
        <div class="col-md-3">
            <!-- BEGIN WIDGET THUMB -->
            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 ">
                <h4 class="widget-thumb-heading">用户数量</h4>

                <div class="widget-thumb-wrap">
                    <i class="widget-thumb-icon bg-red icon-layers"></i>

                    <div class="widget-thumb-body">
                        <span class="widget-thumb-subtitle">总计</span>
                        <span class="widget-thumb-body-stat" data-counter="counterup"data-value="">${newestCountMap.usercount!0}</span>
                    </div>
                </div>
            </div>
            <!-- END WIDGET THUMB -->
        </div>
        <div class="col-md-3">
            <!-- BEGIN WIDGET THUMB -->
            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 ">
                <h4 class="widget-thumb-heading">会员数量</h4>

                <div class="widget-thumb-wrap">
                    <i class="widget-thumb-icon bg-purple icon-screen-desktop"></i>

                    <div class="widget-thumb-body">
                        <span class="widget-thumb-subtitle">总计</span>
                        <span class="widget-thumb-body-stat" data-counter="counterup" data-value="">${newestCountMap.membercount!0}</span>
                    </div>
                </div>
            </div>
            <!-- END WIDGET THUMB -->
        </div>
        <div class="col-md-3">
            <!-- BEGIN WIDGET THUMB -->
            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 ">
                <h4 class="widget-thumb-heading">成交数量</h4>

                <div class="widget-thumb-wrap">
                    <i class="widget-thumb-icon bg-blue icon-bar-chart"></i>

                    <div class="widget-thumb-body">
                        <span class="widget-thumb-subtitle">总计</span>
                        <span class="widget-thumb-body-stat" data-counter="counterup" data-value="">${newestCountMap.salebillcount!0}</span>

                    </div>
                </div>
            </div>
            <!-- END WIDGET THUMB -->
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12 col-xs-12 col-sm-12">
            <!-- BEGIN PORTLET-->
            <div class="portlet light ">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="icon-bar-chart font-dark hide"></i>
                        <span class="caption-subject font-dark bold uppercase">新增商户统计</span>
                        <span class="caption-helper"></span>
                    </div>
                </div>
                <div class="portlet-body">
                    <div id="container" style="height:400px"></div>
                </div>
            </div>
            <!-- END PORTLET-->
        </div>
    </div>


</div>
</@override>
<@override name="window">
</@override>
<@extends name="./base_main.ftl"/>