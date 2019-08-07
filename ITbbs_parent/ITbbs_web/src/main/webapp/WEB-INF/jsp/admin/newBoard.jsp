<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>新建版块</title>
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

    <div style="float: left;margin-top: 88px;margin-left: 335px;">
        <form action="" class="layui-form">
            <%--版块logo--%>
            <div class="layui-form-item">
                <label class="layui-form-label">图标</label>
                <div class="layui-input-inline" style="text-align: center;">
                    <img  src="${path}/${boardDefaultPic}" id="logo" width="50px" height="50px" alt="">
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
                           style="width: 200px;" placeholder="版块名" onblur="checkBoardName()" >
                </div>
                <div class="layui-form-mid layui-word-aux" style="margin-left: 20px;">
                    <span id="warn"  style="color: red;font-size: 16px;"></span>
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">介绍</label>
                <div class="layui-input-block" style="width:200px;">
                    <textarea name="introduce" placeholder="请输入版块介绍" class="layui-textarea"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">排序号</label>
                <div class="layui-input-inline" >
                    <input type="number" name="orderNum" id="orderNum" autocomplete="off"
                           required  lay-verify="required|number"
                           class="layui-input"
                           style="width: 200px;" placeholder="请输入一个数字排序号" >
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">版主</label>
                <div class="layui-input-block" style="width: 200px;">
                    <select name="userId"  lay-search>
                        <option value=""></option>
                        <c:forEach var="c" items="${candidateList}">
                            <option value="${c.id}">${c.username}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">版主月供</label>
                <div class="layui-input-block" style="width: 200px;">
                    <select name="score"  style="width: 150px;">
                        <option value="0">0</option>
                        <c:forEach var="s" items="${scoreList}">
                            <option value="${s}">${s}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="boardForm">提交</button>
                    <button type="reset" id="cancel" class="layui-btn layui-btn-primary">返回</button>
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
</body>
<script>
    var flag = false;
    function checkBoardName(){
        var boardName = $("#boardName").val();
        if(!boardName){
            return false;
        }
        $.ajax({
            url:path+"/board/checkBoardName.do"
            ,type:"POST"
            ,dataType:"json"
            ,data:{'boardName':boardName}
            ,async:false
            ,success:function (result) {
                if(result.code == 0){
                    $("#warn").text("");
                    flag = true;
                }else{
                    $("#warn").text("已有此版块");
                    flag = false;
                }
            }
            ,error:function (data) {
                layer.alert("请求出错，请检查网络连接！",{icon:2});
                flag = false;
            }
        });

    }
    layui.use('form', function(){
        var form = layui.form;
        console.log(flag);
        //监听提交
        form.on('submit(boardForm)', function(data){
            var param = {};
            param.boardName = data.field.name;
            param.introduce = data.field.introduce;
            param.userId = data.field.userId;
            param.score = data.field.score;
            param.orderNum = data.field.orderNum;
            param.pic = $("#logo").attr('src');
            if(flag == false){
                return false;
            }
            $.ajax({
                url:path+"/board/saveBoard.do"
                ,type:"POST"
                ,dataType:"json"
                ,data:param
                ,success:function (result) {
                    if(result.code == 0){
                        layer.msg('新增成功',{icon:1});
                        window.location.href = '${path}/board/toBoardListUI.do';
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
</script>
<script>
    layui.use('upload', function () {
        var upload = layui.upload;
        //执行实例
        var uploadInst = upload.render({
            elem: '#picBtn' //绑定元素
            ,size:3072
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
</html>
