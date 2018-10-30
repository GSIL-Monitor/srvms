<div id="modal-shop" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog">
        <div class="modal-content">
        </div>
    </div>
</div>
<script>
    /**
     * 参数 type , callback
     *
     * @type {{dom: null, open: Function, close: Function, callback: Function}}
     */
    var ChooseShop = {
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
        parseParam: function (param, key) {
            var _this = this;
            var paramStr = "";
            if (param instanceof String || param instanceof Number || param instanceof Boolean) {
                paramStr += "&" + key + "=" + encodeURIComponent(param);
            } else {
                $.each(param, function (i) {
                    var k = key == null ? i : key + (param instanceof Array ? "[" + i + "]" : "." + i);
                    paramStr += '&' + _this.parseParam(this, k);
                });
            }
            return paramStr.substr(1);
        },
        open: function (param, cb) {

            if (!this.isFunction(cb)) {
                return;
            }

            if (!this.checkParam(param)) {
                return;
            }

            this.cb = cb;

            var paramStr = '?' + this.parseParam(param);
            $('#modal-shop').modal({
                remote: '${ctxPath}/srv/shop/toChoose.action' + paramStr

            })
        },
        close: function () {
            $('#modal-shop').modal('hide');
        },
        callback: function (data) {
            this.cb(data);
            this.close();
        }
    }

    $("#modal-shop").on("hidden.bs.modal", function () {
        $(this).removeData("bs.modal");
        $(this).find('.modal-content').empty()
    });
</script>