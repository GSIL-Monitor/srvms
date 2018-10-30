<@override name="jsfile">
<script type="text/javascript" src="https://webapi.amap.com/maps?v=1.3&key=${gd.mapapi.key}"></script>
</@override>
<@override name="jstext">
<script>
    zlf.common.initSearchUrl('${ctxPath}/srv/shop/manage/branchdetail/info.action');

    //打开修改商户跟进信息弹框
    function openShopfollow() {
        var ids = "";
        var shopcodes = "";
        $("input[name=checkboxname]:checked").each(function (i, item) {
            if (ids != "") {
                ids += ',';
            }
            ids = ids + this.value;

            if (shopcodes != "") {
                shopcodes += ',';
            }
            shopcodes = shopcodes + $(this).attr('shopcode');

        });
        var idlength = $("input[name=checkboxname]:checked").length;

        if (idlength <= 0) {
            AlertMsg('请选择需要标注的商户！');
            return;
        }
        if (idlength > 1) {
            $('#follow_update').modal('show');
        } else {
            var url = '${ctxPath}/srv/shop/toUpdateFollow.action';
            var params = {
                id: ids,
                shopcode: shopcodes
            };
            ajaxSyncInSameDomain(url, params, function (result) {
                if (result) {
                    $('#follow_update [name="followlabel"]').val(result.followlabel);
                    $('#follow_update [name="followremark"]').val(result.followremark || '');
                    $('#follow_update').modal('show');
                }
            })
        }
    }

    //提交更改商户标注
    function updateShopfollow() {
        var ids = "";
        var shopcodes = "";
        $("input[name=checkboxname]:checked").each(function (i, item) {
            if (ids != "") {
                ids += ',';
            }
            ids = ids + this.value;

            if (shopcodes != "") {
                shopcodes += ',';
            }
            shopcodes = shopcodes + $(this).attr('shopcode');

        });
        var followremark = $('#follow_update [name="followremark"]').val()
        var followlabel = $('#follow_update [name="followlabel"]').val()

        var url = '${ctxPath}/srv/shop/updateShopfollow.action';
        var params = {
            ids: ids,
            shopcodes: shopcodes,
            followremark: followremark,
            followlabel: followlabel
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                $('#follow_update').modal('hide');
                AlertMsg("保存成功", function () {
                    $('#follow_update form')[0].reset();
                    zlf.common.search();
                });
            }
        })
    }

    //打开延期商户门店到期时间弹框
    function openUpdateBranchExpirestime(id) {
        var url = '${ctxPath}/srv/shop/toUpdateBranchExpirestime.action';
        var params = {
            id: id
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                $('#follow_update [name="brandname"]').val(result.brandname || '');
                $('#follow_update [name="followremark"]').val(result.followremark || '');
                $('#follow_update [name="brandid"]').val(id);
                $('#follow_update').modal('show');
            }
        })
    }

    $(function () {
        zlf.common.search();

        initSelectComponent('${ctxPath}', 'industry', SelectComponentParams.industry_0, true);

        //初始化区划三级联动
        initAreaComponent('provinceid', 'cityid', 'districtid');
    })

    //打开门店购买记录
    function showPayRecord(branchcode, shopcode) {

        var url = '${ctxPath}/srv/shop/manage/rechargedetail.action';
        var params = {
            branchcode: branchcode,
            shopcode: shopcode
        };

        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                $("#rechargeRecordList").html("");
                var index = result.length;
                for (var i = 0; i < result.length; i++) {
                    var recharge_item = result[i];
                    $('#rechargeRecordList').append('<tr> <td>第' + index + '次</td><td> ' + getString(recharge_item.componentname) + '</td> <td> ' + getString(recharge_item.createtime) + '</td> <td> ' + getString(recharge_item.price) + ' </td> <td> ' + getString(recharge_item.expirestyear) + '</td>  <td> ' + getString(recharge_item.createusername) + '</td> </tr>')
                    index--;
                }
                $('#pay_record').modal('show');
            }
        })
    }
</script>
</@override>
<@override name="right">
<div class="row">
    <div class="col-lg-12 col-xs-12 col-sm-12">
        <!-- BEGIN PORTLET-->
        <div class="portlet light ">

            <form action="#" method="get" class="form-horizontal" role="form" id="searchForm">
                <div class="panel panel-default">
                    <div class="panel-heading main-content-title">基本信息</div>
                    <div class="panel-body">

                        <div class="form-body">

                            <div class="form-group">
                                <label class="control-label col-md-1">商家id</label>

                                <div class="col-md-2">
                                    <div class="form-control-static">
                                    ${shopInfo.shopcode!''}
                                    </div>
                                </div>

                                <label class="control-label col-md-1">商户名称</label>

                                <div class="col-md-2">
                                    <div class="form-control-static">
                                    ${shopInfo.shopname!''}
                                    </div>
                                </div>

                                <label class="control-label col-md-1">联系人</label>

                                <div class="col-md-2">
                                    <div class="form-control-static">
                                    ${shopInfo.contact!''}
                                    </div>
                                </div>

                                <label class="control-label col-md-1">联系电话</label>

                                <div class="col-md-2">
                                    <div class="form-control-static">
                                    ${shopInfo.tel!''}
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-1">经营类目</label>

                                <div class="col-md-2">
                                    <div class="form-control-static">
                                    ${shopInfo.industryname!''}
                                    </div>
                                </div>

                                <label class="control-label col-md-1">注册时间</label>

                                <div class="col-md-2">
                                    <div class="form-control-static">
                                    ${shopInfo.createtime!''}
                                    </div>
                                </div>

                                <label class="control-label col-md-1">跟进状态</label>

                                <div class="col-md-2">
                                    <div class="form-control-static">
                                        <#if (shopInfo.followlabel!'') == '0'>
                                            在试用
                                        <#elseif (shopInfo.followlabel!'') == '1'>
                                            有意向
                                        <#elseif (shopInfo.followlabel!'') == '2'>
                                            已购买
                                        <#elseif (shopInfo.followlabel!'') == '3'>
                                            已流失
                                        <#elseif (shopInfo.followlabel!'') == ''>

                                        </#if>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-1">跟进备注</label>

                                <div class="col-md-4">
                                    <div class="form-control-static">
                                    ${shopInfo.followremark!''}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">分店信息</div>
                    <div class="panel panel-info">
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
                                                           placeholder="请输入门店名称/门店编码进行查询">
                                                    <input type="hidden" id="shopcode" name="shopcode"
                                                           value="${shopInfo.shopcode!''}">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-4">

                                            <div class="form-group">
                                                <label class="control-label col-md-3">到期时间</label>

                                                <div class="col-md-9">
                                                    <input class="form-control daterange daterange-time active"
                                                           placeholder="选择日期"
                                                           readonly="readonly" id="showtime" name="showtime" value="">
                                                    <input name="starttime" id="starttime" type="hidden" value="">
                                                    <input name="endtime" id="endtime" type="hidden" value="">
                                                </div>
                                            </div>

                                        </div>
                                        <div class="col-md-2">
                                            <button type="button" class="btn btn-default "
                                                    onclick="zlf.common.search();">
                                                <i class="fa fa-search"></i> 搜索
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="panel-body table-responsive zl-content-container">
                        <#include "shop_manage_detail_branch_info.ftl" />
                    </div>
                </div>

                <div class="form-group col-sm-12">
                    <input type="button" onclick="back()" value="返回列表" class="btn btn-default">
                </div>
            </form>
        </div>
        <!-- END PORTLET-->
    </div>
</div>
</@override>
<@override name="window">
<div id="pay_record" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" style="width: 600px">
        <div class="modal-content">
            <div class="modal-body">
                <form action="#" class="form-horizontal" method="post">
                    <div class="form-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th width="48px"> 次数</th>
                                    <th> 购买产品</th>
                                    <th> 购买时间</th>
                                    <th> 购买金额</th>
                                    <th> 购买年限</th>
                                    <th> 购买人</th>
                                </tr>
                                </thead>
                                <tbody id="rechargeRecordList">


                                </tbody>
                            </table>
                        </div>


                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <a href="#" class="btn btn-default" data-dismiss="modal" aria-hidden="true">关闭</a>
            </div>
        </div>
    </div>
</div>
</@override>
<@extends name="../base_main.ftl"/>