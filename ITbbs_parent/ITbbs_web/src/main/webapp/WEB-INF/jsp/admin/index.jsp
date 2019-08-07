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
        <div class="bbs_left">
            <%@include file="/WEB-INF/jsp/inc/adminNavbar.jsp"%>
        </div>
        <div style="text-align: center;margin: 5% 0% 0 40%;">
            <table width="350px;">
                <tr>
                    <td>注册用户数</td>
                    <td>666</td>
                </tr>
                <tr>
                    <td>冻结用户</td>
                    <td>6</td>
                </tr>
                <tr>
                    <td>版块数</td>
                    <td>6</td>
                </tr>
                <tr>
                    <td>版主</td>
                    <td>6</td>
                </tr>
            </table>
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
