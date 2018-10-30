<@override name="right">
<div class="row">
    <div class="col-md-12">
        <div class="portlet light ">
            <div class="portlet-title">
                <div class="caption font-dark">
                    <span class="caption-subject bold uppercase main-content-title">延长试用期-详情</span>
                </div>
            </div>
            <div class="panel-body">
                <div class="col-md-12">
                    <label class="control-label col-md-12" style="padding-left: 0px"><h5 style="font-weight:bold"><img src="${ctxPath}/images/label.png" style="width: 5px;margin-right: 5px;"/>基本信息：</h5></label>
                    <div class="col-md-12" style="padding-left: 0px;margin-top: 20px;margin-bottom:  20px">
                        <div class="col-md-3" style="padding-left: 0px ;padding-top :7px">
                            <p>操作编号：${extendInfoList[0].billcode!''}
                        </div>
                        <div class="col-md-3" style="padding-left: 0px ;padding-top :7px">
                            <span>延长天数：7天</span>
                        </div>
                        <div class="col-md-3" style="padding-left: 0px;padding-top :7px">
                            <p>经办人：${extendInfoList[0].createusername!''}</p>
                        </div>
                        <div class="col-md-3" style="padding-left: 0px;padding-top :7px">
                            <span>操作时间：${extendInfoList[0].createtime!''}</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-12" style="padding-left: 0px">
                    <label class="control-label col-md-12"><h5 style="font-weight:bold"><img src="${ctxPath}/images/label.png" style="width: 5px;margin-right: 5px;"/>商品信息</h5></label>
                </div>
                <div class="col-md-12">
                    <div class="table-scrollable">
                        <table class="table table-hover table-bordered">
                            <thead>
                            <tr>
                                <th width="48px"> 序号</th>
                                <th> 商户ID</th>
                                <th> 商户名称</th>
                                <th> 门店编号</th>
                                <th> 门店名称</th>
                                <th> 到期时间</th>
                                <th> 备注</th>
                            </tr>
                            </thead>
                            <tbody>
                                <#if extendInfoList??>
                                    <#list extendInfoList as extendInfo>
                                        <#if ((extendInfo.shopcode!'') == (shopcode!'')) && ((extendInfo.branchcode!'') == (branchcode!''))>
                                            <tr>
                                                <td><p style="color: blue">${extendInfo_index + 1}</p></td>
                                                <td><p style="color: blue">${extendInfo.shopcode!''}</p></td>
                                                <td><p style="color: blue">${extendInfo.shopname!''}</p></td>
                                                <td><p style="color: blue">${extendInfo.branchcode!''}</p></td>
                                                <td><p style="color: blue">${extendInfo.branchname!''}</p></td>
                                                <td><p style="color: blue">${extendInfo.preexpiretime!''}</p></td>
                                                <td><p style="color: blue">${extendInfo.remark!''}</p></td>
                                            </tr>
                                        <#else >
                                            <tr>
                                                <td>${extendInfo_index + 1}</td>
                                                <td>${extendInfo.shopcode!''}</td>
                                                <td>${extendInfo.shopname!''}</td>
                                                <td>${extendInfo.branchcode!''}</td>
                                                <td>${extendInfo.branchname!''}</td>
                                                <td>${extendInfo.preexpiretime!''}</td>
                                                <td>${extendInfo.remark!''}</td>
                                            </tr>
                                        </#if>
                                    </#list>
                                </#if>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-md-6" style="margin-top: 50px">
                    <button type="button"  class="btn btn-primary btn-default  center-block"  style="margin-right: 10px;" onclick="javascript:window.location = '${ctxPath}/renew/extend/extendManage.action'">返回</button>
                </div>
            </div>
        </div>
    </div>
</div>
</@override>
<@override name="window">
</@override>
<@extends name="../base_main.ftl"/>