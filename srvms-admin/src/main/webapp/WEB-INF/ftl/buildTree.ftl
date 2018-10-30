<#macro buildTree rootList maxLevel>
    <#if rootList?? && rootList?size gt 0>
    <ol class="dd-list">
        <#list rootList as root>
            <li class="dd-item" data-id="${root.id}">
                <div class="dd-handle" style="width:100%;">
                    [ID: ${root.id}] ${root.name!''}
                    <span class="pull-right">
                        <#if root.level lt maxLevel><a class="btn btn-default  btn-sm tooltips" href="javascript:void(0)" onclick="addChildItem('${root.id}')" data-original-title title="添加子节点"><i class="fa fa-plus"></i></a></#if>
                        <a class="btn btn-default  btn-sm tooltips" href="javascript:void(0)" onclick="updateItem('${root.id}')" data-original-title title="修改"><i class="fa fa-edit"></i></a>
                        <a class="btn btn-default  btn-sm tooltips" href="javascript:void(0)" onclick="deleteItem('${root.id}')" data-original-title title="删除" onclick=""><i class="fa fa-remove"></i></a>
                    </span>
                </div>
                <@buildTree root.childList maxLevel/>
            </li>
        </#list>
    </ol>
    </#if>
</#macro>