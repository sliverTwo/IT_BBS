<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>编辑帖子</title>
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
        <form class="layui-form" action="" onsubmit="javascript:return false;">
            <div class="layui-form-item">
                <label class="layui-form-label">主题</label>
                <div class="layui-input-block">
                    <input type="text" name="title" required lay-verify="required" placeholder=""
                           autocomplete="off" class="layui-input" value="${post.title}">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">板块</label>
                <div class="layui-input-inline">
                    <select name="boardId" lay-filter="board">
                        <c:forEach var="b" items="${boardList}" step="1">
                            <option value="${b.id}"
                                    <c:if test="${b.id == post.boardId}">
                                        selected
                                    </c:if>
                            >${b.boardName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">内容</label>
                <div class="layui-input-block">
                    <textarea id="postContent" name="content" style="display: none;">${post.content}</textarea>
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
                            var index = layedit.build('postContent'); //建立编辑器
                            var form = layui.form;
                            //监听提交
                            form.on('submit(submitPost)', function (data) {
                                data.field.content = layedit.getContent(index);
                                data.field.id = "${post.id}";
                                $.ajax({
                                    type: "POST",
                                    url: "${path}/post/updatePost.do",
                                    data: data.field,
                                    dataType: "json",
                                    async: false,
                                    success: function(data){
                                        var result=data;
                                        if(result.code == 0){
                                            layer.msg("修改成功！");
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
                </div>
            </div>
            <div class="layui-form-item" style="text-align: center;">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="submitPost">修改</button>
                    <button onclick="back()"  class="layui-btn
                    layui-btn-primary" lay-filter="back">取消</button>
                </div>
            </div>
        </form>
    </div>
    <div class="bbs_footerPush">
    </div>
</div>
<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp" %>
</div>
<script>
    function back() {
        window.history.go(-1);
        return false;
    }
</script>
</body>
</html>
