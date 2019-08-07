<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>版块管理</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp" %>
    <style>
        body .demo-class .layui-layer-btn a{background:#01AAED;}
    </style>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp" %>
    </div>
    <div style="float: left;margin: 0;padding: 0;">
        <%@include file="/WEB-INF/jsp/inc/adminNavbar.jsp" %>
    </div>
    <div style="text-align: right;  padding-right: 8%; margin-top: 10px;">
        <button class="layui-btn layui-btn-normal" onclick="toNewBoardUI()">新建版块</button>
    </div>
    <div >
        <table id="boardList" lay-filter="boardList">
        </table>
        <script type="text/html" id="bar">
            <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
            <!-- 这里同样支持 laytpl 语法，如： -->
            <a class="layui-btn layui-btn-xs" lay-event="del">删除</a>
        </script>
        <script>
            layui.use(['layer','table','form'], function () {
                var table = layui.table;
                var layer = layui.layer;
                var form = layui.form;
                layer.config({
                    extend: 'yourskin/style.css', //加载您的扩展样式
                });
                table.render( {
                    elem:'#boardList'
                    // ,height: 600 //设置高度
                    ,url:'${path}/board/listBoard.do' //数据接口
                    , limit: 4 //注意：请务必确保 limit 参数（默认：10）是与你服务端限定的数据条数一致
                    // , skin: 'nob'
                    , even: true
                    , text:{
                        none:'暂无板块信息'
                    }
                    ,cols: [[ //表头
                        {field: 'boardName',  title: '版块名',width:'8%'}
                        , {field: 'introduce', title: '版块介绍',width:'20%'}
                        , {field: 'createtime', title: '创建时间',sort: true
                             ,templet:function(d){
                                return new Date(d.createtime).toLocaleString();
                         },width:'15%'
                         }
                        , {field: 'username', title: '版主',width:'10%',align:'center'}
                        , {field: 'postNum', title: '发帖数',width:'8%',align:'center'}
                        , {field: 'orderNum', title: '排序号',sort: true,width:'8%',align:'center'}
                        ,{ width:'16%', align:'center', toolbar: '#bar'}
                    ]]


                });
                table.on('tool(boardList)', function (obj) {
                    var layEvent = obj.event;
                    var data = obj.data;

                    if(layEvent == 'del'){
                        layer.prompt({
                            formType: 2,
                            value: '',
                            title: '请输入删除原因',
                            area: ['500px', '150px'] //自定义文本域宽高
                        }, function(value, index, elem){
                            layer.alert('该版块内帖子会一起删除，是否继续',{icon:2},function(i){
                                // 向服务器发送冻结请求。
                                $.ajax({
                                    url:path+"/board/delBoard.do"
                                    ,type:"POST"
                                    ,dataType:"json"
                                    ,data:{'id':data.id,'delReason':value}
                                    ,async:true
                                    ,success:function (result) {
                                        if(result.code == 0){
                                            layer.msg("删除成功！")
                                            window.location.reload(true);
                                            obj.del();
                                        }else{
                                            layer.alert(result.msg,{icon:2});
                                        }
                                    }
                                    ,error:function (data) {
                                        layer.alert("请求出错，请检查网络连接！",{icon:2});
                                    }
                                });
                                layer.close(i);
                                layer.close(index);
                            });

                        });
                    }
                    // 查看详情
                    else if(layEvent == 'detail'){
                        setDetail(data);
                        layer.open({
                            type:1
                            ,title:[
                                '详情'
                                ,'font-size:24px;text-align:center;'
                            ]
                            ,content:$('#showDetail')
                            ,skin:'bg-class'
                            ,area:['555px','555px']
                        })
                    }
                    // 编辑版块信息
                    else if(layEvent == 'edit'){
                        console.log(data);
                        setEditInfo(data);
                        form.render('select');
                        var i = layer.open({
                            type:1
                            ,title:[
                                '编辑版块'
                                ,'font-size:24px;text-align:center;'
                            ]
                            ,content:$('#editUI')
                            ,skin:'bg-class'
                            ,area:['555px','555px']
                        })
                    }
                });

            });
        </script>
    </div>
    <div class="bbs_footerPush">
    </div>
</div>
<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp" %>
</div>
</body>
<script>
    function setDetail(data) {
        $('#bLogo').attr("src",data.pic);
        $('#name').text(data.boardName);
        $('#desc').text(data.introduce);
        $('#owner').text(data.username);
        $('#owerScore').text(data.score);
        $('#oNum').text(data.orderNum);
        $('#postNum').text(data.postNum);
        $('#cTime').text(new　Date(data.createtime).toLocaleString());
    }
    function setEditInfo(data){
        if(undefined == data ){
            return false;
        }
        $("#boardName").val(data.boardName);
        $("#boardId").val(data.id);
        $("#introduce").val(data.introduce)
        $.ajax({
            url:path+"/board/getCandidateBoarder.do"
            ,type:"POST"
            ,dataType:"json"
            ,data:{}
            ,async:false
            ,success:function (result) {
                if(result.code == 0){
                    $("#userId").html("");
                    console.log(result.data);
                    $.each(result.data,function(i,v){
                        $("#userId").prepend('<option value='+ v.id +'>'+ v.username+'</option>');
                    });
                    $("#userId").prepend('<option value="">请选择</option>');

                }else{
                    layer.alert(result.msg,{icon:2});
                }
            }
            ,error:function (data) {
                layer.alert("请求出错，请检查网络连接！",{icon:2});
            }
        });

        if($("option[value='"+ data.userId+ "']").length == 0 && data.userId != -1){
           $("#userId").prepend('<option value='+ data.userId +'>'+ data.username+'</option>');
        }
        $("#userId").val(data.userId);
        $("#score").val(data.score);
        $("#orderNum").val(data.orderNum);
        $("#logo").attr("src",data.pic);
    }
    function toNewBoardUI(){
        window.location.href = "${path}/board/toNewBoardUI.do";
    }
</script>
<div id="showDetail" style="margin-top: 20px;margin-left: 15%;display: none;">
    <table  border="0" style="width:83%;height: 90%;text-align: center;">
    </table>
</div>
<div id="editUI" style="margin-top: 20px;margin-left: 15%;display: none;">
    <form action="" class="layui-form">
        <%--版块logo--%>
        <div class="layui-form-item">
            <label class="layui-form-label">图标</label>
            <div class="layui-input-inline" style="text-align: center;">
                <img src="${path}/images/java.jpg" id="logo" width="50px" height="50px" alt="">
                <a href="javascript:;" id="alterPicBtn">
                    <i  class="layui-icon" style="font-size: 24px;">&#xe642;</i>
                </a>
            </div>
            <div class="layui-form-mid layui-word-aux">
            </div>
        </div>
        <script>
            layui.use('upload', function(){
                var upload = layui.upload;
                //执行实例
                var uploadInst = upload.render({
                    elem: '#alterPicBtn' //绑定元素
                    ,url: '${path}/upload/uploadImg.do' //上传接口
                    ,done: function(res) {
                        //上传完毕回调
                        console.log(res);
                        var src = res.data.src;
                        $("#logo").prop('src', src);
                    }
                    ,error: function(){
                        //请求异常回调
                    }
                });
            });
        </script>
            <%--版块id--%>
        <div class="layui-form-item">
            <input type="hidden" name="boardId" id="boardId" autocomplete="off" class="layui-input"
                       readonly style="width: 200px;" >
        </div>
        <%--版块名--%>
        <div class="layui-form-item">
            <label class="layui-form-label">名称</label>
            <div class="layui-input-block">
                <input type="text" name="boardName" id="boardName" autocomplete="off" class="layui-input"
                       readonly style="width: 200px;" >
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">介绍</label>
            <div class="layui-input-block" style="width:250px;">
                <textarea name="introduce" id="introduce" placeholder="请输入内容" class="layui-textarea"></textarea>
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
                <select name="userId" id="userId"  lay-search>
                    <option value=""></option>
                    <c:forEach var="c" items="${candidateList}">
                        <option value="${c.id}">${c.username}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">版主月供</label>
            <div class="layui-input-block" style="width: 150px;">
                <select name="score" id="score" lay-verify="required" style="width: 150px;" lay-search>
                    <c:forEach var="s" items="${scoreList}">
                        <option value="${s}">${s}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="borderInfoForm">修改</button>
            </div>
        </div>
    </form>
</div>
<script>
    layui.use('form',function(){
        var form = layui.form;
        form.on('submit(borderInfoForm)',function(data){
            var param ={}
            var field = data.field;
            param.introduce = field.introduce;
            param.id = field.boardId;
            if(field.userId){
                param.userId = field.userId;
            }
            param.score = field.score;
            param.orderNum = field.orderNum;
            param.pic =  $("#logo").attr('src');
            console.log(param);
            $.ajax({
                url:path+"/board/alterBoard.do"
                ,type:"POST"
                ,dataType:"json"
                ,data:param
                ,success:function (result) {
                    if(result.code == 0){
                        layer.msg('修改成功！',{icon:1});
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
        })
    });
</script>
</html>

