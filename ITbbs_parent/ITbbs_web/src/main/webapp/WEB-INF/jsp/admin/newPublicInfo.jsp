<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>新建公共信息</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp" %>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp" %>
    </div>
    <div style="float: left;">
        <%@include file="/WEB-INF/jsp/inc/adminNavbar.jsp" %>
    </div>

    <div style="float: left;margin-top: 55px;margin-left: 100px;">
        <form action="" class="layui-form">

            <%--公告标题--%>
            <div class="layui-form-item">
                <label class="layui-form-label">标题</label>
                <div class="layui-input-block" >
                    <input type="text" name="title" id="title" autocomplete="off"
                           required  lay-verify="required"
                           class="layui-input"
                           placeholder="输入公共信息标题"   size="50">
                </div>
            </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">内容</label>
                    <div class="layui-input-block">
                        <textarea id="publicInfoContent" name="content" style="display: none;"></textarea>
                        <script>
                            layui.use(['layedit', 'form'], function () {
                                var layedit = layui.layedit;
                                layedit.set({
                                    uploadImage: {
                                        url: '${path}/upload/uploadImg.do' //接口url
                                        , type: 'post' //默认post
                                    }
                                });
                                console.log('${path}/upload/uploadImg.do');
                                var index = layedit.build('publicInfoContent'); //建立编辑器
                                var form = layui.form;
                                //监听提交
                                form.on('submit(savePublicInfo)', function (data) {
                                    // console.log(layedit.getContent(index));
                                    data.field.content = $.trim(layedit.getContent(index));
                                    if(data.field.content.length <= 0){
                                        layer.msg("内容不能为空！",{icon:2});
                                        return false;
                                    }
                                    if( data.field.content.length>4096){
                                        layer.msg("长度过长，不能发布！",{icon:2});
                                        return false;
                                    }
                                    $.ajax({
                                        type: "POST",
                                        url: "${path}/publicInfo/savePublicInfo.do",
                                        data: data.field,
                                        dataType: "json",
                                        async: false,
                                        success: function(data){
                                            var result=data;
                                            if(result.code == 0){
                                                layer.msg("发布成功！")
                                                window.location.href="${path}/publicInfo/toListPublicInfoManageUI.do";
                                            }else{
                                                layer.msg(result.msg);
                                                // window.location.reload();
                                            }
                                        }
                                    });
                                    return false;
                                });
                            });
                            <%--<div class="layui-form-mid layui-word-aux">辅助文字</div>--%>
                        </script>
                    </div>
                </div>
            <div class="layui-form-item" style="text-align: center;">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="savePublicInfo">发布</button>
                    <button type="reset" id="cancel" class="layui-btn layui-btn-primary">返回</button>
                </div>
            </div>
                <script>
                    $('#cancel').click(function () {
                        window.history.go(-1);
                    });
                </script>
        </form>
    </div>
    <div class="bbs_footerPush">
    </div>
</div>

<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp" %>
</div>
</body>
</html>
