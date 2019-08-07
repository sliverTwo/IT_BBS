<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>帖子列表</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp" %>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp" %>
        <%@ include file="/WEB-INF/jsp/inc/userNavbar.jsp" %>
    </div>
    <div class="bbs_page">
        <table  lay-filter="postList" id="postList" border="1"
                style="width: 100%;margin-top: 55px;text-align: center;display: none;">
        </table>
        <script>
            layui.use('table', function () {
                var table = layui.table;
                table.render({
                    elem: '#postList'
                    , height: 500
                    , url: '${path}/post/listPost.do' //数据接口
                    , page: true //开启分页
                    , cols: [[ //表头
                         {field: 'title', title: '主题',sort: true }
                        , {field: 'createtime', title: '发布时间',  sort: true
                            ,templet:function(d){
                                return new Date(d.createtime).toLocaleString();
                            }
                        }
                        , {field: 'viewNum', title: '浏览',sort: true}
                        // , {field: 'replyNum', title: '回复',sort: true}
                        ,{fixed: 'right', width:150, align:'center', toolbar: '#bar'}
                    ]]
                    ,id:'postListId'
                    ,text:{
                        none:'你暂未发布任何帖子！'
                    }
                });
                //监听工具条
                table.on('tool(postList)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-interceptor="对应的值"
                    var data = obj.data; //获得当前行数据
                    var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                    var tr = obj.tr; //获得当前行 tr 的DOM对象

                    if(layEvent === 'detail'){ //查看
                        //do somehing
                        window.location.href = path + "/post/toPost.do?postId="+data.id;
                    } else if(layEvent === 'del'){ //删除
                        layer.confirm('真的删除此帖子么？', function(index){
                            $.post("${path}/post/deletePost.do",{"postId":data.id},function(result)
                            {
                                console.log(result);
                                if(result.code == 0){
                                    obj.del();
                                }else{
                                    layer.msg(result.msg);
                                }
                            },"json");
                            layer.close(index);
                        });
                    } else if(layEvent === 'edit'){ //编辑
                        // 跳转到编辑页面
                        window.location.href = path + "/post/toEditPost?postId="+data.id;
                    }
                });
            });
        </script>
        <script type="text/html" id="bar">
            <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
            <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
         </script>
    </div>
    <div class="bbs_footerPush">
    </div>
</div>
<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp" %>
</div>
</body>
</html>
