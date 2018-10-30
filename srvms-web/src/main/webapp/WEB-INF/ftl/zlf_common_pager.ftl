<#-- 自定义的分页指令。
属性说明：
   page      当前页号(int类型)
   pageSize    每页要显示的记录数(int类型)
   toURL       点击分页标签时要跳转到的目标URL(string类型)
   totalRecords 总记录数(int类型)
   pageid  分页表单id
 使用方式：
  <#if totalRecords??>
    <#import "/pager_1.ftl" as q>
    <@q.pager pageid=pageid page=page pageSize=pageSize totalRecords=totalRecords toURL="testpager.action"/>
  </#if>
 -->
<#macro pager page pageSize totalRecords>
    <#assign pageid=.now?string('yyyyMMddhhmmssSSS') />
<#-- 定义局部变量pageCount保存总页数 -->
    <#assign pageCount=((totalRecords + pageSize - 1) / pageSize)?int>
    <#if totalRecords==0><#return/></#if>
<#-- 页号越界处理 -->
    <#if (page > pageCount)>
        <#assign page=pageCount>
    </#if>
    <#if (page < 1)>
        <#assign page=1>
    </#if>
<#-- 输出分页表单 -->
    <#if pageCount gt 1>

    <script>

        function jumpPage_${pageid!''}(no) {
            var showDataView = $(".zl-content-pager-form");
            var pageCount = 0;
            <#if pageInfo??>
                pageCount = ${((pageInfo.totalRecords+pageInfo.pageSize -1)/pageInfo.pageSize)?int};
            </#if>
            if (no > pageCount) {
                no = pageCount;
            }
            if (no < 1) {
                no = 1;
            }
            showDataView.find("input[name='page']").attr("value", no);
            zlf.common.search(showDataView.serialize(),"page");
        }
    </script>

    <div class="dataTables_paginate paging_bootstrap_full_number">
        <#list RequestParameters?keys as key>
            <#if (key!="page" && RequestParameters[key]??)>
                <input type="hidden" name="${key}" value="${RequestParameters[key]}"/>
            </#if>
        </#list>

        <input type="hidden" name="page" value="${page}"/>

        <ul class="pagination" style="visibility: visible;margin:2px 0">
        <#-- 把请求中的所有参数当作隐藏表单域(无法解决一个参数对应多个值的情况)-->
            <#assign start=1>
            <#assign end=pageCount>

            <#if (page != 1)>
                <li><a href="javascript:void(0)" onclick="jumpPage_${pageid!''}(${start})"><i
                        class="fa fa-angle-double-left"></i></a>
                </li>
                <li><a href="javascript:void(0)" onclick="jumpPage_${pageid!''}(${page - 1})"><i
                        class="fa fa-angle-left"></i></a>
                </li>
            </#if>

            <#if page lt 3>
                <#assign start=1>
                <#assign end=5>
            <#elseif page gt (pageCount-2)>
                <#assign start=pageCount-4>
                <#assign end=pageCount>
            <#else>
                <#assign start=(page-2)>
                <#assign end=(page+2)>
            </#if>

            <#if start lt 1>
                <#assign start=1>
            </#if>
            <#if end gt pageCount>
                <#assign end=pageCount>
            </#if>

            <#list start..end as i>
                <li <#if i==page>class="active"</#if> >
                    <a href="javascript:void(0)" onclick="jumpPage_${pageid!''}(${i})">${i}</a>
                </li>
            </#list>

            <#if (page != pageCount)>
                <li><a href="javascript:void(0)" onclick="jumpPage_${pageid!''}(${page + 1})"
                       class="pager-nav"><i class="fa fa-angle-right"></i></a></li>
                <li><a href="javascript:void(0)" onclick="jumpPage_${pageid!''}(${pageCount})"
                       class="pager-nav"><i class="fa fa-angle-double-right"></i></a></li>
            </#if>

        </ul>
    </div>
    </#if>
</#macro>