<#include "../default_cfg.ftl"/>
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<style type="text/css">
        .shoplist {
            width: 580px;
            margin: 200px auto;
            box-sizing: border-box;
            border: 1px solid #eee;
            height: 356px;
            font-size: 14px;
            color: #333333;
        }
        .shoplistLeft {
            border-right: 1px solid #eee;
        }
        .shoplistLeft, .shoplistRight {
            box-sizing: border-box;
            float: left;
            width: 49.99%;
            position: relative;
            height: 100%;
            padding: 0 10px;
            overflow: auto;
        }
        .shopSearchContent {
            margin: 10px 0;
        }
        .alreadySelectedShop {
            border-bottom: 1px solid #ccc;
            padding: 12px 0;
            margin-bottom: 4px;
        }
        .shoplistRight ul, .branchItemList ul {
            margin: 0;
            padding:0;
        }
        .shoplistRight ul li {
            position: relative;
            line-height: 24px;
            padding:0 10px;
        }
        .shoplistRight ul li:hover {
            background-color: #f1f1f1;
        }
        .shoplistRight ul li span {
            position: absolute;
            right: 10px;
            font-family: "arial","tahoma";
            cursor:pointer;
        }
        .branchItemList .mr15 {
            margin-right: 15px;
        }
        .branchItemList ul li {
        }
        .branchItemList ul li.pr {
            /*cursor: pointer;*/
            padding: 0 10px;
            margin-bottom: 5px;
        }
        .branchItemList ul li span.pa {
            right:10px;
            top: 3px;
            cursor: pointer;
        }
        .branchItemList .branchItemChild {
            list-style: none;
            padding-left: 46px;

        }
        .branchItemList .branchItemChild label {
            display: block;
        }
        .branchItemList .branchItemChild * {
            font-weight: normal;
        }
        .pr {
            position: relative;
        }
        .pa {
            position: absolute;
        }
        .dn {
            display: none;
        }
    </style>
	<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
	<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
	<script type="text/javascript">


        $(function(){
            //左侧商户点击时候的效果
            $('.branchItemList>ul>li').click(function(){
                var branchItemChild = $(this).find('.branchItemChild');
                branchItemChild.toggleClass('dn');
                if(branchItemChild.is(':visible')) {
                    branchItemChild.prev().removeClass('glyphicon-menu-up').addClass('glyphicon-menu-down');
                } else {
                    branchItemChild.prev().removeClass('glyphicon-menu-down').addClass('glyphicon-menu-up');
                }
            })

            //全选子项 或 取消全选
            $('.selectAllChilds').click(function(){
                var checked = $(this)[0].checked;
                $(this).parent().find('.branchItemChild :checkbox').each(function(){
                    //父级取消全选 || 子项未选
                    if(checked === false || $(this)[0].checked === false) {
                        $(this)[0].checked = checked;
                        $(this).trigger('change');
                    }
                })

                //如果子项没有展开，则展开子项
                if(!$(this).parent().find('.branchItemChild').is(":visible")) {
                    $(this).parent().trigger('click');
                }
            });

            //商户下的子项目  门店点选时候的处理
            $('.branchItemChild :checkbox').change(function() {
                var value = $(this).val();
                var appendHTML = '<li data="'+value+'">' + value + '<span title="移除选项">X</span></li>';

                //获取当前父级中一共有多少个子项的checkbox
                var checkboxLength = $(this).parents('.branchItemChild').find(":checkbox").length;

                //获取当前父级中一共有多少个子项的checkbox被选中
                var checkboxCheckedLength = $(this).parents('.branchItemChild').find(":checked").length;

                // alert(checkboxCheckedLength);

                //如果选中的子项 跟 子项数量相等,那么选中父级的checkbox
                if(checkboxLength == checkboxCheckedLength) {
                    $(this).parents('.branchItemChild').parent().find('.selectAllChilds')[0].checked = true;
                } else {
                    $(this).parents('.branchItemChild').parent().find('.selectAllChilds')[0].checked = false;
                }

                if($(this)[0].checked == true) {
                    $(appendHTML).appendTo('.selectedBranchItem');
                } else {
                    //取消选择,移除对应项
                    $('.selectedBranchItem li').each(function(){
                        if($(this).attr('data') == value) {
                            $(this).remove();
                        }
                    })
                }
            });

            //右侧x点击删除事件
            $("body").on('click', '.selectedBranchItem li span', function(){
                var value = $(this).parent().attr("data");
                $(this).parent().remove(); //删除右侧选项

                //同时需要把左侧的选中项反选
                $('.branchItemChild :checkbox').each(function(){
                    if(value == $(this).val()) {
                        // $(this)[0].checked = false;
                        $(this).trigger('click');
                    }
                })
            });

            //阻止冒泡
            $('.branchItemChild li, .selectAllChilds').click(function(e) {
                e.stopPropagation();
            });
        })
    </script>
</head>

<body>
<div class="portlet-title">

</div>

<div class="shoplist">
    <div class="caption font-dark">
        <span class="caption-subject bold uppercase main-content-title">添加门店</span>
    </div>
    <div class="modal-footer">
        <a href="#" class="btn btn-default"  aria-hidden="true">保存</a>
        <a href="#" class="btn btn-default" data-dismiss="modal" aria-hidden="true">关闭</a>
    </div>
    <div class="shoplistLeft">
        <div class="shopSearchContent">
            <form class="form-inline" onsubmit="search(); return false;">
                <div class="form-group">
                    <input style="width: 193px;" class="form-control" id="branchname" placeholder="输入商户ID、名称查询">
                </div>
                <button type="submit" class="btn btn-default">查询</button>
            </form>
        </div>
        <div class="branchItemList">
            <ul>
                <li class="pr">
                    <input class="selectAllChilds" type="checkbox" />
                    <span class="mr15"   name="shopcode">125806649</span>
                    <span class="mr15"   name="shopname">商户名称1</span>
                    <span class="glyphicon glyphicon-menu-up pa"></span>
                    <ul class="branchItemChild dn">
                        <li>
                            <label>
                                <input type="checkbox" value="125806649-001-门店一">
                                <span class="mr15">001</span>
                                <span>门店一</span>
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" value="125806649-002-门店一">
                                <span class="mr15">002</span>
                                <span>门店一</span>
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" value="125806649-003-门店一">
                                <span class="mr15">003</span>
                                <span>门店一</span>
                            </label>
                        </li>
                    </ul>
                </li>
                <li class="pr">
                    <input class="selectAllChilds" type="checkbox" />
                    <span class="mr15">125806666</span>
                    <span class="mr15">商户名称66</span>
                    <span class="glyphicon glyphicon-menu-up pa"></span>
                    <ul class="branchItemChild dn">
                        <li>
                            <label>
                                <input type="checkbox" value="125806666-001-门店一66">
                                <span class="mr15">001</span>
                                <span>门店一66</span>
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" value="125806666-002-门店二66">
                                <span class="mr15">002</span>
                                <span>门店二66</span>
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" value="125806666-003-门店三66">
                                <span class="mr15">003</span>
                                <span>门店三66</span>
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" value="125806666-004-门店三66">
                                <span class="mr15">004</span>
                                <span>门店三66</span>
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" value="125806666-005-门店三66">
                                <span class="mr15">005</span>
                                <span>门店三66</span>
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="checkbox" value="125806666-006-门店三66">
                                <span class="mr15">006</span>
                                <span>门店三66</span>
                            </label>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <div class="shoplistRight">
        <p class="alreadySelectedShop">已选择门店</p>
        <ul class="selectedBranchItem">
            <!--<li branchid="1">
                125806667-001 门店一
                <span title="移除选项">X</span>
            </li>
            <li branchid="2">
                125806667-001 门店一
                <span title="移除选项">X</span>
            </li>
            <li branchid="3">
                125806667-001 门店一
                <span title="移除选项">X</span>
            </li>
            <li branchid="4">
                125806667-001 门店一
                <span title="移除选项">X</span>
            </li>
            <li branchid="5">
                125806667-001 门店一
                <span title="移除选项">X</span>
            </li>
            <li branchid="6">
                125806667-001 门店一
                <span title="移除选项">X</span>
            </li>
            <li branchid="7">
                125806667-001 门店一
                <span title="移除选项">X</span>
            </li>
            <li branchid="">
                125806667-001 门店一
                <span title="移除选项">X</span>
            </li>
            <li branchid="">
                125806667-001 门店一
                <span title="移除选项">X</span>
            </li>
            <li branchid="">
                125806667-001 门店一
                <span title="移除选项">X</span>
            </li>
            <li branchid="">
                125806667-001 门店一
                <span title="移除选项">X</span>
            </li>
            <li branchid="">
                125806667-001 门店一
                <span title="移除选项">X</span>
            </li>
            <li branchid="">
                125806667-001 门店一
                <span title="移除选项">X</span>
            </li>
            <li branchid="">
                125806667-001 门店一
                <span title="移除选项">X</span>
            </li>
            <li branchid="">
                125806667-001 门店一
                <span title="移除选项">X</span>
            </li>
            <li branchid="">
                125806667-001 门店一
                <span title="移除选项">X</span>
            </li>
            <li branchid="">
                125806667-001 门店一
                <span title="移除选项">X</span>
            </li> -->
        </ul>
    </div>
</div>
</body>