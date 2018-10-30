<#include "../default_cfg.ftl"/>
<div class="table-scrollable">
    <table class="table table-hover table-bordered">
        <thead>
        <tr>
            <th width="48px"> 序号</th>
            <th width="50">
                <input type="checkbox" name="checkAllButton"
                       onclick="checkAllEvent(this,'checkboxname','checkAllButton');">
            </th>
            <th> 商户ID</th>
            <th> 商户名称</th>
            <th> 联系人</th>
            <th> 联系电话</th>
            <th> 跟进标注</th>
            <th> 跟进备注</th>
            <th> 经营类目</th>
            <th> 分店数</th>
            <th> 注册时间</th>
            <th> 操作</th>
        </tr>
        </thead>
        <tbody>
        <#if pageInfo?? && pageInfo.list??>
            <#import "../rownum.ftl" as q>
            <#list pageInfo.list as shop>
            <tr class="odd gradeX">
                <td > <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=shop_index /></td>
                <td >
                    <label><input type="checkbox" name="checkboxname" shopcode="${shop.shopcode!''}"
                                  servercode="${shop.servercode!''}"
                                  value="${shop.id!''}"></label>
                </td>
                <td > ${shop.shopcode!''}</td>
                <td > ${shop.shopname!''}</td>
                <td > ${shop.contact!''}</td>
                <td > ${shop.tel!''}</td>
                <td >
                    <select class="form-control" style="width: 120px" onchange="followlabel_select(this,${shop.id!''},${shop.shopcode!''})">
                        <option value="">无状态</option>
                        <option value="0" <#if (shop.followlabel!'') == '0'>selected</#if>>在试用</option>
                        <option value="1" <#if (shop.followlabel!'') == '1'>selected</#if>>有意向</option>
                        <option value="2" <#if (shop.followlabel!'') == '2'>selected</#if>>已购买</option>
                        <option value="3" <#if (shop.followlabel!'') == '3'>selected</#if>>已流失</option>
                    </select>
                </td>
                <td> ${shop.followremark!''}<a href="javascript:void(0)" onclick="open_followremark_update('${shop.followremarkdetail!''}','${shop.shopcode!''}','${shop.id!''}')" class="btn btn-default  btn-sm tooltips" data-original-title="修改"><i class="fa fa-edit"></i></a></td>
                <td > ${shop.industryname!''}</td>
                <td > ${shop.branchcount!''}</td>
                <td > ${shop.createtime!''}</td>
                <td >
                    <a href="javascript:goto('${ctxPath}/srv/shop/manage/branchdetail.action?shopcode=${shop.shopcode!''}','searchForm');"
                       class="primary-link">详情
                    </a>
                </td>
            </tr>
            </#list>
        </#if>
        </tbody>
    </table>
</div>
<#if pageInfo?? && pageInfo.totalRecords gt 0>
<div class="row">
    <div class="col-md-12 col-sm-12">
        <form class="zl-content-pager-form" method="post">
            <#import "../zlf_common_pager.ftl" as q>
			                    <@q.pager page=pageInfo.page pageSize=pageInfo.pageSize totalRecords=pageInfo.totalRecords/>
        </form>
    </div>
</div>
</#if>