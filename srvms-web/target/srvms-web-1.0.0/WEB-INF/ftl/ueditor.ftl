<#macro ueditor domId height ctxPath>
<script type="text/javascript"
        src="http://091801.zhonglunnet.com/web/js/ueditor/ueditor.config.js?version=1.0.0"></script>
<script type="text/javascript"
        src="http://091801.zhonglunnet.com/web/js/ueditor/ueditor.all.min.js?version=1.0.0"></script>
<script type="text/javascript"
        src="http://091801.zhonglunnet.com/web/js/ueditor/lang/zh-cn/zh-cn.js?version=1.0.0"></script>
<textarea id="${domId}" name="${domId}" type="text/plain" style="height:${height}px;"></textarea>
<script>

    var ueditoroption = {
        autoClearinitialContent: !1,
        toolbars: [["fullscreen", "source", "preview", "|", "bold", "italic", "underline", "strikethrough", "forecolor", "backcolor", "|", "justifyleft", "justifycenter", "justifyright", "|", "insertorderedlist", "insertunorderedlist", "blockquote", "emotion", "link", "removeformat", "|", "rowspacingtop", "rowspacingbottom", "lineheight", "indent", "paragraph", "fontsize", "|", "inserttable", "deletetable", "insertparagraphbeforetable", "insertrow", "deleterow", "insertcol", "deletecol", "mergecells", "mergeright", "mergedown", "splittocells", "splittorows", "splittocols", "|", "anchor", "map", "print", "drafts"]],
        elementPathEnabled: !1,
        initialFrameHeight: "200",
        focus: !1,
        maximumWords: 9999999999999,
        autoFloatEnabled: !1,
        imageScaleEnabled: 1
    };

    UE.registerUI("myinsertimage", function (a, b) {
        a.registerCommand(b, {
            execCommand: function () {

                function uploadCallBack(dataList) {
                    if (dataList && dataList.length > 0) {
                        for (var index in dataList) {
                            var data = dataList[index];
                            a.execCommand("insertimage", {
                                src: attachUrl + '/' + data.url,
                                _src: data.url,
                                alt: data.name
                            })
                        }
                    }
                }

                $.fn.FileUploader.openUploadFile(this, {type: 'image', callback: uploadCallBack, limit: 200});
            }
        });
        var c = new UE.ui.Button({
            name: "插入图片",
            title: "插入图片",
            cssRules: "background-position: -726px -77px",
            onclick: function () {
                a.execCommand(b)
            }
        });
        return a.addListener("selectionchange", function () {
            var d = a.queryCommandState(b);
            -1 == d ? (c.setDisabled(!0), c.setChecked(!1)) : (c.setDisabled(!1), c.setChecked(d))
        }), c
    }, 19);
    UE.registerUI("myinsertvideo", function (a, b) {
        a.registerCommand(b, {
            execCommand: function () {

                function uploadCallBack(dataList) {
                    if (dataList && dataList.length > 0) {
                        for (var index in dataList) {
                            var data = dataList[index];
                            a.execCommand("insertimage", {
                                src: attachUrl + '/' + data.url,
                                _src: data.url,
                                alt: data.name
                            })
                        }
                    }
                }

                $.fn.FileUploader.openUploadFile(this, {type: 'video', callback: uploadCallBack, limit: 200});
            }
        });
        var c = new UE.ui.Button({
            name: "插入视频",
            title: "插入视频",
            cssRules: "background-position: -320px -20px",
            onclick: function () {
                a.execCommand(b)
            }
        });
        return a.addListener("selectionchange", function () {
            var d = a.queryCommandState(b);
            -1 == d ? (c.setDisabled(!0), c.setChecked(!1)) : (c.setDisabled(!1), c.setChecked(d))
        }), c
    }, 20);
    var a = UE.getEditor("${domId}", ueditoroption);
    $("#${domId}").data("editor", a), $("#${domId}").parents("form").submit(function () {
        a.queryCommandState("source") && a.execCommand("source")
    })
</script>
</#macro>