<div id="modal_wechat_shop" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" >
        <div class="modal-content">
        </div>
    </div>
</div>
<script>
    var ChooseWechatShop = {
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
            $('#modal_wechat_shop').modal({
                remote: '${ctxPath}/renew/chooseShop/wechatShop.action'
            })
        },
        close: function () {
            $('#modal_wechat_shop').modal('hide');
        },
        callback: function (data) {
            this.cb(data);
            this.close();
        }
    }

    $("#modal_wechat_shop").on("hidden.bs.modal", function () {
        if (!this.cb || typeof this.cb == 'undefined' || typeof this.cb == 'function') {
            return;
        }
        $(this).removeData("bs.modal");
    });
</script>