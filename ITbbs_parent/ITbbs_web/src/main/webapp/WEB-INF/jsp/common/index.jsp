<%@ page contentType="text/html;charset=UTF-8"  %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp"%>
<html>
<head>
    <title>主页</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp"%>
    <style>
        .title{
            font-size: 18px;
            padding: 0 18px;
            background: #DCE9F8;
            color: #333;
            line-height: 28px;
        }
        .line-limit-length {
            text-indent: 2em;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            font-size: 16px;
            line-height: normal;
        }
    </style>
</head>
<body>
<div class="bbs_container" >
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp"%>
    </div>
    <div class="bbs_page">
        <%--最近热门--%>
        <div class="title">公告栏<a href="${path}/toPublicInfoList" style="text-align: right; float: right">更多>></a></div>
        <div style="height: 120px;">
            <%--公共信息--%>
            <c:forEach items="${publicInfoList}" var="p">
                <p class="line-limit-length" >
                    <a href="${path}/publicInfo/toPublicInfo.do?publicInfoId=${p.id}">${p.title}</a>
                </p>
            </c:forEach>

                <%--<br><p class="line-limit-length">--%>
                    <%--最新消息：神秘地球黑洞深不可测，不停吸入周围海水。最新消息：神秘地球黑洞深不可测，不停吸入周围海水。最新消息：神秘地球黑洞深不可测，不停吸入周围海水。--%>
            <%--</p>--%>
                <%--<br><p class="line-limit-length">--%>
                    <%--最新消息：神秘地球黑洞深不可测，不停吸入周围海水。最新消息：神秘地球黑洞深不可测，不停吸入周围海水。最新消息：神秘地球黑洞深不可测，不停吸入周围海水。--%>
            <%--</p>--%>
        </div>
            <%--版块信息--%>
        <h4 class="title">版块</h4>
        <div>
            <%--java--%>
            <c:forEach var="b" items="${boardList}">
                <div style="float: left;width: 18%; margin-right: 3%; padding: 1%; height: 180px;">
                    <a href="${path}/toBoardUI.do?boardId=${b.id}">
                    <div style="text-align: center" title="${b.introduce}">
                        <img src="${b.pic}" width="100px" height="100px">
                        <br>
                        <span style="font-size: 24px;">${b.boardName}</span>
                    </div>
                    </a>
                    <%--<div class="line-limit-length" >--%>
                        <%--${b.introduce}--%>
                    <%--</div>--%>
                </div>
            </c:forEach>

        </div>
    </div>
    <div class="bbs_footerPush">
    </div>
</div>
<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp"%>
</div>
</body>
</html>
