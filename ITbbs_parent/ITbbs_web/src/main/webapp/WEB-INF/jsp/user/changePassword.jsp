<%@ page contentType="text/html;charset=UTF-8"  %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp"%>
<html>
<head>
    <title>密码修改</title>
    <%@ include file="/WEB-INF/jsp/inc/commonStaticResource.jsp"%>
</head>
<body>
<div class="bbs_container" >
    <div class="header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp"%>
        <c:if test="${logUser.level != 2}">
            <%@include file="/WEB-INF/jsp/inc/userNavbar.jsp"%>
        </c:if>
    </div>
    <div>
        <c:if test="${logUser.level == 2}">
            <div style="float: left;margin: 0;padding: 0;">
                <%@include file="/WEB-INF/jsp/inc/adminNavbar.jsp"%>
            </div>
        </c:if>
        <c:if test="${logUser.level == 2}">
            <div style="margin: 50px 20%; float: left;">
        </c:if>
        <c:if test="${logUser.level != 2}">
            <div style="margin: 50px 35%;">
        </c:if>
            <form class="layui-form" action="">
                <div class="layui-form-item">
                    <label class="layui-form-label">原密码</label>
                    <div class="layui-input-inline">
                        <input type="password" name="oldPassword"  lay-verify="required|oldPassword" placeholder="请输入原密码"
                               autocomplete="off" class="layui-input">
                    </div>
                    <%--<div class="layui-form-mid layui-word-aux">辅助文字</div>--%>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">新密码</label>
                    <div class="layui-input-inline">
                        <input type="password" id="newPassword" name="newPassword" required lay-verify="required|newPassword"
                               placeholder="请输入新密码"
                               autocomplete="off" class="layui-input">
                    </div>
                    <%--<div class="layui-form-mid layui-word-aux">辅助文字</div>--%>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">确认新密码</label>
                    <div class="layui-input-inline">
                        <input type="password" name="ackPassword" required lay-verify="required|ackPassword"
                               placeholder="再次输入密码"
                               autocomplete="off" class="layui-input">
                    </div>
                    <%--<div class="layui-form-mid layui-word-aux">辅助文字</div>--%>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit lay-filter="formDemo">修改</button>
                        <button id="toIndex" class="layui-btn layui-btn-primary" >返回</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="bbs_footerPush">
    </div>

    <script>
        layui.use('form', function(){
            var form = layui.form;
            form.verify({
                "oldPassword":function(value,item){
                    var param = {oldPassword:$.trim(value)};
                    var flag = true;
                    $.ajax({
                        type: "POST",
                        url: "${path}/user/ackOldPassword.do",
                        data: param,
                        dataType: "json",
                        async: false,
                        success: function(data){
                            var result=data;
                            if(result.code != 0){
                                flag = false
                            }
                        }
                    });
                    if(!flag){
                        return "原密码错误";
                    }
                }
                ,newPassword:[
                    /^[\S]{6,16}$/,
                    "密码必须是6到16位，且不能出现空格"
                ]
                ,"ackPassword":function (value,item) {
                    if(value != $("#newPassword").val()){
                        return "两次密码输入不一致！"
                    }
                }
            })

            //监听提交
            form.on('submit(formDemo)', function(data){
                $.ajax({
                    type: "POST",
                    url: "${path}/user/changePassword.do",
                    data: data.field,
                    dataType: "json",
                    async: false,
                    success: function(data){
                        var result=data;
                        if(result.code == 0){
                            layer.msg("密码修改成功!,3秒后跳转至个人信息主页");
                            window.setTimeout(function(){
                                window.location.href="${path}/user/index.do";
                            },3000)
                        }else{
                            layer.msg(result.msg);
                        }
                    }
                });
                return false;
            });
        });
        $("#toIndex").click(function () {
            window.location.href = "${path}/user/index.do";
        });
    </script>
</div>
<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp"%>
</div>
</body>
</html>
