<%@ page pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<link rel="stylesheet" href="${path}/js/layui/css/layui.css">

<div>
    <ul class="layui-nav layui-bg-green" lay-filter="">
        <li style="position: relative;display: inline-block;vertical-align: middle;line-height: 60px;">
            <i class="layui-icon "><img src="${path}/images/logo.jpg" alt=""></i>
        </li>
        <li class="layui-nav-item ">
            <a href="${path}/index.do">首页</a>
        </li>
        <li class="layui-nav-item"><a href="${path}/toBoardUI.do">论坛</a></li>
        <li class="layui-nav-item "><a href="${path}/toQuestionList.do">问答
        </a></li>
        <li class="layui-nav-item"><a href="${path}/toFileList.do">下载</a></li>
        <div style="float: right;padding-right: 15px;">
            <c:if test="${not empty logUser}">
                <li class="layui-nav-item" lay-unselect="">
                    <a href="javascript:;"><img src="${logUser.pic}" class="layui-nav-img">${logUser.username}</a>
                    <dl class="layui-nav-child layui-anim layui-anim-upbit">
                        <c:if test="${logUser.level != 2}">
                            <dd><a href="${path}/user/index.do">个人中心</a></dd>
                        </c:if>
                        <c:if test="${logUser.level == 2}">
                            <dd><a href="${path}/user/admin.do">后台管理</a></dd>
                        </c:if>
                        <dd><a href="${path}/login/logout.do">安全退出</a></dd>
                    </dl>
                </li>
                <c:if test="${logUser.level != 2}">
                    <li class="layui-nav-item">
                        <!-- <a href="">消息<span class="layui-badge-dot"></span></a> -->
                        <a href="${path}/user/toListPage?url=messageManage/message"><i class="fa fa-envelope-o"
                                                                                       style="font-size:24px"></i><span
                                class="messageNum"></span></a>
                    </li>
                </c:if>
            </c:if>
            <c:if test="${empty logUser}">
                <li class="layui-nav-item">
                    <!-- <a href="">消息<span class="layui-badge-dot"></span></a> -->
                    <a href="javascript:;" onclick="toLogin()">登陆</a>
                </li>
                <script>
                    function toLogin() {
                        window.location.href = "${path}/login/toLogin.do?pathLocation" + window.location.href;
                    }
                </script>
                <li class="layui-nav-item">
                    <!-- <a href="">消息<span class="layui-badge-dot"></span></a> -->
                    <a href="${path}/register/toRegister.do">注册</a>
                </li>
            </c:if>
        </div>
    </ul>
    <div style=" position: absolute;left: 40%;top: 12px;">
        <input type="text" style="display: inline;width: 300px;" class="layui-input" id="keyword"
               placeholder="输入帖子关键字..." value="${keyword }">
        <button style="background: #FF5722;" class="layui-btn" onclick="searchPost()">搜索帖子</button>
    </div>
</div>

<a id="toMail" href="mailto:${adminMail}" style="display: none;">Email</a>
<script src="${path}/js/layui/layui.js"></script>
<script>
    $(function () {
        <c:if test="${not empty logUser}">
        // 获取维度消息数
        countUnreadMessage();
        </c:if>
    });

    function countUnreadMessage() {
        $.post('${path}/message/countNotReadMessage.do', {}, function (result) {
            if (result.code == 0) {
                if (result.data > 0) {
                    $('.messageNum').text(result.data);
                    $('.messageNum').addClass('layui-badge');
                } else {
                    $('.messageNum').text("");
                    $('.messageNum').removeClass('layui-badge');
                }
            }
        }, 'json');
    }

    //一般直接写在一个js文件中
    layui.use('element', function () {
        var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块

        //监听导航点击
        element.on('nav(demo)', function (elem) {
            //console.log(elem)
            layer.msg(elem.text());
        });
    });
    layui.use('util', function () {
        var util = layui.util;

        //执行toMail
        util.fixbar({
            bar1: true,
            click: function (type) {
                console.log(type);
                if (type === 'bar1') {
                    // document.body.scrollTop = document.documentElement.scrollTop = 0;
                    document.getElementById('').click();
                }
            }
        });
    });

    function searchPost() {
        var keyword = $("#keyword").val();
        if ($.trim(keyword).length > 0) {
            // 搜索
            param = {keyword: keyword};
            httpPost("${path}/post/toSearchList.do", param);
        }
    }

    //发送POST请求跳转到指定页面
    function httpPost(URL, param) {
        var temp = document.createElement("form");
        temp.action = URL;
        temp.method = "post";
        temp.style.display = "none";
        temp.acceptCharset = "UTF-8";
        for (var x in param) {
            var opt = document.createElement("textarea");
            opt.name = x;
            opt.value = param[x];
            temp.appendChild(opt);
        }

        document.body.appendChild(temp);
        temp.submit();

        return temp;
    }
</script>
