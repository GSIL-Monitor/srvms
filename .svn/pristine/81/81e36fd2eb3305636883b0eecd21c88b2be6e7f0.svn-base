<div id="modal_work_order" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" >
        <div class="modal-content">
        </div>
    </div>
</div>
<script>
    var ChooseWorkOrder = {
        dom: null,
        cb: null,
        isFunction: function (func) {
            if (func && typeof func == 'function') {
                return true;
            }
            return false;
        },
        checkParam: function (obj) {
                return true;
        },
        open: function (param, cb) {
            if (!this.isFunction(cb)) {
                return;
            }

            if (!this.checkParam(param)) {
                return;
            }

            this.cb = cb;
            $('#modal_work_order').modal({
                remote: '${ctxPath}/workorder/toWorkOrderByWaitRepair.action'
            })
        },
        close: function () {
            $('#modal_work_order').modal('hide');
        },
        callback: function (data) {
            this.cb(data);
            this.close();
        }
    }

    $("#modal_work_order").on("hidden.bs.modal", function () {
        if (!this.cb || typeof this.cb == 'undefined' || typeof this.cb == 'function') {
            return;
        }
        $(this).removeData("bs.modal");
    });
</script>