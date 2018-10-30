<@override name="jstext">
<script>
    zlf.common.initSearchUrl('${ctxPath}/srv/shop/association/manage/detail.action');

    var industrys = [
        [
            {
                id: '1',
                name: '便利店'
            },
            {
                id: '2',
                name: '小型超市'
            },
            {
                id: '3',
                name: '休闲食品'
            },
            {
                id: '4',
                name: '烟酒糖茶'
            },
            {
                id: '5',
                name: '母婴用品'
            },
            {
                id: '6',
                name: '化妆品'
            },
            {
                id: '7',
                name: '饰品礼品'
            },
            {
                id: '8',
                name: '家居家纺'
            },
            {
                id: '9',
                name: '保健食品'
            },
            {
                id: '10',
                name: '办公用品'
            },
            {
                id: '11',
                name: '体育用品'
            },
            {
                id: '12',
                name: '服装鞋帽'
            },
            {
                id: '13',
                name: '皮具箱包'
            },
            {
                id: '14',
                name: '家电数码'
            },
            {
                id: '15',
                name: '户外用品'
            },
            {
                id: '16',
                name: '汽车用品'
            },
            {
                id: '17',
                name: '农资用品'
            },
            {
                id: '18',
                name: '农副产品'
            },
            {
                id: '19',
                name: '宠物店'
            },
            {
                id: '20',
                name: '其他'
            }
        ]
    ]

    $(function () {
                var arr = industrys[0];
                var options = '<option value="">请选择经营类目</option>';

                for (var index in arr) {
                    options += '<option value="' + arr[index].id + '">' + arr[index].name + '</option>';
                }
                $('#industry').html(options);
        zlf.common.search();
    })

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
                                       placeholder="请输如商户id/名称进行查询">
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">

                        <div class="form-group">
                            <label class="control-label col-md-3">审核状态</label>

                            <div class="col-md-9">
                                <select class="form-control" id="status" name="status">
                                    <option value="">全部</option>
                                    <option value="0">待审核</option>
                                    <option value="2">审核不通过</option>
                                </select>
                            </div>
                        </div>
                    </div>


                    <div class="col-md-2">
                        <button type="button" class="btn btn-default " onclick="zlf.common.search()">
                            <i class="fa fa-search"></i> 搜索
                        </button>
                        <button type="button" class="btn btn-default "
                                data-toggle="senior-search"
                                toggle-for="#senior-search">
                            <i class="fa fa-ellipsis-horizontal"></i> 高级搜索
                            <i class="fa fa-angle-down"></i>
                        </button>
                    </div>
                </div>
                <div class="row senior-search">
                    <div class="row ">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label col-md-3">经营类目</label>

                                <div class="col-md-9">
                                    <select class="form-control" id="industry" name="industry">
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">

                            <div class="form-group">
                                <label class="control-label col-md-3">申请日期</label>

                                <div class="col-md-9">
                                    <input class="form-control daterange daterange-time active" placeholder="选择日期"
                                           readonly="readonly" id="showtime" name="showtime" value="">
                                    <input name="starttime" id="starttime" type="hidden" value="">
                                    <input name="endtime" id="endtime" type="hidden" value="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body">
        <a class="btn btn-default"
           href="javascript:goto('${ctxPath}/srv/shop/toUpdateAssociationShop.action','searchForm');"><i
                class="fa fa-plus"></i> 关联商户</a>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body table-responsive zl-content-container">
        <#include "association_manage_detail.ftl"/>
    </div>
</div>

</@override>
<@override name="window">
</@override>
<@extends name="../base_main.ftl"/>