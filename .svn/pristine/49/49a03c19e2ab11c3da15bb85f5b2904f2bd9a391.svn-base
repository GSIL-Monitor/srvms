<#include "../default_cfg.ftl"/>
<div class="modal-header">
    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
    <h4>返修部件价格清单</h4>
</div>
<div class="modal-body">
    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead class="navbar-inner">
            <tr>
                <th>序号</th>
                <th>配件名称</th>
                <th>版本型号</th>
                <th>配置参数</th>
                <th>单价（元）</th>
                <th>数量</th>
                <th>小计（元）</th>
            </tr>
            </thead>
            <tbody>
                <#if workOrderPrices?? && workOrderPrices??>
                    <#list workOrderPrices as workOrderPrice>
                        <tr>
                            <td>${workOrderPrice_index + 1}</td>
                            <td>${workOrderPrice.productname!''}</td>
                            <td>${workOrderPrice.versionmodel!''}</td>
                            <td>${workOrderPrice.productarg!''}</td>
                            <td>${workOrderPrice.saleprice!''}</td>
                            <td>${workOrderPrice.nums!''}</td>
                            <td>${workOrderPrice.totalprice!''}</td>
                        </tr>
                    </#list>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>总计:</td>
                        <td>${totalNums!''}</td>
                        <td>${totalPrice!''}</td>
                    </tr>
                </#if>
            </tbody>
        </table>
    </div>
</div>