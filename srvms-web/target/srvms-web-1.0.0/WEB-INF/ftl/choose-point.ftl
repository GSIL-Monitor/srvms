<div id="modal-choosepoint" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" >
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                <h3>设置坐标</h3>
            </div>
            <div class="modal-body" style="padding: 0px;height: 400px;">
                <iframe id="modal-choosepoint-iframe" name="modal-choosepoint-iframe" scrolling="no" frameborder="0"
                        style="width: 100%;height: 400px;"></iframe>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="window.frames['modal-choosepoint-iframe'].window.chooseCallBack()" value="yes">确认</button>
                <a href="#" class="btn btn-default" data-dismiss="modal" aria-hidden="true">关闭</a>
            </div>
        </div>
    </div>
</div>
<script>
    var ChoosePoint = {
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
            $('#modal-choosepoint-iframe').attr('src', "${ctxPath}/common/toChoosePoint.action?lng=" + param.lng + "&lat=" + param.lat + "&province=" + param.province + "&city=" + param.city + "&district=" + param.district);
            $('#modal-choosepoint').modal('show')
        },
        close: function () {
            $('#modal-choosepoint').modal('hide');
        },
        callback: function (point) {
            this.cb(point);
            this.close();
        }
    }

    $("#modal-choosepoint").on("hidden.bs.modal", function () {
        $(this).removeData("bs.modal");
    });
</script>