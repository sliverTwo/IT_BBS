<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>新建帖子</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp" %>
    <style>
        .content{
            width: 800px;
            margin-left: 15%;
        }
    </style>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp" %>
        <%@ include file="/WEB-INF/jsp/inc/userNavbar.jsp" %>
    </div>
    <div class="content"
         style="width: 800px;margin-left: 20%;margin-top: 20px;font-size: 16px;letter-spacing: 3px;">
        <form class="layui-form" >
            <div class="layui-form-item">
                <label class="layui-form-label">主题</label>
                <div class="layui-input-block">
                    <input type="text" name="title" required lay-verify="required" placeholder=""
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">板块</label>
                <div class="layui-input-inline">
                    <select name="boardId" lay-filter="board">
                        <c:forEach var="b" items="${boardList}" step="1">
                            <option value="${b.id}">${b.boardName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">内容</label>
                <div class="layui-input-block">
                    <textarea id="postContent" name="content" style="display: none;"></textarea>

                </div>
            </div>
            <div class="layui-form-item" style="text-align: center;">
                <div class="layui-input-block">
                    <button class="layui-btn"  lay-submit lay-filter="submitPost">发布</button>
                    <button type="reset" class="layui-btn layui-btn-primary">取消</button>
                </div>
            </div>
        </form>
    </div>
    <div class="bbs_footerPush">
    </div>
</div>
<script>
    layui.use(['layedit', 'form'], function () {
        var layedit = layui.layedit;
        var form = layui.form;
        layedit.set({
            uploadImage: {
                url: '${path}/upload/uploadImg.do' //接口url
                , type: 'post' //默认post
            }
        });
        var index = layedit.build('postContent'); //建立编辑器

        //监听提交
        form.on('submit(submitPost)', function (data) {
            console.log(layedit.getContent(index));
            data.field.content = layedit.getContent(index);
            $.ajax({
                type: "POST",
                url: "${path}/post/savePost.do",
                data: data.field,
                dataType: "json",
                async: false,
                success: function(result){
                    if(result.code == 0){
                        layer.msg("发布成功！")
                        window.location.href="${path}/user/toListPage?url=postManage/list";
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
<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp" %>
</div>
</body>
</html>
