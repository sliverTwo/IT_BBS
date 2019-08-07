<%@ page contentType="text/html;charset=UTF-8"  %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp"%>
<html>
<head>
    <title>上传文件</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp"%>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp"%>
        <%@include file="/WEB-INF/jsp/inc/userNavbar.jsp" %>
    </div>
    <div class="bbs_page" style="margin-top: 20px; ">
        <form class="layui-form" action="" onsubmit="javascript:return false;">
            <div class="layui-form-item">
                <label class="layui-form-label">文件名</label>
                <div class="layui-input-inline" style="width: 250px;">
                    <input type="text" name="filename" id="filename" required lay-verify="required" placeholder=""
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">文件</label>
                <div class="layui-input-inline" style="width: 250px;">
                    <button id="file" type="button" class="layui-btn" id="test1">
                        <i class="layui-icon">&#xe67c;</i>上传
                    </button>
                </div>
                <div class="layui-form-mid layui-word-aux" style="">大小限制：5M,支持格式：rar,zip,7z,jar</div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">所需积分</label>
                <div class="layui-input-inline">
                    <select id="score" name="score" lay-filter="board">
                        <c:forEach var="f" items="${fileScoreLevel}" step="1">
                            <option value="${f}">${f}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">描述</label>
                <div class="layui-input-block">
                    <textarea id="postContent" name="introduce" style="display: none;"></textarea>
                    <script>
                        layui.use(['layedit', 'form','upload'], function () {
                            // 富文本框
                            var layedit = layui.layedit;
                            layedit.set({
                                uploadImage: {
                                    url: '${path}/upload/uploadImg.do' //接口url
                                    , type: 'post' //默认post
                                }
                            });
                            var index = layedit.build('postContent',{
                                tool:[]
                                ,hideTool:[]
                            });
                            // 上传控件
                            var upload = layui.upload;
                            //执行实例
                            var uploadinst = upload.render({
                                elem: '#file' //绑定元素
                                ,url: '${path}/upload/uploadFile.do' //上传接口
                                ,auto:false
                                ,bindAction:'#submitFile'
                                ,exts:'zip|rar|7z|jar'
                                ,accept:'file'
                                ,size:5120
                                ,data:{
                                    fileName:function(){
                                        return $('#filename').val();
                                    }
                                    ,score: function () {
                                        return $('#score').val();
                                    }
                                    ,introduce:function () {
                                        return layedit.getContent(index);
                                    }
                                }
                                ,done: function(res){
                                    if(res.code == 0){
                                        layer.msg("上传成功！",{icon:1});
                                        window.location.href = path+"/user/toListPage?url=file/myUpload";
                                    }else{
                                        layer.msg(res.msg,{icon:2});
                                    }
                                }
                                ,error: function(){
                                    //请求异常回调
                                    layer.msg("网络错误，上传失败，请检查网络！",{icon:2});
                                }
                            });
                            // 表单控件
                            var form = layui.form;
                            //监听提交
                            form.on('submit(submitFile)', function (data) {
                                return false;
                            });
                        });
                    </script>
                </div>
            </div>
            <div class="layui-form-item" style="text-align: center;">
                <div class="layui-input-block">
                    <button id="submitFile" class="layui-btn"  lay-submit lay-filter="submitFile">上传</button>
                    <button  class="layui-btn layui-btn-primary">取消</button>
                </div>
            </div>
        </form>
    </div>
    <div class="bbs_footerPush">
    </div>
</div>
<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp"%>
</div>
</body>
</html>
