<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp"%>
<html>
<head>
    <title>登录</title>
    <meta name="keywords" content="登录" />
    <meta name="description" content="登录" />
    <link rel="stylesheet" type="text/css"
          href="${path}/css/css/style_common.css" />
    <link rel="stylesheet" href="${path}/css/style.css">
    <link rel="stylesheet" href="${path}/css/common_layout.css">
    <link rel="stylesheet" type="text/css"
          href="${path}/css/css/style_viewthread.css" />
    <link rel="stylesheet" type="text/css"
          href="${path}/public/css/tubiao.css" />
    <script src="${path}/public/js/jquery-1.8.2.min.js"
            type="text/javascript"></script>
    <%@ include file="/WEB-INF/jsp/inc/commonStaticResource.jsp"%>
    <script type="text/javascript">

        document.onkeydown=function(e){
            var keycode=document.all?event.keyCode:e.which;
            if(keycode==13)submitlogin();
        };

        function isusername(){
            var name=$.trim($("#name").val());
            $("#name").val(name);
            if(name==""){
                $("#namespan").html("用户不能为空");
                $("#namespan").show();
                return false;
            }else{
                $("#namespan").hide();
                return true;
            }
        }

        function isyanzhengma(){
            var flag=false;
            var yanzhengma=$.trim($("#yanzhengma").val());
            $("#yanzhengma").val(yanzhengma);
            if(yanzhengma.length<1){
                $("#yanzhengmaspan").html("验证码不能为空");
                $("#yanzhengmaspan").show();
                return flag;
            }else{
                $("#yanzhengmaspan").hide();
            }
            var param={};
            param.yanzhengma=yanzhengma;
            $.ajax({
                type: "POST",
                url: "${path}/yanzhengma/isyanzhengma.do",
                data: param,
                dataType:"json",
                async: false,
                success: function(data){
                    if(data=="0"){
                        $("#yanzhengmaspan").html("验证码错误");
                        $("#yanzhengmaspan").show();
                        // 刷新验证码
                        updateyanzhengma();
                        flag=false;
                    }else{
                        var str = '<p class="duihao"></p>';
                        $("#yanzhengmaspan").html(str);
                        $("#yanzhengmaspan").show();
                        flag=true;
                    }
                }
            });
            return flag;
        }

        function submitlogin(){
            if(isusername() && isyanzhengma()){
                var name=$.trim($("#name").val());
                var pwd=$.trim($("#pwd").val());
                var yanzhengma=$.trim($("#yanzhengma").val());
                var param={};
                param.username=name;
                param.password=pwd;
                param.yanzhengma=yanzhengma;
                param.isremember=$("#isremember").is(':checked');
                param.pathLocation='${pathLocation}';
                $.ajax({
                    type: "POST",
                    url: "${path}/login/login.do",
                    data: param,
                    dataType: "json",
                    async: false,
                    success: function(data){
                        var result=data;
                        console.log(data);
                        var pathlocation=result.data;
                        if(result.code == 0){
                            window.location.href=pathlocation;
                        }else{
                            $("#errspan").html(result.msg);
                            $("#errspan").show();
                            // 刷新验证码
                            updateyanzhengma();
                        }
                    }
                });
            }
        }

        function updateyanzhengma(){
            document.getElementById('yanzhengmaimg').src= '${path}/yanzhengma/index.do?t='+new Date().getTime();

        }
    </script>
</head>
<body class="pg_index" >
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp"%>
    </div>
    <div class="bbs_page" >
        <div class="bbs_left">
        </div>
        <div class="bbs_content">
            <div id="wp" class="wp">
                <div id="ct" class="wp ptm cl">
                    <div class="mn">
                        <div class="bm" id="main_message">
                            <p id="returnmessage4"></p>
                            <form method="post" id="form" action="">
                                <div id="layer_reg" class="bm_c">
                                    <div class="mtw">
                                        <div id="reginfo_a">
                                            <div class="rfm">
                                                <table>
                                                    <tbody>
                                                    <tr>
                                                        <th><span class="rq">*</span><label>用户名:</label></th>
                                                        <td><input type="text" name="name" id="name"
                                                                   class="px" size="25" maxlength="15" onblur="isusername();" /></td>
                                                        <td class="tipcol" colspan="3"><i id="namespan"
                                                                                          class="p_tip"></i></td>
                                                    </tr>
                                                    <tr>
                                                        <th><span class="rq">*</span><label >密码:</label></th>
                                                        <td><input type="password" class="px" id="pwd"
                                                                   size="25" maxlength="32" /></td>
                                                        <td class="tipcol" colspan="3"><i id="pwdspan"
                                                                                          class="p_tip"></i></td>
                                                    </tr>
                                                    <tr>
                                                        <th><span class="rq">*</span><label >验证码:</label></th>
                                                        <td style="height: 56px;"><input
                                                                style="width: 125px; margin-top: 0px;" type="text"
                                                                name="yanzhengma" id="yanzhengma" class="px" size="4"
                                                                maxlength="4" onblur="isyanzhengma();" /> <img
                                                                src="${path}/yanzhengma/index.do" alt="验证码" height="30px;"
                                                                id="yanzhengmaimg" onclick="updateyanzhengma();" /></td>
                                                        <td class="tipcol" colspan="3"><i id="yanzhengmaspan"
                                                                                          class="p_tip"></i></td>
                                                    </tr>
                                                    <tr style="padding-top: 0px; height: 10px;">
                                                        <th></th>
                                                        <td colspam = "4" style="padding-top: 0px;">
                                                            <i id="errspan" class="p_tip"></i>
                                                        </td>
                                                    </tr>
                                                    <%--<tr style="padding-top: 0px; height: 10px;">--%>
                                                        <%--<th></th>--%>
                                                        <%--<td><input type="checkbox" name="isremember"--%>
                                                                   <%--id="isremember" /> 记住我的登录状态</td>--%>
                                                        <%--<td class="tipcol" colspan="3"></td>--%>
                                                    <%--</tr>--%>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="layer_reginfo_b">
                                    <div class="rfmrig mbw">
								<span id="reginfo_a_btn"> <em>&nbsp;</em> <input
                                        class="btn" id="loginbtn" type="button" value="登录"
                                        onclick="submitlogin();" />
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
    </div>
    <div class="bbs_footerPush">
    </div>
</div>
<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp"%>
</div>
</body>
</html>