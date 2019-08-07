<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp"%>
    <title>注册</title>
    <meta name="keywords" content="注册" />
    <meta name="description" content="注册" />
    <link rel="stylesheet" type="text/css"
          href="${path}/css/css/style_common.css" />
    <link rel="stylesheet" type="text/css"
          href="${path}/css/css/style_viewthread.css" />
    <link rel="stylesheet" type="text/css"
          href="${path}/public/css/tubiao.css" />
    <link rel="stylesheet" type="text/css"
          href="${path}/css/common_layout.css" />
</head>
<body id="nv_forum" class="pg_index">
<div class="bbs_container">
    <div id="header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp"%>
    </div>
    <div class="bbs_page">
        <div class="bbs_left">
        </div>
        <div class="bbs_content">
            <div class="y"></div>
            <div class="y qing_toptb"></div>
            <div id="wp" class="wp">
                <div id="ct" class="wp ptm cl">
                    <div class="mn">
                        <div class="bm" id="main_message">
                            <p id="returnmessage4"></p>
                            <form method="post" id="form" onsubmit="submitzhuc()">
                                <div id="layer_reg" class="bm_c">
                                    <div class="mtw">
                                        <div id="reginfo_a">
                                            <div class="rfm">
                                                <table>
                                                    <tbody>
                                                    <tr>
                                                        <th><span class="rq">*</span><label for="ZODRdi">用户名:</label></th>
                                                        <td><input type="text" name="loginname" id="name"
                                                                   class="px" size="25" maxlength="15" onblur="isusername();" /></td>
                                                        <td class="tipcol" colspan="3"><i id="namespan"
                                                                                          class="p_tip"></i></td>
                                                    </tr>
                                                    <tr>
                                                        <th><span class="rq">*</span><label for="ZODRdi">密码:</label></th>
                                                        <td><input type="password" class="px" id="pwd"
                                                                   size="25" maxlength="15" onblur="ispwd();" /></td>
                                                        <td class="tipcol" colspan="3"><i id="pwdspan"
                                                                                          class="p_tip"></i></td>
                                                    </tr>
                                                    <tr>
                                                        <th><span class="rq">*</span><label for="ZODRdi">确认密码:</label></th>
                                                        <td><input type="password" name="pwd" id="qpwd"
                                                                   class="px" size="25" maxlength="15" onblur="isqpwd();" /></td>
                                                        <td class="tipcol" colspan="3"><i id="qpwdspan"
                                                                                          class="p_tip"></i></td>
                                                    </tr>
                                                    <tr>
                                                        <th><span class="rq">*</span><label for="ZODRdi">邮箱:</label></th>
                                                        <td><input type="text" name="mail" id="mail"
                                                                   class="px" size="25" maxlength="50" onblur="checkEmail()" /></td>
                                                        <td class="tipcol" colspan="3">
                                                            <input id="btnSendCode" type="button" style="height: 30px;" class="layui-btn layui-btn-normal"  value="发送验证码" onclick="sendMessage()" />
                                                            <i id="emailspan" class="p_tip"></i>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th><span class="rq">*</span><label >验证码:</label></th>
                                                        <td style="height: 56px;"><input
                                                                style="width: 125px; " type="text"
                                                                name="ackCode" id="ackCode" class="px" size="4"
                                                                maxlength="5"  /></td>
                                                        <td class="tipcol" colspan="3">
                                                            <i id="ackCodespan" class="p_tip"></i>
                                                        </td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="layer_reginfo_b">
                                    <div class="rfmrig mbw">
                                    <span id="reginfo_a_btn"> <em>&nbsp;</em> <input
                                            class="btn" type="button" id="zhucbut" value="立即注册"
                                            onclick="submitzhuc();" />
                                    </span>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="bbs_right">
        </div>
        <div class="bbs_footerPush">
        </div>
    </div>
</div>
<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp"%>
</div>


<script type="text/javascript">
    $(function(){
        $("#btnSendCode").hide();
    });
    document.onkeydown = function(e) {
        var keycode = document.all ? event.keyCode : e.which;
        if (keycode == 13)
            submitzhuc();
    };
    function isusername() {
        var flag = false;
        var name = $.trim($("#name").val());
        $("#name").val(name);
        if (name.length < 3) {
            $("#namespan").html("用户长度不能小于3位");
            $("#namespan").show();
            return flag;
        } else {
            $("#namespan").hide();
        }
        var param = {};
        param.username = name;
        $.ajax({
            type : "POST",
            url : "${path}/register/checkUsername.do",
            data : param,
            dataType : "json",
            async : true,
            success : function(data) {
                if (data.code != 0) {
                    $("#namespan").html("用户名重复");
                    $("#namespan").show();
                    $("#zhucbut").attr("disabled",true);
                    flag = false;
                } else {
                    $("#namespan").html('<p class="duihao"></p>');
                    $("#namespan").show();
                    $("#zhucbut").attr("disabled",false);
                    flag = true;
                }
            }
        });
        return flag;
    }
    function isAckCode() {
        var flag = false;
        var ackCode = $.trim($("#ackCode").val());
        $("#ackCode").val(ackCode);
        if (ackCode.length < 1) {
            $("#ackCodespan").html("验证码不能为空");
            $("#ackCodespan").show();
            return flag;
        } else {
            $("#ackCodespan").hide();
        }
        var param = {};
        param.ackCode = ackCode;
        $.ajax({
            type : "POST",
            url : "${path}/register/ackCode.do",
            data : param,
            dataType : "json",
            async : false,
            success : function(data) {
                if (data.code == 0) {
                    $("#ackCodespan").html('<p class="duihao"></p>');
                    $("#ackCodespan").show();
                    $("#zhucbut").attr("disabled",false);
                    flag = true;

                } else {
                    $("#ackCodespan").html(data.msg);
                    $("#ackCodespan").show();
                    $("#zhucbut").attr("disabled",true);
                    flag = false;
                }
            }
        });
        return flag;
    }
    function ispwd() {
        var pwd = $.trim($("#pwd").val());
        $("#pwd").val(pwd);
        if (pwd.length < 6) {
            $("#pwdspan").html("密码长度不能小于6位");
            $("#pwdspan").show();
            return false;
        } else {
            $("#pwdspan").html('<p class="duihao"></p>');
            $("#pwdspan").show();
            return true;
        }
    }

    function isqpwd() {
        var pwd = $.trim($("#pwd").val());
        var qpwd = $.trim($("#qpwd").val());
        if (pwd != qpwd) {
            $("#qpwdspan").html("两次密码不一致");
            $("#qpwdspan").show();
            return false;
        } else {
            $("#qpwdspan").html('<p class="duihao"></p>');
            $("#qpwdspan").show();
            return true;
        }
    }

    function submitzhuc() {
        if (ispwd() && isqpwd() && isAckCode()) {
            var param = {};
            param.username = $.trim($("#name").val());
            param.password = $.trim($("#qpwd").val());
            param.mail = $.trim($("#mail").val());
            param.code = $.trim($("#ackCode").val());
            $.ajax({
                type : "POST",
                url : "${path}/register/register.do",
                data : param,
                dataType : "json",
                async : false,
                success : function(data) {
                    var msg = data.msg;
                    if (data.code == 0) {
                        alert("注册成功！");
                        // 跳转到登陆界面
                        window.location.href = '${path}/login/toLogin.do';
                    } else {
                        alert(msg);
                    }
                }
            });
        }
    }

    function updateackCode() {
        document.getElementById('ackCodeimg').src = '${path}/ackCode/index.do?t='
            + new Date().getTime();

    }
</script>
<!-- 发送验证码代码 -->
<script>
    var InterValObj; //timer变量，控制时间
    var count = 30; //间隔函数，1秒执行
    var curCount;//当前剩余秒数
    function isEmail(strEmail) {
        //声明邮箱正则
        var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
        if(!myreg.test(strEmail))//对输入的值进行判断
        {
            $("#emailspan").html('<p">请输入有效的Email！</p>');
            $("#emailspan").show();
            $("#email").focus();
            return false;
        }
        return true;
    }
    function checkEmail() {
        var flag = false;
        var mail = $.trim($("#mail").val());
        $("#btnSendCode").hide();
        $("#mail").val(mail);
        if(!isEmail(mail)){
            return false;
        } else {
            $("#emailspan").hide();
        }
        var param = {};
        param.mail = mail;
        $.ajax({
            type : "POST",
            url : "${path}/register/checkMail.do",
            data : param,
            dataType : "json",
            async : false,
            success : function(data) {
                if (data.code == 0) {
                    // alert("该邮箱已被注册");
                    $("#btnSendCode").show();
                    flag = true;
                } else {
                    $("#emailspan").html("<p>该邮箱已被注册！</p>");
                    $("#emailspan").show();
                    flag = false;
                }
            }
        });
        return flag;
    }
    function sendMessage() {
        var param = {};
        param.mail = $.trim($("#mail").val());
        curCount = count; //设置button效果，开始计时
        $("#btnSendCode").attr("disabled", "true");
        $("#btnSendCode").val(curCount + "秒后可重新发送");
        InterValObj = window.setInterval(SetRemainTime, 1000); //启动计时器，1秒执行一次
        //请求后台发送验证码 TODO
        $.ajax({
            type : "POST",
            url : "${path}/register/sendAckCode.do",
            data : param,
            dataType : "json",
            async : false,
            success : function(data) {
                // var status = data.status;
                // var msg = data.msg;
                if (data.code == 0) {
                    console.log("邮件发送成功！");
                } else {
                    alert(data.msg);
                }
            }
        });
    }

    //timer处理函数
    function SetRemainTime() {
        if (curCount == 0) {
            window.clearInterval(InterValObj);//停止计时器
            $("#btnSendCode").removeAttr("disabled");//启用按钮
            $("#btnSendCode").val("重新发送验证码");
        }
        else {
            curCount--;
            $("#btnSendCode").val(curCount + "秒后可重新发送");
        }
    }
</script>
</body>
</html>