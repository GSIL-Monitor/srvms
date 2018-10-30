<#macro selectheadbranch showEmpty setVal mode>
<script>

    var selectbranch = {
        showType: ''
    };
    selectbranch.getBranchCode = function () {
        var _this = this;
        if (_this.showType == 'select') {
            var select = $('.zl-common-selectbranch select[name="branchcode"]');
            if (select.length > 0) {
                return select.val();
            }
        } else if (selectbranch.showType == 'inputHidden') {
            return $('.zl-common-selectbranch input[name="branchcode"]').val();
        }
        return "";
    }

    selectbranch.getBranchName = function () {
        var _this = this;
        if (_this.showType == 'select') {
            var select = $('.zl-common-selectbranch select[name="branchcode"]');
            if (select.length > 0) {
                return select.find("option:selected").text()
            }
        } else if (_this.showType == 'inputHidden') {
            return $('.zl-common-selectbranch input[name="branchname"]').val();
        }
        return "";
    }

    selectbranch.getReturnHtml = function (backHtml, showflag) {
        var display = showflag ? 'block' : 'none';
        return '<div class="row zl-common-selectbranch" style="display:' + display + '"><div class="col-md-4"><div class="form-group"><label class="control-label col-md-3">门店</label><div class="col-md-9">' + backHtml + '</div></div></div></div>';
    }

    selectbranch.createSelectHtml = function () {
        var _this = this;

        var selectHtml = '<select class="form-control" name="branchcode" onchange="zlf.common.search(null,\'change\')">';
        var showEmpty = '${showEmpty}';
        if(showEmpty == '1'){
            selectHtml += '<option value="">全部</option>';
        }

        if (branchNodes) {
            var setVal = '${setVal}';
            for (var index in branchNodes) {
                var branch = branchNodes[index];
                var selected = '';
                if (setVal != '' && setVal == branch.branchcode) {
                    selected = 'selected';
                }
                selectHtml += '<option value="' + branch.branchcode + '" ' + selected + ' >' + branch.branchname + '</option>';
            }
        }

        selectHtml += '</select>';

        _this.showType = 'select';
        return _this.getReturnHtml(selectHtml, true);
    }

    selectbranch.createHiddenHtml = function () {
        var _this = this;
        var hiddenHtml = '<input type="hidden" name="branchname" value="' + userNodes.branchname + '"><input type="hidden" name="branchcode" value="' + userNodes.branchcode + '">';
        _this.showType = 'inputHidden';
        return _this.getReturnHtml(hiddenHtml, false);
    }

    selectbranch.createDefaultHtml = function () {
        var _this = this;

        var mode = '${mode!''}';
        if (mode == '') {
            return _this.createHiddenHtml();
        } else {
            var userMode = userNodes[mode];
            if (userMode) {
                if (userMode == 'SSM') {
                    return _this.createHiddenHtml();
                }
            } else {
                console.log('mode参数错误');
            }
        }
        return '';
    }

    selectbranch.createReturnHtml = function () {
        var _this = this;
        var ishead = userNodes.ishead;
        if (ishead != '1') {
            return _this.createHiddenHtml();
        } else {
            return _this.createSelectHtml();
        }
    }

    selectbranch.createHtml = function () {
        var _this = this;
        var mode = '${mode!''}';
        if (mode == '') {
            return _this.createReturnHtml();
        } else {
            var userMode = userNodes[mode];
            if (userMode) {
                if (userMode == 'SSM') {
                    return _this.createReturnHtml();
                }
            } else {
                console.log('mode参数错误');
            }
        }
        return '';
    }
</script>
<script>
    var selectbranchhtml = selectbranch.createHtml();
    document.write(selectbranchhtml);
</script>
</#macro>