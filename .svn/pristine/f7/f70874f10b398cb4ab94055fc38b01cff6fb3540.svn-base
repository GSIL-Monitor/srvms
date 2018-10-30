<script>
    function jumpPage(pageid, no, url) {
        var showDataView = $("#" + pageid);
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
        $("#" + pageid).find("input[name='page']").attr("value", no);
        showDataView.attr("action", url + "?cache=" + Math.random());
        showDataView.submit();
    }
</script>