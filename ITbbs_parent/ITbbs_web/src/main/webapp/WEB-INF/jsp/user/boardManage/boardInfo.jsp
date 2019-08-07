<%@ page contentType="text/html;charset=UTF-8"  %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp"%>
<html>
<head>
    <title>版块管理</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp"%>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp"%>
        <%@ include file="/WEB-INF/jsp/inc/userNavbar.jsp"%>
    </div>
    <div style="float: left;margin-top: 88px;margin-left: 335px;">
        <form action="" class="layui-form">
            <%--版块logo--%>
            <div class="layui-form-item">
                <label class="layui-form-label">图标</label>
                <div class="layui-input-inline" style="text-align: center;">
                    <img  src="${board.pic}" id="logo" width="50px" height="50px" alt="">
                    <a href="javascript:;" id="picBtn">
                        <i class="layui-icon" style="font-size: 24px;">&#xe642;</i>
                    </a>
                </div>
            </div>

            <%--版块名--%>
            <div class="layui-form-item">
                <label class="layui-form-label">名称</label>
                <div class="layui-input-inline" >
                    <input type="text" name="name" id="boardName" autocomplete="off"
                           required  lay-verify="required"
                           class="layui-input"
                           style="width: 200px;" placeholder="版块名" readonly value="${board.boardName}">
                </div>
                <div class="layui-form-mid layui-word-aux" style="margin-left: 20px;">
                    <span id="warn"  style="color: red;font-size: 16px;"></span>
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">介绍</label>
                <div class="layui-input-block" style="width:200px;">
                    <textarea name="introduce" placeholder="请输入版块介绍" class="layui-textarea">${board.introduce}
                    </textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">修改</button>
                    <button type="reset" id="cancel" class="layui-btn layui-btn-primary">返回</button>
                </div>
            </div>
        </form>
    </div>
    <script>
        $('#cancel').click(function () {
            history.go(-1);
        });
        layui.use('form', function(){
            var form = layui.form;
            //监听提交
            form.on('submit(formDemo)', function(data){
                var param = {};
                param.id = '${board.id}';
                param.introduce = data.field.introduce;
                param.pic = $("#logo").attr('src');
                $.ajax({
                    url:path+"/board/alterBoardByBorder.do"
                    ,type:"POST"
                    ,dataType:"json"
                    ,data:param
                    ,success:function (result) {
                        if(result.code == 0){
                            layer.msg('修改成功',{icon:1});
                            window.location.reload();
                        }else{
                            layer.alert(result.msg,{icon:2});
                        }
                    }
                    ,error:function (data) {
                        layer.alert("请求出错，请检查网络连接！",{icon:2});
                    }
                });
                return false;
            });
        });
        layui.use('upload', function () {
            var upload = layui.upload;
            //执行实例
            var uploadInst = upload.render({
                elem: '#picBtn' //绑定元素
                , url: '${path}/upload/uploadImg.do' //上传接口
                , done: function (res) {
                    //上传完毕回调
                    var src = res.data.src;
                    $("#logo").prop('src', src);
                }
                , error: function () {
                    //请求异常回调
                }
            });
        });
    </script>
    <div class="bbs_footerPush">
    </div>
</div>
<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp"%>
</div>
</body>
</html>
