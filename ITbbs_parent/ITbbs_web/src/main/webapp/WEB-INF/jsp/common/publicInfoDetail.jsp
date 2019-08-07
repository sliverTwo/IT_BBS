<%@ page contentType="text/html;charset=UTF-8"  %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp"%>
<html>
<head>
    <title>公告详情</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp"%>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp"%>
    </div>
    <div class="bbs_page">
        <div class="bbs_content" style="width:80%;margin-left: 10%;margin-top: 20px;">
            <h1 style="text-align: center">${publicInfo.title}</h1>
            <hr class="layui-bg-blue">
            <div style="text-indent:2em;min-height: 50%;">
                ${publicInfo.content}
            </div>
            <div style="text-align: right;font-size: 16px;">
                发布于  <fmt:formatDate value="${publicInfo.createtime}" pattern="yyyy/MM/dd HH:mm:ss"/>
            </div>
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
