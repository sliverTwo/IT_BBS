<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>版块</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp" %>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp" %>

        <div class="bbs_left">

            <%--版块列表--%>
                <ul class="layui-nav layui-nav-tree layui-bg-cyan" lay-filter="test" style="height: 100%">
                    <!-- 侧边导航: <ul class="layui-nav layui-nav-tree layui-nav-side"> -->
                <c:forEach var="b" items="${boardList}">
                    <li class="layui-nav-item"><a href="${path}/toBoardUI.do?boardId=${b.id}">${b.boardName}</a></li>
                </c:forEach>
            </ul>
        </div>

        <div>
            <%--版块内帖子列表--%>
            <table id="postList" lay-filter="postList">
            </table>
            <script>
                var boardId = ${boardId}?${boardId}:${boardList[0].id};
                layui.use('table', function () {
                    var table = layui.table;
                    //转换静态表格
                    table.init('postList', {
                        height: 600 //设置高度
                        , limit: 4 //注意：请务必确保 limit 参数（默认：10）是与你服务端限定的数据条数一致


                    });
                    table.render({
                        elem: '#postList'
                        , height: 500
                        , url: '${path}/post/listPostByBoardId.do' //数据接口
                        , where:{boardId:boardId}
                        , page: true //开启分页
                        ,skin:'nob'
                        ,even:true
                        , cols: [[ //表头
                            {field: 'title', title: '主题',width:'56%'
                                ,templet:function(d){
                                    var  link = ""
                                    if(d.isTop){
                                        link += '<span class=\"layui-badge\">置顶</span>';
                                    }
                                    link += "<a href='${path}/post/toPost.do?postId="+d.id+"'>"+d.title+"</a>";
                                    return link;
                                }
                            },
                            {field: 'userName', title: '发布人',width:'8%',align:'center'}
                            , {field: 'createtime', title: '发布时间',  sort: false,width:'10%'
                                ,templet:function(d){
                                    return new Date(d.createtime).toLocaleDateString();
                                }
                            }
                            , {field: 'viewNum', title: '浏览数',sort: false,width:'8%',align:'center'}

                        ]]
                        ,id:'postListId'
                        ,text:{
                            none:'暂无帖子！'
                        }
                    });
                });

            </script>
        </div>
        <div class="bbs_footerPush">
        </div>
    </div>
</div>
<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp" %>
</div>
</body>
</html>
