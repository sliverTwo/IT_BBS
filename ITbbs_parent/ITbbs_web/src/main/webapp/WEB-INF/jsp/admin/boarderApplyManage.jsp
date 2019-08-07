<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>申请列表</title>
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
    <div>
        <table id="boardApplyList" lay-filter="boardApplyList">
        </table>
        <script type="text/html" id="bar">
            <%--<a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>--%>
            <a class="layui-btn layui-btn-xs" lay-event="approve">同意</a>
            <a class="layui-btn layui-btn-xs" lay-event="refuse">拒绝</a>
        </script>
        <script>
            layui.use(['table', 'layer'], function () {
                var table = layui.table;
                var layer = layui.layer;
                //转换静态表格
                table.init('boardApplyList', {
                    height: 500 //设置高度
                    , limit: 4 //注意：请务必确保 limit 参数（默认：10）是与你服务端限定的数据条数一致
                    , skin: 'nob'
                    , even: true

                });
                table.render({
                    elem: '#boardApplyList'
                    , height: 500
                    , url: '${path}/admin/listApplyBoarder.do' //数据接口
                    , page: true //开启分页
                    , cols: [[ //表头
                        {field: 'username', title: '申请人', width: "10%"
                            ,templet:function(d){
                                var rel = '<a href="${path}/toUserInfo.do?userId='+d.userId
                                rel += '" target="_blank">'+d.username + '</a>';
                                return rel;
                            }
                        }
                        , {field: 'boardName', title: '版块', width: "10%"}
                        , {field: 'applyReason', title: '原因及优势', width: "40%"}
                        , {
                            field: 'createtime', title: '申请时间', width: '14%', align: 'center'
                            , templet: function (d) {
                                return new Date(d.createtime).toLocaleString();
                            }
                        }
                        , {width: 145, align: 'center', toolbar: '#bar'}
                    ]]
                    , id: 'boardApplyListId'
                    , text: {
                        none: '无申请信息！'
                    }
                });
                //监听工具条
                table.on('tool(boardApplyList)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-interceptor="对应的值"
                    var data = obj.data; //获得当前行数据
                    var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                    var tr = obj.tr; //获得当前行 tr 的DOM对象

                    if (layEvent === 'approve') { //同意
                        // 检查申请的版块是否有版主了
                        $.post('${path}/admin/checkBoardExistsBoarder.do',{boardId:data.boardId},
                            function (result) {
                                // 已有版主
                                if(result.code == 1){
                                    layer.alert("已有版主,请先取消前版主权限!",function (index) {
                                        layer.close(index);
                                    })
                                }else if(result.code == 0){ // 无版主
                                    // 填写同意原因
                                    layer.prompt({
                                        title:'同意原因',
                                        formType:2,
                                        maxlength:100
                                    },function (value, index, elem) {
                                        sendDeal(value,1,data,index);
                                    });
                                }else{
                                    layer.alert(result.msg);
                                }
                        },'json');
                    } else if (layEvent === 'refuse') { //拒绝
                        // 填写拒绝理由
                        layer.prompt({
                            title:'拒绝原因',
                            formType:2,
                            maxlength:100
                        },function (value, index, elem) {
                            // 发送拒绝请求
                            sendDeal(value,0,data,index);
                        });

                    }
                });

            });
            function sendDeal(value,code,data,index){
                var param = {};
                param.reason = value;
                param.code = 1
                param.id = data.id;
                // 发送同意申请请求
                $.post('${path}/admin/dealApply.do',param,function (result) {
                    if(result.code == 0){
                        layer.msg("处理完成",{icon:1});
                        window.location.reload();
                    }
                },'json');
                layer.close(index);
            }
        </script>
    </div>
    <div class="bbs_footerPush">
    </div>
</div>
<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp" %>
</div>
</body>

</div>
</html>
