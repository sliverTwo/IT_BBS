<%@ page contentType="text/html;charset=UTF-8"  %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp"%>
<html>
<head>
    <title>问题列表</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp"%>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp"%>
    </div>
    <div style="margin: 0 5%";>
        <table id="questionList" lay-filter="questionList">
        </table>
        <script type="text/html" id="bar">
            <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
        </script>
        <script>
            layui.use('table', function () {
                var table = layui.table;
                //转换静态表格
                table.init('questionList', {
                    height: 500 //设置高度
                    ,skin:'nob'
                    ,even:true

                });
                table.render({
                    elem: '#questionList'
                    , height: 500
                    , url: '${path}/question/listQuestion.do' //数据接口
                    , page: true //开启分页
                    ,skin:'nob'
                    ,even:true
                    , cols: [[ //表头
                        {field: 'title', title: '标题',width:'15%'
                            ,templet:function(d){
                                var
                                    link =
                                        "<a href='${path}/question/toQuestionDetail.do?questionId=" + d.id +">"+d.title+"</a>";
                                return link;
                            }
                        }
                        ,{field:'content',title:'内容',width:'35%'}
                        , {field: 'username', title: '发布人',width:'10%',align:'center'}
                        , {field: 'createtime', title: '发布时间',  sort: true,width:'15%'
                            ,templet:function(d){
                                return new Date(d.createtime).toLocaleString();
                            }
                        }
                        , {field: 'payScore', title: '悬赏积分',sort: true,width:'8%',align:'center'}
                        , {field: 'usefulAnswerId', title: '是否解决',width:'8%',align:'center'
                            ,templet:function (d) {
                                if(d.usefulAnswerId){
                                    return "已解决";
                                }else{
                                    return "待解决";
                                }
                            }
                        }
                        , { width:'8%',align:'center',toolbar:"#bar"}
                    ]]
                    ,id:'questionList'
                    ,text:{
                        none:'暂无提问！'
                    }
                });
                //监听工具条
                table.on('tool(questionList)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-interceptor="对应的值"
                    var data = obj.data; //获得当前行数据
                    var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                    var tr = obj.tr; //获得当前行 tr 的DOM对象

                    if(layEvent === 'detail'){ //查看
                        //do somehing
                        window.location.href = path + "/question/toQuestionDetail.do?questionId="+data.id;
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
    </div>
    <div class="bbs_footerPush">
    </div>
</div>
<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp"%>
</div>
</body>
</html>
