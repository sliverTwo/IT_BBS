<%@ page contentType="text/html;charset=UTF-8"  %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp"%>
<html>
<head>
    <title>信息列表</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp"%>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp"%>
        <%@ include file="/WEB-INF/jsp/inc/userNavbar.jsp"%>
    </div>
    <div class="bbs_page">
        <table  lay-filter="messageList" id="messageList" border="1"
                style="width: 100%;margin-top: 55px;text-align: center;display: none;">
        </table>
        <script>
            layui.use(['table','layer'], function () {
                var table = layui.table;
                table.render({
                    elem: '#messageList'
                    , height: 500
                    , url: '${path}/message/listMessage.do' //数据接口
                    , page: true //开启分页
                    , cols: [[ //表头
                        // {type:'checkbox'}
                        {field: 'title', title: '标题',width:'15%' }
                        , {field: 'content', title: '内容',width:'31%' }
                        , {field: 'sender', title: '发送人',width:'9%' ,align:'center'}
                        , {field: 'sendTime', title: '发送时间',align:'center',width:'20%'
                            ,templet:function(d){
                                return new Date(d.sendTime).toLocaleString();
                            }
                        }
                        , {field: 'readed', title: '状态',width:'8%', align:'center'
                            ,templet:function(d){
                                var state = "未读";
                                if(d.readed){
                                    state = "已读";
                                }
                                return state;
                            }
                        }
                        ,{width:115, align:'center', toolbar: '#bar'}
                    ]]
                    ,id:'messageListId'
                    ,text:{
                        none:'暂无消息！'
                    }
                });
                //监听工具条
                table.on('tool(messageList)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-interceptor="对应的值"
                    var data = obj.data; //获得当前行数据
                    var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                    var tr = obj.tr; //获得当前行 tr 的DOM对象
                    layer.config({
                        extend: 'yourskin/style.css', //加载您的扩展样式
                    });
                    var param = {'messageId':data.id};
                    if(layEvent === 'detail'){
                        setDetail(data);
                        if(!data.readed){
                            // 将消息设置为已读
                            $.post("${path}/message/readMessage.do",param,function (result) {
                                if(result.code == 0){
                                    countUnreadMessage();
                                    table.reload('messageListId',{
                                        page: {
                                            curr: 1 //重新从第 1 页开始
                                        }
                                    });
                                }
                            },'json');
                        }
                        layer.open({
                            type: 1
                            ,title:'信息详情'
                            ,content:$('#messageDetail')
                            ,area:['700px','500px']
                            ,skin:'bg-class'
                        });
                    } else if(layEvent === 'del'){ //删除
                        $.post("${path}/message/deleteMessage.do",param,function (result) {
                            if(result.code === 0){
                                console.log(obj);
                                obj.del();
                                countUnreadMessage();
                            }else{
                                layer.msg(result.msg,{icon:2});
                            }
                        },'json');
                    }
                });
            });
        </script>
        <script type="text/html" id="bar">
            <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
        </script>
    </div>
    <div class="bbs_footerPush">
    </div>
</div>
<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp"%>
</div>
</body>
<script>
    function setDetail(d){
        $('#mHead').text(d.title);
        $('#mBody').text(d.content);
        $('#sendUserName').text(d.sender);
        $('#mTime').text(new Date(d.sendTime).toLocaleString());
    }
</script>
<div id="messageDetail" style="display: none;padding: 0 30px;">
    <div >
        <h2 id="mHead" style="text-align: center;margin-top: 20px;">标题</h2>

    </div>
    <div id="mBody" style="text-indent: 2em; margin-top: 33px;font-size: 16px;letter-spacing: 1px;">
        信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题信息主题
    </div>
    <div id="mInfo" style="text-align: right;margin-top: 50px;"> <span id="'sendUserName">admin</span>
        发送于 <span id="mTime">xxxx.xx.xx</span></div>
</div>
</html>
