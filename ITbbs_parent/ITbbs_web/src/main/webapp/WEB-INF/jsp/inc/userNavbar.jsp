<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp"%>
<link rel="stylesheet" href="${path}/js/layui/css/layui.css">
<ul class="layui-nav  layui-bg-cyan" style="padding-left: 10%;" lay-filter="test">
    <li class="layui-nav-item " >
        <a href="javascript:;">个人信息</a>
        <dl class="layui-nav-child ">
            <dd><a href="${path}/user/index.do">基本信息</a></dd>
            <dd><a href="${path}/user/toListPage?url=changePassword">密码管理</a></dd>
        </dl>
    </li>
    <li class="layui-nav-item">
        <a href="javascript:;">帖子管理</a>
        <dl class="layui-nav-child">
            <dd><a href="${path}/post/toAddPost.do">新建帖子</a></dd>
            <dd><a href="${path}/user/toListPage?url=postManage/list">我的帖子</a></dd>
            <dd><a href="${path}/user/toListPage?url=postManage/favorite">收藏的帖子</a></dd>
        </dl>
    </li>
    <li class="layui-nav-item">
        <a href="javascript:;">问答管理</a>
        <dl class="layui-nav-child">
            <dd><a href="${path}/question/toAddQuestion.do">我要提问</a></dd>
            <dd><a href="${path}/user/toListPage?url=answerQuestionManage/questionList">我的问题</a></dd>
            <dd><a href="${path}/user/toListPage?url=answerQuestionManage/answerList">回答过的问题</a></dd>
        </dl>
    </li>
    <li class="layui-nav-item">
        <a href="javascript:;">下载管理</a>
        <dl class="layui-nav-child">
            <dd><a href="${path}/file/toUploadFile">上传文件</a></dd>
            <dd><a href="${path}/user/toListPage?url=file/myUpload">我的上传</a></dd>
            <%--<dd><a href="${path}/index.do?url=user/file/myDownload">我的下载</a></dd>--%>
        </dl>
    </li>
    <li class="layui-nav-item">
        <a href="javascript:;">积分管理</a>
        <dl class="layui-nav-child">
            <dd><a href="${path}/order/toRecharge">积分充值</a></dd>
            <dd><a href="${path}/user/toListPage?url=scoreManage/scoreLog">消费记录</a></dd>
        </dl>
    </li>
    <li class="layui-nav-item">
        <a href="${path}/user/toListPage?url=messageManage/message">我的消息<span class="messageNum"></span></a>
    </li>

    <c:if test="${logUser.postNum > 33 && logUser.level == 0}">
        <li class="layui-nav-item">
            <a href="${path}/user/toApplyBoarder.do">申请版主</a>
        </li>
    </c:if>
    <c:if test="${logUser.level == 1}">
        <li class="layui-nav-item">
            <a href="${path}/user/toBoardManage">版块管理</a>
        </li>
    </c:if>
</ul>

<script>
    //一般直接写在一个js文件中
    //
    // layui.use('element', function(){
    //     var ele = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
    //
    //     //监听导航点击
    //     ele.on('nav(d)', function(elem){
    //         //console.log(elem)
    //         layer.msg(elem.text());
    //     });
    // });
</script>
