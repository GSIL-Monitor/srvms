<#include "../default_cfg.ftl"/>
<script>
    function refreshWorkOrderList(params) {
        var url = '${ctxPath}/workorder/findWorkOrderByWaitRepair.action';
        ajaxInSameDomain(url, params, function (result) {
            $('#module-menus').html(result);
        },'html')

    }
    function searchWorkOrder() {
        var params = {
            workordercode:$('.modal-body #workordercode').val()
        };
        refreshWorkOrderList(params);
        $('#searchForm').serialize()
    }
    $(function(){
        refreshWorkOrderList(null);
    })
</script>
<div class="modal-header">
    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
    <h3>添加硬件工单</h3>
</div>
<div class="modal-body">
    <form action="#" id="searchForm" class="form-horizontal" method="post">
        <div class="form-body">
            <div class="row">
                <div class="col-md-6 col-sm-6">
                    <div class="form-group">
                        <label class="control-label col-md-3">工单编号</label>
                        <div class="col-md-9">
                            <input type="text" id="workordercode" name="workordercode" value="" class="form-control"
                                   placeholder="请输入工单编号">
                        </div>
                    </div>
                </div>
                <div class="col-md-2 col-sm-6">
                    <button type="button" class="btn btn-default " onclick="searchWorkOrder()">
                        <i class="fa fa-search"></i> 搜索
                    </button>
                </div>
            </div>
        </div>
    </form>
    <div id="module-menus" style="padding-top:5px;">
        <#include "simple_work_order_table.ftl"/>
    </div>
</div>
<div class="modal-footer">
    <a href="#" class="btn btn-default" data-dismiss="modal" aria-hidden="true">关闭</a>
</div>