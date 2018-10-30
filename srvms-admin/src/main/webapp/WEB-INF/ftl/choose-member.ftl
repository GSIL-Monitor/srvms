<div id="modal-choosemember" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" >
        <div class="modal-content">
        </div>
    </div>
</div>
<script>
    /**
     * 参数 type , callback
     *
     *  type : 01 客户 02 供应商
     *
     * @type {{dom: null, open: Function, close: Function, callback: Function}}
     */
    var ChooseMember = {
        dom: null,
        cb: null,
        isFunction: function (func) {
            if (func && typeof func == 'function') {
                return true;
            }
            return false;
        },
        checkParam: function (obj) {
            if (obj && obj.type && (obj.type == '01' || obj.type == '02')) {
                return true;
            }
            return false;
        },
        open: function (param, cb) {

            if (!this.isFunction(cb)) {
                return;
            }

            if (!this.checkParam(param)) {
                return;
            }

            this.cb = cb;
            $('#modal-choosemember').modal({
                remote: "${ctxPath}/member/toChooseMember.action?type=" + param.type
            })
        },
        close: function () {
            $('#modal-choosemember').modal('hide');
        },
        callback: function (data) {
            this.cb(data);
            this.close();
        }
    }

    $("#modal-choosemember").on("hidden.bs.modal", function () {

        if (!this.cb || typeof this.cb == 'undefined' || typeof this.cb == 'function') {
            return;
        }

        $(this).removeData("bs.modal");
    });
</script>