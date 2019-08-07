<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>公共信息管理</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp" %>
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
        <button class="layui-btn layui-btn-normal" onclick="toNewPublicInfoUI()">新建公共信息</button>
    </div>
    <script>
        function toNewPublicInfoUI() {
            window.location.href="${path}/publicInfo/toAddPublicInfo.do";
        }
    </script>
    <div style="margin-top: 0px;">
        <table id="publicInfoList" lay-filter="publicInfoList">
        </table>
        <script type="text/html" id="bar">
            <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
            <!-- 这里同样支持 laytpl 语法，如： -->
            <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs" lay-event="del">删除</a>
        </script>
        <script>
            layui.use(['table', 'layer'], function () {
                var table = layui.table;
                var layer = layui.layer;
                //转换静态表格
                table.init('publicInfoList', {
                    height: 500 //设置高度
                    , limit: 4 //注意：请务必确保 limit 参数（默认：10）是与你服务端限定的数据条数一致
                    , skin: 'nob'
                    , even: true

                });
                table.render({
                    elem: '#publicInfoList'
                    , height: 500
                    , url: '${path}/publicInfo/listPublicInfo.do' //数据接口
                    , page: true //开启分页
                    , cols: [[ //表头
                        {field: 'title', title: '标题',width:"15%"}
                        ,{field: 'content', title: '内容',width:"42%" }
                        , {field: 'createtime', title: '发布时间',width:'14%',align:'center'
                            ,templet:function(d){
                                return new Date(d.createtime).toLocaleString();
                            }
                        }
                        ,{ width:150, align:'center', toolbar: '#bar'}
                    ]]
                    ,id:'publicInfoListId'
                    ,text:{
                        none:'暂无公共信息！'
                    }
                });
                //监听工具条
                table.on('tool(publicInfoList)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-interceptor="对应的值"
                    var data = obj.data; //获得当前行数据
                    var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                    var tr = obj.tr; //获得当前行 tr 的DOM对象

                    if(layEvent === 'detail'){ //查看
                        var url =  path + "/publicInfo/toPublicInfo.do?publicInfoId="+data.id;
                        //window.location.href
                        window.open(url);
                    } else if(layEvent === 'del'){ //删除
                        layer.confirm('确认删除此信息？', function(index){
                            $.post("${path}/publicInfo/deletePublicInfo.do"
                                ,{"publicInfoId":data.id}
                                , function(result) {
                                        console.log(result);
                                        if(result.code == 0){
                                            obj.del();
                                        }else{
                                            layer.msg(result.msg);
                                        }
                                    }
                                , "json");
                            layer.close(index);
                        });
                    } else if(layEvent === 'edit'){ //编辑
                        toEidtPage(data);
                        // 跳转到编辑页面
                        // window.location.href = path + "/post/toEditPost?postId="+data.id;
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
    var content;
    function toEidtPage(data) {
        $('#publicInfoId').val(data.id);
        $('#title').val(data.title);
        $('#content').val(data.content);
        console.log(data);
        var layer = layui.layer;
        layer.config({
            extend: 'yourskin/style.css', //加载您的扩展样式
        });
        layui.use(['layedit', 'form','layer'], function () {
            var layedit = layui.layedit;
            layedit.set({
                uploadImage: {
                    url: '${path}/upload/uploadImg.do' //接口url
                    , type: 'post' //默认post
                }
            });
            console.log('${path}/upload/uploadImg.do');
            var index = layedit.build('content'); //建立编辑器
            var i = layer.open({
                type:1
                ,title:[
                    '编辑公共信息'
                    ,'font-size:24px;text-align:center;'
                ]
                ,content:$('#editUI')
                ,skin:'whitesmoke-bg-class'
                ,area:['60%','80%']
            });
            var form = layui.form;
            //监听提交
            form.on('submit(publicInfoForm)', function (data) {
                // console.log(layedit.getContent(index));
                data.field.content = layedit.getContent(index);
                content = data.field.content;
                console.log(content.length);
                if($.trim(data.field.content).length <= 0){
                    layer.msg("内容不能为空！",{icon:2});
                    return false;
                }
                if( data.field.content.length>4096){
                    layer.msg("长度过长，不能发布！",{icon:2});
                    return false;
                }
                $.ajax({
                    type: "POST",
                    url: "${path}/publicInfo/updatePublicInfo.do",
                    data: data.field,
                    dataType: "json",
                    async: false,
                    success: function(data){
                        var result=data;
                        if(result.code == 0){
                            layer.msg("修改成功！")
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
    }
</script>
<div id="editUI" style="margin-top: 20px;margin-left: 30px;display: none;">
    <form action="" class="layui-form">
        <div class="layui-form-item">
            <input type="hidden" name="id" id="publicInfoId" autocomplete="off" class="layui-input"
                   readonly style="width: 200px;" >
        </div>
        <%--版块名--%>
        <div class="layui-form-item">
            <label class="layui-form-label">标题</label>
            <div class="layui-input-block">
                <input type="text" name="title" id="title" autocomplete="off" class="layui-input"
                        style="width: 300px;" >
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">介绍</label>
            <div class="layui-input-block" style="width: 80%;">
                <textarea name="content" id="content" placeholder="请输入内容" class="layui-textarea"></textarea>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block" style="text-align: center;">
                <button class="layui-btn" lay-submit lay-filter="publicInfoForm">修改</button>
            </div>
        </div>
    </form>
</div>
</html>

