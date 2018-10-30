<div id="modal-chooseicon" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" >
        <div class="modal-content">
        </div>
    </div>
</div>
<script>
    var ChooseIcon = {
        dom: null,
        open: function (dom) {
            this.dom = dom;
            $('#modal-chooseicon').modal({
                remote: "${ctxPath}/common/toIconList.action"
            })
        },
        close: function () {
            $('#modal-chooseicon').modal('hide')
        },
        callback: function (ico) {
            $(this.dom).parent().prev().val(ico);
            $(this.dom).parent().prev().prev().find('i').attr('class', '').addClass(ico);
            ChooseIcon.close();
        }
    }
</script>