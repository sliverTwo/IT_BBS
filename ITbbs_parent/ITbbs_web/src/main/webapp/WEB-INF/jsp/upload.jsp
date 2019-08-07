<%--
  Created by IntelliJ IDEA.
  User: LIN
  Date: 2018-03-19
  Time: 19:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp"%>
    <title>upload模块快速使用</title>
</head>
<body>

<button type="button" class="layui-btn" id="test1">
    <i class="layui-icon">&#xe67c;</i>上传图片
</button>

<script>
    layui.use('upload', function(){
        var upload = layui.upload;

        //执行实例
        var uploadinst = upload.render({
            elem: '#test1' //绑定元素
            ,url: '${path}/upload/uploadfile.do' //上传接口
            ,done: function(res){
                //上传完毕回调
                console.log(res);
            }
            ,error: function(res){
                //请求异常回调
                alert("error");
            }
        });
    });
</script>
</body>
</html>
