<%@ page contentType="text/html;charset=UTF-8"  %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp"%>
<html>
<head>
    <title>版主申请</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp"%>
    <script>
        $(function () {
            var boardListLen = "${fn:length(boardList)}";
           if(Number(boardListLen) <= 0){
               layui.use('layer',function () {
                   layer = layui.layer;
                   layer.alert('无版块版主可申请！',function (index) {
                       layer.close(index);
                       window.history.go(-1);
                   })
               })
            }
        });
    </script>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp"%>
        <%@ include file="/WEB-INF/jsp/inc/userNavbar.jsp"%>
    </div>
    <div style="float: left;margin-top: 88px;margin-left: 335px;">
        <form action="javascript:return false;" class="layui-form">
            <%--版块logo--%>
            <div class="layui-form-item">
                <label class="layui-form-label">申请版块</label>
                <div class="layui-input-inline" style="text-align: center;">
                    <select name="boardId" lay-filter="board">
                        <c:forEach var="b" items="${boardList}">
                            <option value="${b.id}">${b.boardName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">申请原因及优势</label>
                <div class="layui-input-block" style="width:200px;">
                    <textarea name="applyReason" placeholder="请输入申请的原因和优势" class="layui-textarea"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">申请</button>
                    <button type="reset" id="cancel" class="layui-btn layui-btn-primary">返回</button>
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
<script>
    $('#cancel').click(function () {
        history.go(-1);
    });
    layui.use('form', function(){
        var form = layui.form;
        //监听提交
        form.on('submit(formDemo)', function(data){
            var param  = data.field;
            $.ajax({
                url:path+"/user/applyBoarder.do"
                ,type:"POST"
                ,dataType:"json"
                ,data:param
                ,success:function (result) {
                    if(result.code == 0){
                        layer.msg('申请成功',{icon:1});
                        history.go(-1);
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
</body>
</html>
