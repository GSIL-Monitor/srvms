<@override name="jsfile">
<script type="text/javascript" src="https://webapi.amap.com/maps?v=1.3&key=${gd.mapapi.key}"></script>
</@override>
<@override name="jstext">
<style>
    .tree_line_td {
        padding-left: 0 !important;
        padding-right: 0 !important;
        line-height: 16px;
        text-align: center;

    }

    .tree_line_td hr {
        margin: 10px 0;
    }

    .tree_line_td hr:last-child {
        display: none;
    }

</style>
<style type="text/css">

</style>
<script>
    zlf.common.initSearchUrl('${ctxPath}/srv/shop/manage/detail.action');

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
    function followlabel_select(obj, id,shopcode) {
        var ids = id;
        var shopcodes = shopcode;
        var followlabel = $(obj)[0].value;

        var url = '${ctxPath}/srv/shop/updateShopfollow.action';
        var params = {
            ids: ids,
            shopcodes: shopcodes,
            followlabel: followlabel
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            }
        })
    }

    function updateFollowremark() {
        var followremark = $('#followremark_update [name="followremark"]').val()
        var ids = $('#followremark_update [name="id"]').val()
        var shopcodes = $('#followremark_update [name="shopcode"]').val()

        if(followremark.length > 200){
            AlertMsg("备注长度不能超过200字!!");
            return;
        }

        var url = '${ctxPath}/srv/shop/updateShopfollow.action';
        var params = {
            ids: ids,
            shopcodes: shopcodes,
            followremark: followremark
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            }else {
                $('#followremark_update').modal('hide');
                AlertMsg("保存成功", function () {
                    $('#followremark_update form')[0].reset();
                    zlf.common.search();
                });
            }
        })
    }

    function open_followremark_update(followremark,shopcode,id) {
        $('#followremark_update [name="shopcode"]').val(shopcode);
        $('#followremark_update [name="id"]').val(id);
        $('#followremark_update [name="followremark"]').val(followremark.replace(new RegExp("<br>","gm") ,'\n'));
        $('#followremark_update').modal('show');
    }

    $(function () {
        initSelectComponent('${ctxPath}', 'industryid', SelectComponentParams.industry_0, true);
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
                                       placeholder="请输入商户id/商户名称进行查询">
                            </div>
                        </div>

                    </div>
                    <div class="col-md-8">
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
                                <label class="control-label col-md-3">跟进状态</label>

                                <div class="col-md-9">

                                    <select style="width: 120px" class="form-control" name="followlabel" id="followlabel">
                                        <option value="">全部</option>
                                        <option value="0">在试用</option>
                                        <option value="1">有意向</option>
                                        <option value="2">已购买</option>
                                        <option value="3">已流失</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label col-md-3">行业
                                </label>

                                <div class="col-md-9">
                                    <select class="form-control" name="industryid" id="industryid"
                                            val="">
                                        <option value="">请选择</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label col-md-3">注册时间</label>

                                <div class="col-md-7">
                                    <input class="form-control daterange daterange-time" placeholder="选择日期"
                                           readonly="readonly" id="showtime" name="regtime"
                                           value=""/>
                                    <input name="starttime" id="starttime" type="hidden"
                                           value="">
                                    <input name="endtime" id="endtime" type="hidden"
                                           value="">
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
        <a class="btn btn-default" href="javascript:openShopfollow()"> 跟进</a>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body table-responsive zl-content-container">
        <#include "shop_manage_detail.ftl" />
    </div>
</div>
</@override>
<@override name="window">
<div id="follow_update" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" style="width: 600px">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                <h3>标注商户</h3>
            </div>
            <div class="modal-body">
                <form action="#" class="form-horizontal" method="post">
                    <div class="form-body">
                        <div class="form-group">
                            <label class="control-label col-md-3">跟进标注 :
                            </label>

                            <div class="col-md-7">
                                <select class="form-control" name="followlabel">
                                    <option value="0">在试用</option>
                                    <option value="1">有意向</option>
                                    <option value="2">已购买</option>
                                    <option value="3">已流失</option>
                                </select>
                                <input id="shopcode" name="shopcode" type="hidden" value="">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3">跟进备注 :
                            </label>

                            <div class="col-md-7">
                                              <textarea  name="followremark"
                                                        style="height:80px;resize: none;"
                                                        class="form-control"></textarea>
                                <span class="help-block"></span>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <a href="#" class="btn btn-primary" onclick="updateShopfollow()">确定</a>
                <a href="#" class="btn btn-default" data-dismiss="modal" aria-hidden="true">关闭</a>
            </div>
        </div>
    </div>
</div>

<div id="followremark_update" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" style="width: 600px">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                <h3>标注商户</h3>
            </div>
            <div class="modal-body">
                <form action="#" class="form-horizontal" method="post">
                    <div class="form-body">
                        <div class="form-group">
                            <input type="hidden" name="shopcode" value="">
                            <input type="hidden" name="id" value="">
                            <label class="control-label col-md-3">跟进备注 :
                            </label>

                            <div class="col-md-7">
                                              <textarea  name="followremark"
                                                        style="height:80px;resize: none;"
                                                        class="form-control"></textarea>
                                <span class="help-block"></span>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <a href="#" class="btn btn-primary" onclick="updateFollowremark()">确定</a>
                <a href="#" class="btn btn-default" data-dismiss="modal" aria-hidden="true">关闭</a>
            </div>
        </div>
    </div>
</div>
</@override>
<@extends name="../base_main.ftl"/>