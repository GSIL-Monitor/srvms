<#include "../default_cfg.ftl"/>
<div class="table-scrollable">
<table class="table table-hover table-bordered">
    <thead>
    <tr>
        <td width="48px"> 序号</td>
        <td> 商户编号</td>
        <td> 商户名称</td>
        <td> 联系电话 </td>
        <td> 所在区域 </td>
        <td> 行业</td>
        <td> 经营类型 </td>
        <td> 门店数</td>
        <td> 注册渠道</td>
        <td> 注册时间</td>
    </tr>
    </thead>
    <tbody>
    <#if pageInfo?? && pageInfo.list??>
        <#import "../rownum.ftl" as q>
        <#list pageInfo.list as shopInfo>
        <tr class="odd gradeX">
            <td> <@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=shopInfo_index /></td>
            <td>${shopInfo.shopcode!''}</td>
            <td>${shopInfo.shopname!''}</td>
            <td>${shopInfo.tel!''}</td>
            <td>${shopInfo.area!''}</td>
            <td>${shopInfo.industryname!''}</td>
            <td>
                <#if (shopInfo.softwaretype!'') == 1>
                    标准版
                    <#elseif (shopInfo.softwaretype!'') == 2>
                    连锁版
                </#if>
            </td>
            <td>${shopInfo.branchnum!''}</td>
            <td >
                 <#if (shopInfo.regchannel!'') == 0>
                     官网
                 <#elseif (shopInfo.regchannel!'') == 1>
                     服务商
                 </#if>
            </td>
            <td>${shopInfo.createtime!''}</td>
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