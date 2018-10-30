<#macro buildTree rootList maxLevel>
    <#if rootList?? && rootList?size gt 0>
    <ol class="dd-list">
        <#list rootList as root>
            <li class="dd-item" data-id="${root.id}">
                <div class="dd-handle" style="width:100%;">
                    [ID: ${root.id}] ${root.name!''}
                    <span class="pull-right">
                       <a class="btn btn-default  btn-sm"
                                                       href="javascript:void(0)"
                                                       onclick="ChooseTreeItem('${root.id!''}','${root.name!''}','${root.level!''}')"
                                                       data-original-title title="选择">选择</a>
                    </span>
                </div>
                <@buildTree root.childList maxLevel/>
            </li>
        </#list>
    </ol>
    </#if>
</#macro>