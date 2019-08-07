<%@ page pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>个人信息管理页</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp" %>
    <style>
        body {
            background: url(${path}/images/bg-yellow.png) repeat;
            /*background: #e9e9e9;*/
        }

        .name_font {
            letter-spacing: 3px;
            text-align: left;
        }

        .content {
            width: 666px;
            margin-top: 20px;
            margin-left: 25%;
        }
    </style>
</head>
<body>
<div class="bbs_container">
    <div class="header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp" %>
        <%@include file="/WEB-INF/jsp/inc/userNavbar.jsp" %>
    </div>
    <div class="content">
        <%--基本信息--%>
        <div style="float: left; width:50%; margin-left: 13%;">
            <table style="width: 100%; line-height: 30px;font-size: 16px;">
                <tr>
                    <td class="name_font">用户名</td>
                    <td></td>
                    <td>${logUser.username}
                        <a href="javascript:;" onclick="toChangePage()">
                            <i class="layui-icon" style="font-size: 24px;">&#xe642;</i>
                        </a>
                    </td>
                </tr>
                <tr>
                    <td class="name_font">邮&nbsp;箱</td>
                    <td></td>
                    <td>${logUser.mail}</td>
                </tr>
                <tr>
                    <td class="name_font">姓&nbsp;名</td>
                    <td></td>
                    <td>${logUser.name}</td>
                </tr>
                <tr>
                    <td class="name_font">性&nbsp;别</td>
                    <td></td>
                    <td>${logUser.gender}</td>
                </tr>
                <tr>
                    <td class="name_font">生&nbsp;日</td>
                    <td></td>
                    <td>${logUser.birthday}</td>
                </tr>
                <tr>
                    <td class="name_font">Q&nbsp;Q</td>
                    <td></td>
                    <td>${logUser.qq}</td>
                </tr>
                <tr>
                    <td class="name_font">微&nbsp;信</td>
                    <td></td>
                    <td>${logUser.wechat}</td>
                </tr>
            </table>
        </div>
        <%--头像--%>
        <div style="float: right; text-align: center; margin-right: 13%;">
            <div>
                <img id="headPic" src="${logUser.pic}" alt="" style="width: 150px;height: 180px;">
            </div>
                <i id="alterPicBtn" class="layui-icon" style="font-size: 24px;">&#xe642;</i>

            <script>
                layui.use('upload', function(){
                    var upload = layui.upload;
                    //执行实例
                    var uploadInst = upload.render({
                        elem: '#alterPicBtn' //绑定元素
                        ,url: '${path}/upload/uploadImg.do' //上传接口
                        ,done: function(res){
                            //上传完毕回调
                            console.log(res);
                            var src = res.data.src
                            var param = {"pic":src,"id":${logUser.id}};
                            $.ajax({
                                type: "POST",
                                url: "${path}/user/changeUserPic.do",
                                data: param,
                                dataType: "json",
                                async: true,
                                success: function(data){
                                    var result=data;
                                    if(result.code == 0){
                                        $("#headPic").prop('src',src);
                                        <%--window.location.href="${path}/user/index.do";--%>
                                    }else{
                                        layer.msg(result.msg);
                                        window.location.reload();
                                    }
                                }
                            });
                        }
                        ,error: function(res){
                            //请求异常回调
                            // alert("error");
                            return res.msg;
                        }
                    });
                });
            </script>

        </div>
        <%--统计信息--%>
        <div>
            <hr class="layui-bg-orange">
            <table width="100%" style="line-height: 24pt;text-align: center;" border="1">
                <tr>
                    <td>发帖数目</td>
                    <td>提问数</td>
                    <td>积分</td>
                </tr>
                <tr>
                    <td>${logUser.postNum}</td>
                    <td>${logUser.questionNum}</td>
                    <td>${logUser.score}</td>
                </tr>
            </table>
        </div>
        <hr class="layui-bg-green">
        <%--个人简述--%>
        <div>
            <p style="font-size: 20px; letter-spacing: 5px;">个人简述</p>
            <textarea name="" placeholder="请输入自我描述信息"
                      class="layui-textarea" readonly>${logUser.note}</textarea>
        </div>
    </div>
    <div class="bbs_footerPush"></div>
</div>
<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp" %>
</div>
</body>
<%--修改页面--%>
<div id="alterInfoPage" style="display: none; margin-left: 15%; margin-top: 20px;">
    <form class="layui-form" action="">
        <div class="layui-form-item">
                <input type="text" name="id" autocomplete="off" class="layui-input"
                       style="width: 200px; display: none;" value="${logUser.id}">
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-block">
                <input type="text" name="name" autocomplete="off" class="layui-input"
                      style="width: 200px;" value="${logUser.name}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                    <input type="radio" name="gender" value="男" title="男"
                        <c:if test="${logUser.gender == '男'}">
                           checked
                        </c:if>
                    >
                <input type="radio" name="gender" value="女" title="女"
                    <c:if test="${logUser.gender == '女'}">
                           checked
                    </c:if>
                >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">出生日期</label>
            <div class="layui-input-block">
                <input type="text" name="birthday" id="birthday" autocomplete="off" class="layui-input"
                       value="${logUser.birthday}"
                       style="width: 200px;">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">QQ</label>
            <div class="layui-input-block">
                <input type="text" name="qq" autocomplete="off" class="layui-input"
                       style="width: 200px;" value="${logUser.qq}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">微信</label>
            <div class="layui-input-block">
                <input type="text" name="wechat" autocomplete="off" class="layui-input"
                       style="width: 200px;" value="${logUser.wechat}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">是否保密</label>
            <div class="layui-input-block">
                <input type="checkbox" name="secrecy" lay-skin="switch"
                <c:if test="${logUser.secrecy}">
                       checked
                </c:if>
                       lay-filter="switch">
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">个人简述</label>
            <div class="layui-input-block" style="width:250px;">
                <textarea name="note" placeholder="请输入内容" class="layui-textarea">${logUser.note}</textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="userInfoForm">修改</button>
                <button type="reset" id="cancel" class="layui-btn layui-btn-primary">返回</button>
            </div>
        </div>
    </form>
</div>
<script>
    //Demo
    layui.use(['form','laydate'], function(){
        var form = layui.form;

        //监听提交
        form.on('submit(userInfoForm)', function(data){
            // layer.msg(JSON.stringify(data.field));
            // changeUserInfo

            if(data.field.secrecy){
                data.field.secrecy = true;
            }else{
                data.field.secrecy = false;
            }
            $.ajax({
                type: "POST",
                url: "${path}/user/changeUserInfo.do",
                data: data.field,
                dataType: "json",
                async: false,
                success: function(data){
                    var result=data;
                    if(result.code == 0){
                            window.location.href="${path}/user/index.do";
                    }else{
                        layer.msg(result.msg);
                        window.location.reload();
                    }
                }
            });
            return false;
        });
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#birthday', //指定元素
        });
    });
</script>
<script>
    function toChangePage() {
        layui.use('layer', function () {
            var layer = layui.layer;
            var  index = layer.open({
                type: 1
                ,content: $('#alterInfoPage')
                ,area:'555px'
                ,skin:'layui-layer-molv'
                ,title:[
                    '基本信息'
                    ,'font-size:24px;text-align:center;'
                ]
            });
            $("#cancel").click(function () {
                layer.close(layer.index);
            })
        });
    }
</script>
</html>