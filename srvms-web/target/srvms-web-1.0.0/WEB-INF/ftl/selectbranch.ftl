<#macro selectbranch ZLBranchList showEmpty>
    <#if ZLBranchList?? && ZLBranchList?size gt 0>
    <div class="col-md-4">
        <div class="form-group">
            <label class="control-label col-md-3">门店</label>

            <div class="col-md-9">
                <select class="form-control" id="ZLBranchSelect" name="branchcode" onchange="zlf.common.search()">
                    <#if showEmpty == 1>
                        <option value="" selected>全选</option>
                    </#if>
                    <#list ZLBranchList as branch>
                        <#if branch_index == 0>
                            <option value="${branch.branchcode!''}" <#if showEmpty != 1>selected</#if>>${branch.branchname!''}</option>
                        <#else>
                            <option value="${branch.branchcode!''}">${branch.branchname!''}</option>
                        </#if>
                    </#list>
                </select>
            </div>
        </div>
    </div>
    </#if>
<script>
    var selectbranch = {};
    selectbranch.getBranchCode = function () {
        var select = $('#ZLBranchSelect');
        if (select.length > 0) {
            return select.val();
        }
        return "";
    }

    selectbranch.getBranchName = function () {
        var select = $('#ZLBranchSelect');
        if (select.length > 0) {
            return select.find("option:selected").text()
        }
        return "";
    }
</script>
</#macro>