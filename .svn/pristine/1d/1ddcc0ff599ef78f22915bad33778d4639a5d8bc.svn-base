<div id="modal-choosecompany" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" >
        <div class="modal-content">
        </div>
    </div>
</div>
<script>

    var ChooseCompany = {
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
            $('#modal-choosecompany').modal({
                remote: "${ctxPath}/company/toChooseCompany.action"
            })
        },
        close: function () {
            $('#modal-choosecompany').modal('hide');
        },
        callback: function (data) {
            this.cb(data);
            this.close();
        }
    }

    $("#modal-choosecompany").on("hidden.bs.modal", function () {
        $(this).removeData("bs.modal");
    });
</script>