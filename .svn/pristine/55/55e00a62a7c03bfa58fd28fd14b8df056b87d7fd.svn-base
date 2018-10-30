<#include "../default_cfg.ftl"/>
    <div class="table-scrollable" style="overflow-x:hidden;">
        <div class="portlet-body">
            <div class="row widget-row">
                <div class="col-md-4">
                    <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 ">
                        <h4 class="widget-thumb-heading">待处理</h4>

                        <div class="widget-thumb-wrap">
                            <i class="widget-thumb-icon bg-red icon-layers"></i>

                            <div class="widget-thumb-body">
                                <span class="widget-thumb-subtitle">总计</span>
                                        <span class="widget-thumb-body-stat" data-counter="counterup"
                                              data-value=""
                                              id="deviceBugHardwareNum"> <#if analysis?? >${analysis.waitdeal} 条<#else>0条</#if></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 ">
                        <h4 class="widget-thumb-heading">处理中</h4>

                        <div class="widget-thumb-wrap">
                            <i class="widget-thumb-icon bg-purple icon-screen-desktop"></i>

                            <div class="widget-thumb-body">
                                <span class="widget-thumb-subtitle">总计</span>
                                        <span class="widget-thumb-body-stat" data-counter="counterup"
                                              data-value=""
                                              id="deviceBugSoftwareNum"> <#if analysis?? >${analysis.dealing} 条<#else>0 条</#if></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 ">
                        <h4 class="widget-thumb-heading">已处理</h4>

                        <div class="widget-thumb-wrap">
                            <i class="widget-thumb-icon bg-purple icon-bulb"></i>

                            <div class="widget-thumb-body">
                                <span class="widget-thumb-subtitle">总计</span>
                                        <span class="widget-thumb-body-stat" data-counter="counterup"
                                              data-value=""
                                              id="deviceBugSoftwareNum"> <#if analysis?? >${analysis.dealed} 条<#else>0 条</#if> </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <table class="table table-hover table-bordered" >

        <thead>
        <tr style="border: 1px solid #eee">
            <th width="48px"> 序号</th>
            <th> 设备型号</th>
            <th> 设备号</th>
            <th> 设备类型</th>
            <th> 商户编号</th>
            <th> 商户名称</th>
            <th> 门店编号</th>
            <th> 门店名称</th>
            <th> 出错部件</th>
            <th> 处理状态</th>
            <th> 报错时间</th>
            <th> 详情</th>
        </tr>
        </thead>
        <tbody>
        <#if pageInfo?? && pageInfo.list??>
            <#import "../rownum.ftl" as q>
            <#list pageInfo.list as equip>
            <tr class="odd gradeX" style="border: 1px solid #eee">
                <td><@q.rownum page=pageInfo.page pageSize=pageInfo.pageSize index=equip_index /> </td>
                <td> ${equip.systemmodel!''}</td>
                <td> ${equip.deviceuniquecode!''}</td>
                <td>
                        <#if equip.devicetype?? && equip.devicetype == '1'>
                            收银机
                        <#elseif equip.devicetype?? && equip.devicetype == '2'>
                            广告机
                        </#if>
                </td>
                <td> ${equip.shopcode!''}</td>
                <td> ${equip.shopname!''}</td>
                <td> ${equip.branchcode!''}</td>
                <td> ${equip.branchname!''}</td>
                <td> ${equip.errortype!''}</td>
                <td>
                    <#if equip.repairstate == 0>
                        暂不处理
                    <#elseif equip.repairstate == 1>
                        待处理
                    <#elseif equip.repairstate == 2>
                        处理中
                    <#elseif equip.repairstate == 3>
                        已处理
                    </#if>
                </td>
                <td> ${equip.createtime!''}</td>
                <td>
                    <a href="javascript:goto('${ctxPath}/equipmonitor/details.action?errortypeid=${equip.errortypeid!''}&deviceuniquecode=${equip.deviceuniquecode!''}&shopcode=${equip.shopcode!''}','searchForm');"
                       class="btn btn-default btn-sm tooltips" title="详情">
                        <i class="fa fa-plug"></i>
                    </a>
                        <a href="javascript:editEquipStaus('${equip.deviceuniquecode!''}','${equip.shopcode!''}','${equip.errortype!''}','${equip.repairstate!''}')"
                           class="btn btn-default btn-sm tooltips" title="变更">
                            <i class="fa fa-edit"></i>
                        </a>
                </td>
            </tr>
            </#list>
        </#if>
        </tbody>
    </table>
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