<#macro check_icon icons>
<script>
    $(function () {
        $('.bs-glyphicons li').click(function () {
            var thisDom = $(this);
            $('.bs-glyphicons li').removeClass("check");
            $('.bs-glyphicons li').addClass("no-check");
            thisDom.addClass("check");
            $('.bs-glyphicons li').find('.fa-check-circle-o').removeClass('fa-check-circle-o').addClass('fa-circle-o');
            thisDom.find('.fa-circle-o').removeClass('fa-circle-o').addClass('fa-check-circle-o');
            if (iconClickCallBack) {
                iconClickCallBack(thisDom.attr('icon-name'));
            }
        })

        if (typeof initIconByIndex != 'undefined' &&　typeof initIconByIndex == 'function') {
            initIconByIndex(checkIconByIndex);
        }
        if (typeof initIconByName != 'undefined' &&　typeof initIconByName == 'function') {
            initIconByName(checkIconByName);
        }
    })

    function checkIconByIndex(idx) {
        var liDom = $('.bs-glyphicons li');
        if (liDom.length > 0) {

            var iconName = '';
            liDom.each(function (index) {
                var thisDom = $(this);
                if (idx == index) {
                    thisDom.removeClass("no-check");
                    thisDom.addClass("check");
                    thisDom.find('.fa-circle-o').removeClass('fa-circle-o').addClass('fa-check-circle-o');
                    iconName = thisDom.attr('icon-name');
                }
            })

            return iconName;
        }
        return '';
    }

    function checkIconByName(name) {
        var liDom = $('.bs-glyphicons li');
        if (liDom.length > 0) {

            liDom.each(function () {
                var thisDom = $(this);
                var iconName = thisDom.attr('icon-name');
                if (name == iconName) {
                    thisDom.removeClass("no-check");
                    thisDom.addClass("check");
                    thisDom.find('.fa-circle-o').removeClass('fa-circle-o').addClass('fa-check-circle-o');
                    return false;
                }
            })
        }
        return name;
    }
</script>
<div class="bs-glyphicons">
    <ul class="bs-glyphicons-list">
        <#if icons?? && icons?size gt 0>
            <#list icons as icon>
                <li class="no-check" icon-name="${icon.name!''}" ischeck="checked">
                    <span class="glyphicon" aria-hidden="true">
                        <i class="fa ${icon.name!''}"></i>
                    </span>
                    <span class="glyphicon-class">
                        <i class="fa fa-circle-o"></i>
                    </span>
                </li>
            </#list>
        </#if>
    </ul>
</div>
</#macro>