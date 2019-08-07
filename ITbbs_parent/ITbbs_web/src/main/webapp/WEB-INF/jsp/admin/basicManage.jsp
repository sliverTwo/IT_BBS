<%@ page contentType="text/html;charset=UTF-8"  %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp"%>
<html>
<head>
    <title>基础设置</title>
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
    <div style="text-align: center;margin: 5% 0% 0 5%;float: left;width: 70%;height: 70%;">
        <div class="layui-form-item">
            <label class="layui-form-label">管理员邮箱</label>
            <div class="layui-input-inline">
                <input type="text" id="mail" name="adminMail"  autocomplete="off"
                       class="layui-input" value="${adminMail}">
            </div>
            <div class="layui-word-aux" style="float: left;line-height: 20px;margin-right: 10px;">
                <button class="layui-btn layui-btn-normal" onclick="alterMail()">修改邮箱</button>
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">敏感字符</label>
            <div class="layui-input-block">
                <textarea id="filterString" name="filterString"  placeholder="使用|分隔" class="layui-textarea"
                          style="height: 200px;">${filterString}</textarea>
            </div>
            <div style="margin-top: 20px;">
                <button class="layui-btn layui-btn-normal" onclick="alterFilterString()">修改过滤字符</button>
            </div>
        </div>
    </div>
</div>
<div class="bbs_footerPush">
</div>
</div>
<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp"%>
</div>
<script>
    var layer;
    layui.use('layer',function () {
        layer = layui.layer;


    });
    function alterMail() {
        if(!checkMail()){
            return false;
        }
        var email = $("#mail").val();
        $.post("${path}/basicSet/alterAdminMail",{adminMail:email},function (result) {
            if(result&&result.code == 0) {
                layer.msg("修改成功！", {icon: 1});
                window.location.reload();
            }else {
                layer.msg("修改失败！");
            }
        },"json");
    }
    function alterFilterString() {
        var filterString = $("#filterString").val();
        console.log(filterString);
        $.post("${path}/basicSet/alterFilterString",{filterString:filterString},function (result) {
            if(result.code == 0) {
                layer.msg("修改成功！", {icon: 1});
                window.location.reload();
            }else {
                layer.msg(result.msg);
            }
        },"json");
    }
    function checkMail(){
        var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$"); //正则表达式
        var obj = document.getElementById("mail"); //要验证的对象
        if(obj.value === ""){ //输入不能为空
            layer.msg("输入不能为空!");
            return false;
        }else if(!reg.test(obj.value)){ //正则验证不通过，格式不对
            layer.msg("请输入正确的邮箱！");
            return false;
        }else{
            return true;
        }
    }
</script>
</body>
</html>
