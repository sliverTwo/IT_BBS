<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>搜索结果</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp" %>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp" %>
        <div>
            <%--版块内帖子列表--%>
            <table id="postList" lay-filter="postList">
            </table>
            <script>
                var keyword = "${keyword}"?"${keyword}":"";
                layui.use('table', function () {
                    var table = layui.table;
                    table.render({
                        elem: '#postList'
                        , height: 500
                        , url: '${path}/post/listPostByKeyword.do' //数据接口
                        , where:{keyword:keyword}
                        , page: true //开启分页
                        ,skin:'nob'
                        ,even:true
                        , cols: [[ //表头
                            {field: 'title', title: '主题',width:'50%'
                                ,templet:function(d){
                                    var link = "<a href='${path}/post/toPost.do?postId="+d.id+"'>"+d.title+"</a>";
                                    return link;
                                }
                            }
                            , {field: 'createtime', title: '发布时间',  sort: true,width:'14%'
                                ,templet:function(d){
                                    return new Date(d.createtime).toLocaleString();
                                }
                            }
                            , {field: 'viewNum', title: '浏览',sort: true,width:'8%',align:'center'}
                            , {field: 'replyNum', title: '回复',sort: true,width:'8%',align:'center'}
                            , {field: 'boardName', title: '所属版块',width:'10%',align:'center'}
                            , {field: 'userName', title: '发布人',width:'10%',align:'center'}

                        ]]
                        ,id:'postListId'
                        ,text:{
                            none:'未找到符合条件的帖子！'
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
