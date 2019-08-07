<%@ page pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>${userName}的个人信息</title>

    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp" %>
    <style>
        body {
            background: url(${path}/images/bg-yellow.png) repeat;
            /*background: #e9e9e9;*/
        }
        .name_font {
            letter-spacing: 3px;
            text-align: left;
        }

        .content {
            width: 666px;
            margin-top: 3%;
            margin-left: 25%;
        }
    </style>
</head>
<body>
<div class="bbs_container">
    <div class="header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp" %>
    </div>
    <c:if test="${not empty user}">
        <div class="content">
        <%--基本信息--%>
        <div style="float: left; width:50%; margin-left: 13%;">
            <table style="width: 100%; line-height: 30px;font-size: 16px;">
                <tr>
                    <td class="name_font">用户名</td>
                    <td></td>
                    <td>${user.username}
                    </td>
                </tr>
                <tr>
                    <td class="name_font">邮&nbsp;箱</td>
                    <td></td>
                    <td>${user.mail}</td>
                </tr>
                <tr>
                    <td class="name_font">姓&nbsp;名</td>
                    <td></td>
                    <td>${user.name}</td>
                </tr>
                <tr>
                    <td class="name_font">性&nbsp;别</td>
                    <td></td>
                    <td>${user.gender}</td>
                </tr>
                <tr>
                    <td class="name_font">生&nbsp;日</td>
                    <td></td>
                    <td>${user.birthday}</td>
                </tr>
                <tr>
                    <td class="name_font">Q&nbsp;Q</td>
                    <td></td>
                    <td>${user.qq}</td>
                </tr>
                <tr>
                    <td class="name_font">微&nbsp;信</td>
                    <td></td>
                    <td>${user.wechat}</td>
                </tr>
            </table>
        </div>
        <%--头像--%>
        <div style="float: right; text-align: center; margin-right: 13%;">
            <div>
                <img id="headPic" src="${user.pic}" alt="" style="width: 150px;height: 180px;">
            </div>
        </div>
        <%--统计信息--%>
        <div>
            <hr class="layui-bg-orange">
            <table width="100%" style="line-height: 24pt;text-align: center;" border="1">
                <tr>
                    <td>发帖数目</td>
                    <td>提问数</td>
                    <td>积分</td>
                </tr>
                <tr>
                    <td>${user.postNum}</td>
                    <td>${user.questionNum}</td>
                    <td>${user.score}</td>
                </tr>
            </table>
        </div>
        <hr class="layui-bg-green">
        <%--个人简述--%>
        <div>
            <p style="font-size: 20px; letter-spacing: 5px;">个人简述</p>
            <textarea name="" placeholder="这家伙很懒，什么都没填写！"
                      class="layui-textarea" style="background: beige;" readonly>${user.note}</textarea>
        </div>
    </div>
    </c:if>
    <c:if test="${empty user}">
        <script>
            $(function () {
                alert("${msg}");
                window.history.go(-1);
            })
        </script>
    </c:if>
    <div class="bbs_footerPush"></div>
</div>
<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp" %>
</div>
</body>
</html>