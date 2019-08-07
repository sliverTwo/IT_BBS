<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>问题列表</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp" %>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp" %>
        <%@ include file="/WEB-INF/jsp/inc/userNavbar.jsp" %>
    </div>
    <div class="bbs_page">
        <table  lay-filter="questionList" id="questionList" border="1"
                style="width: 100%;margin-top: 55px;text-align: center;display: none;">
        </table>
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
                    , url: '${path}/question/listQuestionByAnswers.do' //数据接口
                    , page: true //开启分页
                    ,skin:'nob'
                    ,even:true
                    , cols: [[ //表头
                        {field: 'title', title: '标题',width:'15%'}
                        ,{field:'content',title:'内容',width:'25%'}
                        ,{field:'userId',title:'发布人',width:'10%'}
                        , {field: 'createtime', title: '发布时间',  align:'center',sort: true,width:'20%'
                            ,templet:function(d){
                                return new Date(d.createtime).toLocaleString();
                            }
                        }
                        , {field: 'payScore', title: '悬赏积分',sort: true,width:'10%',align:'center'}
                        , {field: 'usefulAnswerId', title: '是否解决',width:'10%',align:'center'
                            ,templet:function (d) {
                                if(d.usefulAnswerId && d.usefulAnswerId.length > 0){
                                    return "已解决";
                                }else{
                                    return "待解决";
                                }
                            }
                        }
                        , { align:'center',toolbar:"#bar"}
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
                        window.location.href = path + "/question/toQuestionDetail.do?questionId="+data.id;
                    }
                });
            });
        </script>
        <script type="text/html" id="bar">
            <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
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
