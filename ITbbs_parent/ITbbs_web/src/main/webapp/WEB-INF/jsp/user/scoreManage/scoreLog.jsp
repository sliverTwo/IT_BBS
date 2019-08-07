<%@ page contentType="text/html;charset=UTF-8"  %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp"%>
<html>
<head>
    <title>积分记录</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp"%>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp"%>
        <%@ include file="/WEB-INF/jsp/inc/userNavbar.jsp" %>
    </div>
    <div class="bbs_page">
        <table  lay-filter="scoreList" id="scoreList" border="1"
                style="width: 100%;margin-top: 55px;text-align: center;display: none;">
        </table>
        <script>
            layui.use('table', function () {
                var table = layui.table;
                table.render({
                    elem: '#scoreList'
                    , height: 500
                    , url: '${path}/user/listScoreLog.do' //数据接口
                    , page: true //开启分页
                    , cols: [[ //表头
                        {field: 'id', title: '编号',type:'numbers'}
                        , {field: 'content', title: '内容',align:'center'}
                        , {field: 'score', title: '积分',align:'center'}
                        , {field: 'createtime', title: '时间',align:'center'
                            ,templet:function(d){
                                return new Date(d.createtime).toLocaleString();
                            }
                        }
                    ]]
                    ,id:'scoreListId'
                    ,text:{
                        none:'无记录！'
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
