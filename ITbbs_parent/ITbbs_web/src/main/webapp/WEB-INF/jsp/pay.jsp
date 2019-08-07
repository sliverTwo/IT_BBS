<%@ page contentType="text/html;charset=UTF-8"  %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp"%>
<html>
<head>
    <title>Title</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp"%>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp"%>
    </div>
    <div class="bbs_page">
        <div class="bbs_left">
        </div>
        <div class="bbs_content">
            <button class="layui-btn layui-btn-normal" onclick="pay()">支付测试</button>
        </div>
        <script>
            function pay() {
                var url = "${path}/order/pay";
                window.location.href =  url;
            }
        </script>
        <div class="bbs_right">
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
