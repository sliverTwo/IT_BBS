<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp"%>
<html>
<head>
    <title>积分充值成功提醒</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp"%>
    <script>
        layui.use("layer",function(){
            var layer = layui.layer;
            var code = ${result.code};
            if(code == 0){
                layer.alert("充值成功",{icon:1},function () {
                        var url = '${path}/user/index.do';
                        window.location.href = url;
                    }
                );
            }else{
                layer.alert('${result.msg}',{icon:2},function () {
                        var url = '${path}/user/index.do';
                        window.location.href = url;
                    }
                )
            }

        })
    </script>
</head>
<body>
</body>
</html>
