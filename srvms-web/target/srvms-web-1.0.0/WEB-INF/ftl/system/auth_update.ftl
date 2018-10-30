<@override name="jsfile">
<script language="javascript" src="http://091801.zhonglunnet.com/web/js/nestable/jquery.nestable.js?version=1.0.0"></script>
</@override>
<@override name="cssfile">
<link rel="stylesheet" type="text/css" href="http://091801.zhonglunnet.com/web/css/nestable.css?version=1.0.0">
</@override>
<@override name="csstext">
<style type="text/css">
    .dd-handle {
        height: 40px;
        line-height: 26px
    }
</style>
</@override>
<@override name="jstext">
<script type="text/javascript">

    $(function () {
        var depth = 3;
        if (depth <= 0) {
            depth = 3;
        }
        $('#div_nestable').nestable({maxDepth: depth, isMove: 0});

        $(".dd-handle a,dd-handle embed,dd-handle div").mousedown(function (e) {
            e.stopPropagation();
        });
    })

    function checkItem(e) {
        var disabled = $(e).attr('disabled');
        if (disabled && disabled == 'disabled') {
            return;
        }
        var hasCheckClass = $(e).children('i').toggleClass("fa-check-square-o").hasClass("fa-check-square-o");
        var hasNoCheckClass = $(e).children('i').toggleClass("fa-square-o").hasClass("fa-square-o");
        var parent =  $(e).parent().parent();
        var children = parent.next();
        if (children) {
            children.find('i').toggleClass("fa-check-square-o", hasCheckClass);
            children.find('i').toggleClass("fa-square-o", hasNoCheckClass);
        }

        var parentPrev =  parent.parent().parent().prev();
        var parentPrevNext = parentPrev.next();
        var parentPrevNextCheck = parentPrevNext.find('i').hasClass("fa-check-square-o"); // 子类是否选中
        if(parentPrevNextCheck){
            // 子类有选中的
            var check = parentPrev.find('i').hasClass("fa-check-square-o"); // 父类是否选中
            if(!check){ // 父类没有选中
                parentPrev.find('i').addClass("fa-check-square-o");
                parentPrev.find('i').removeClass("fa-square-o");
            }
        }else{ // 子类没有选中的
            var check = parentPrev.find('i').hasClass("fa-check-square-o"); // 父类是否选中
            if(check){
                parentPrev.find('i').removeClass("fa-check-square-o");
                parentPrev.find('i').addClass("fa-square-o");
            }
        }
        var superParentPrev = parentPrev.parent().parent().prev()
        var superParentPrevNext = superParentPrev.next();
        var checkParentChildrenCheck = superParentPrevNext.find('i').hasClass("fa-check-square-o");
        if(checkParentChildrenCheck){
           var check = superParentPrev.find("i").hasClass("fa-check-square-o");
           if(!check){
               superParentPrev.find('i').addClass("fa-check-square-o");
               superParentPrev.find('i').removeClass("fa-square-o");
           }
        }else{
            superParentPrev.find('i').removeClass("fa-check-square-o");
            superParentPrev.find('i').addClass("fa-square-o");
        }
    }

    function updateAuth() {
        var roleid = $('#roleid').val();
        var menuIdArr = [];
        $('#div_nestable a[disabled!="disabled"] i').each(function () {
            var thisDom = $(this);
            if (thisDom.hasClass('fa-check-square-o')) {
                menuIdArr.push(thisDom.attr('data-id'));
            }
        })

        var menus = menuIdArr.join(',');
        var url = '${ctxPath}/auth/update.action';
        var params = {
            roleid: roleid,
            menus: menus
        };
        ajaxSyncInSameDomain(url, params, function (result) {
            if (result) {
                AlertMsg(result);
            } else {
                AlertMsg("保存成功!",function(){
                    back();
                });
            }
        })
    }
</script>
</@override>
<@override name="right">
<form action="#" method="post" class="form-horizontal" role="form" id="form-user">
    <div class="panel panel-default">
        <div class="panel-heading main-content-title"></div>
        <div class="panel-body">
            <div class="form-body">

                <div class="form-group">
                    <label class="control-label col-md-3">角色名</label>

                    <div class="col-md-4">
                        <input id="username" name="username" type="text" readonly="readonly" class="form-control"
                               value="${role.rolename!''}">
                        <input id="roleid" name="roleid" type="hidden" value="${role.id!''}">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-3">菜单</label>

                    <div class="col-md-4">
                        <div class="dd" id="div_nestable">
                            <#import "../buildCheckTree.ftl" as bt>
                                <@bt.buildTree rootList=dataList maxLevel=3/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="form-group col-sm-12">
        <input type="button" value="提交" class="btn btn-primary col-lg-1" onclick="updateAuth()">
        <input type="button" onclick="back()" style="margin-left:10px;" value="返回列表"
               class="btn btn-default">
    </div>

</form>
</@override>
<@override name="window">
</@override>
<@extends name="../base_main.ftl"/>
