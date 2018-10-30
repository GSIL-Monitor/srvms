<#macro buildTree rootList maxLevel>
    <#if rootList?? && rootList?size gt 0>
    <ol class="dd-list">
        <#list rootList as root>
            <li class="dd-item" data-id="${root.id}">
                <div class="dd-handle" style="width:100%;">
                    [ID: ${root.id}] ${root.name!''}
                    <span class="pull-right">
                        <a class="btn btn-default btn-sm" href="javascript:void(0)" ischeck="<#if root.checked ?? && root.checked == '1'>1<#else>0</#if>" onclick="checkItem(this)" title=""><i data-id="${root.id}" class="fa <#if root.checked ?? && root.checked == '1'>fa-check-square-o<#else>fa-square-o</#if>"></i></a>
                    </span>
                </div>
                <@buildTree root.childList maxLevel/>
            </li>
        </#list>
    </ol>
    </#if>
</#macro>