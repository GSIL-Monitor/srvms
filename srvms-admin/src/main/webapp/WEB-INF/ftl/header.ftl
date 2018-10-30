<div class="navbar navbar-inverse navbar-static-top" role="navigation" style="position:static;">
    <div class="container-fluid">
        <ul class="nav navbar-nav">
            <li><a href="${ctxPath}/index.action"><i class="fa fa-reply-all"></i>返回系统</a></li>
        </ul>

        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown topbar-notice">
                <a type="button" data-toggle="dropdown">
                    <i class="fa fa-bell"></i>
                    <span class="badge" id="notice-total" style="background: ;">0</span>
                    <audio id="notifyAudio"><source src="notify.ogg" type="audio/ogg"><source src="${zl.admin.resource.address}/images/notify.mp3" type="audio/mpeg"><source src="${zl.admin.resource.address}/images/notify.mp3" type="audio/wav"></audio>
                </a>

                <div class="dropdown-menu" aria-labelledby="dLabel">
                    <div class="topbar-notice-panel">
                        <div class="topbar-notice-arrow"></div>
                        <div class="topbar-notice-head">系统消息</div>
                        <div class="topbar-notice-body">
                            <ul id="notice-container">
                            </ul>
                        </div>
                    </div>
                </div>
            </li>
            <script type="text/javascript" src="${zl.admin.resource.address}/js/message.js?version=${zl.admin.resource.version}"></script>
            <li><a href="javascript:;"><i class="fa fa-cubes"></i>使用说明</a></li>
            <li class="dropdown">
                <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown"
                   style="display:block; max-width:185px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; "><i
                        class="fa fa-user"></i>${Session["userInfo"].fullname!''}(${Session["userInfo"].name!''})<b
                        class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="${ctxPath}/sys_index.action"><i class="fa fa-sitemap fa-fw"></i>系统选项</a>
                    </li>
                    <li class="divider"></li>
                    <li><a href="${ctxPath}/login/entry/logout.action"><i
                            class="fa fa-sign-out fa-fw"></i> 退出系统</a>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</div>