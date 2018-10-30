<script>

    function getMenuItem(pathName) {
        if (menuNodes.length > 0) {
            for (var index in menuNodes) {
                var menuItem = menuNodes[index];
                if (menuItem.url != '' && pathName.indexOf(menuItem.url) != -1) {
                    setMenuParent(menuItem);
                    return menuItem;
                }
            }
        }
        return null;
    }

    function setMenuParent(menuItem) {
        if (menuNodes.length > 0) {
            for (var index in menuNodes) {
                var _menuItem = menuNodes[index];
                if (_menuItem.id == menuItem.pid) {
                    setMenuParent(_menuItem);
                    menuItem.parent = _menuItem;
                }
            }
        }
    }

    function getBreadCrumbLiContent(item) {
        if (item) {
            if (item.url && item.url != '') {
                return '<a href="' + ctxPath + item.url + '">' + item.name + '</a>';
            }
            else {
                return '<span>' + item.name + '</span>';
            }
        }
        return '<span></span>';
    }

    function getBreadCrumbHtml(pathName) {
        var breadCrumbHtml = '<li><i class="icon-home"></i><a href="' + ctxPath + '/index.action">首页</a></li>';
        var menuItem = getMenuItem(pathName);
        if (menuItem) {
            var tempHtml = '';
            var parentItem = menuItem.parent;
            while (parentItem) {
                tempHtml = '<li><i class="fa fa-angle-right"></i>' + getBreadCrumbLiContent(parentItem) + '</li>' + tempHtml;
                parentItem = parentItem.parent;
            }
            breadCrumbHtml += tempHtml;
        }
        return breadCrumbHtml;
    }

    function showBreadCrumb() {
        var pathName = window.location.pathname;
        var breadCrumbHtml = getBreadCrumbHtml(pathName);
        $('.page-breadcrumb').html(breadCrumbHtml);
    }

    function showPageTitle() {
        var pathName = window.location.pathname;
        var menuItem = getMenuItem(pathName);
        $('#page-title').html(menuItem.name + '<small> ' + (menuItem.subname || '') + '</small>');
    }

    function showFuncNav() {
        var pathName = window.location.pathname;
        var menuItem = getMenuItem(pathName);
        if (menuItem) {
            var funTitle = '<li class="active"><a  href="javascript:window.location.reload()">' + menuItem.name + '</a></li>';
            $('#funtitle').html(funTitle);
            $('#funtitle').show();
        }
    }

    function getMenuById(menuId) {
        for (var index in menuNodes) {
            var menuItem = menuNodes[index];
            if (menuItem.id == menuId) {
                return menuItem;
            }
        }
        return null;
    }

    function getMenuByPathName(pathName) {
        for (var index in menuNodes) {
            var menuItem = menuNodes[index];
            if (menuItem.url != '' && pathName.indexOf(menuItem.url) != -1) {
                return menuItem;
            }
        }
        return null;
    }

    function getSameParentMenuList(pathName) {
        var result = [];
        if (menuNodes.length > 0) {

            var _menuItem = getMenuByPathName(pathName);
            if (_menuItem.level == 3) {
                _menuItem = getMenuById(_menuItem.pid);
            }

            for (var index in menuNodes) {
                var menuItem = menuNodes[index];
                if (menuItem.pid == _menuItem.pid) {
                    if (menuItem.id == _menuItem.id) {
                        menuItem['active'] = true;
                    }
                    result.push(menuItem);
                }
            }
        }
        return result;
    }

    function showBasNav() {
        var pathName = window.location.pathname;
        var menuList = getSameParentMenuList(pathName);

        if (menuList.length > 0) {
            for (var index in menuList) {
                var menuItem = menuList[index];
                if (menuItem.temp == 0 || menuItem['active']) {
                    var classHtml = '';
                    if (menuItem['active']) {
                        classHtml = 'class="active"';
                    }
                    var li = $('<li ' + classHtml + '><a href="' + ctxPath + (menuItem.url || '') + '">' + menuItem.name + '</a></li>');
                    $('#bas_nav').append(li);
                }
            }
        }
    }

    function showActiveLeftMenu(ctxPath) {
        var pathName = window.location.pathname || '';
        if (pathName.endsWith(ctxPath + '/index.action')) {
            $('#l_m_home').addClass('start active open');
            return;
        }
        var menuItem = getMenuItem(pathName);
        var tempItem = menuItem;
        while (tempItem) {
            if (tempItem.id) {
                $('#l_m_' + tempItem.id).addClass('start active open');
            }
            tempItem = tempItem.parent;
        }
    }

    $(function () {
        //setPageTitle();
    })
</script>