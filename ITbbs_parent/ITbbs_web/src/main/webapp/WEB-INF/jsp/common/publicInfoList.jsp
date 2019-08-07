<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>公共信息列表</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp" %>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp" %>
    </div>
    <div style="margin:0 10%;">
        <table id="publicInfoList" lay-filter="publicInfoList">
        </table>
        <script type="text/html" id="bar">
            <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
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
                        {field: 'title', title: '标题',width:"20%"}
                        ,{field: 'content', title: '内容',width:"53%" }
                        , {field: 'createtime', title: '发布时间',width:'20%',align:'center'
                            ,templet:function(d){
                                return new Date(d.createtime).toLocaleString();
                            }
                        }
                        ,{ width:75, align:'center', toolbar: '#bar'}
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
</html>

