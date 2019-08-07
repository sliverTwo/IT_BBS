<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>${post.title}</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp" %>
    <style>
        .detail_title {

            word-break: break-all;
            word-wrap: break-word;
            background: inherit;
            padding-left: 20px;
            margin-right: 5px;
        }

        .post_title {
            width: 100%;
            background: #006699;
            color: #fff;
            font-size: 18px;
            line-height: 36px;
        }

        .user_info {
            font-size: 14px;
            text-align: center;
            background: #eff4fb;
            line-height: 24px;
        }

        .post_body {
            word-wrap: break-word;
            overflow: hidden;
            padding: 16px;
            font-size: 14px;
            line-height: 28px;
            height: 90%;
        }

        .post_reply {
            margin: 8px 0;
            box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.05);
            margin: 8px 0;
            border: 1px solid #ddd;
        }

        .reply {
            display: block;
            padding: 20px 10px;
            margin-top: 10px;
            border: 1px solid #A9CBEE;
        }

        .notice {
            margin: 20px 0 0 0;
            padding: 10px 10px 10px 25px;
            border: 1px solid #A9CBEE;
        }

        .detail_tbox {
            position: relative;
            z-index: 999;
            margin-left: 20%;
        }

        .detail_title_fixed {
            width: 60%;
            height: 39px;
            overflow: hidden;
            border: 1px #198cc5 solid;
            font: normal normal 15px/39px "Microsoft YaHei";
            color: #006699;
            background: #fff;
            box-shadow: 0 0 4px rgba(0, 0, 0, 0.4)
        }

        .title {
            float: left;
            max-width: 680px;
            overflow: hidden;
            line-height: 39px;
            margin: 0 0 0 15px;
            padding: 0;
            font-size: 15px;
        }

        .fixed-r {
            float: right;
            margin: 0px 6px 0 0;
        }

        .post_info {
            height: 28px;
            border-top: 1px solid #A9CBEE;
            padding: 0 10px;
            line-height: 28px;
            background: #ffffff;
            border-top: 1px solid #ddd;
            font-size: 14px;
            color: #999;
        }
    </style>
    <script>
        <c:if test="${empty post}">
        alert("该帖子已被删除！");
        history.go(-1);
        </c:if>

        function deleteReply(postReplyId) {
            var url = "${path}/postReply/deleteReply.do";
            var param = {};
            param.postReplyId = $.trim(postReplyId);
            del(param, url);
        }

        function del(param, url) {
            layui.use('layer', function () {
                var layer = layui.layer;
                layer.prompt({
                    formType: 2,
                    value: '',
                    title: '请输入删除原因',
                    area: ['500px', '150px'] //自定义文本域宽高
                }, function (value, index, elem) {
                    console.log(value);
                    param.reason = value;
                    // 向服务器发送冻结请求。
                    $.post(url, param, function (result) {
                        if (result.code == 0) {
                            layer.msg("删除成功！", {icon: 1});
                            history.go(-1);
                            window.location.reload();
                        } else {
                            layer.msg(result.msg, {icon: 1});
                        }

                    }, 'json');
                    layer.close(index);
                });
            });
        }

        $(function () {
            <c:if test="${post.isTop == false}">
            $('#topSpan').hide();
            $('#topSpan').text("");
            </c:if>
            $('.delete_post').click(function () {
                var postId = '${post.id}';
                var url = "${path}/post/deleteByPostOther.do";
                var param = {};
                param.postId = $.trim(postId);
                del(param, url);
            });
            $('.top_post').click(function () {
                var text = $('#topSpan').text();
                var postId = '${post.id}';
                $.post("${path}/post/dealTop.do", {postId: postId}, function (result) {
                    if (result.code == 0) {
                        if (text.length > 0) {
                            $('#topSpan').text("");
                            $('#topSpan').hide();
                            $('.top_post').text("置顶");
                        } else {
                            $('#topSpan').text("置顶");
                            $('#topSpan').show();
                            $('.top_post').text("取消置顶");
                        }
                    }
                }, 'json');
            });
        })

    </script>
    <script>
        var userId = "${logUser.id}";
        var username = "${logUser.username}";
        var pic = "${logUser.pic}";
        var postNum = "${logUser.postNum}";
        var pId = "${post.id}";

        function submitPostReply() {
            if ($.trim(userId) == "") {
                layer.alert("请先登陆");
                return false;
            }

            var param = {};
            param.userId = userId;
            param.username = username;
            param.postId = pId;
            param.content = layedit.getContent(index);
            if ($.trim(param.content).length <= 0) {
                layer.alert("回复不能为空！");
                return false;
            }
            console.log(param);
            $.ajax({
                type: "POST",
                url: "${path}/postReply/savePostReply.do",
                data: param,
                dataType: "json",
                async: true,
                success: function (data) {
                    var result = data;
                    if (result.code == 0) {
                        <%--window.location.href="${path}/user/index.do";--%>
                        console.log(result);
                        $("#replyList").prepend(replyString(pic, username, postNum, param.content));
                        var a = $("#replyList").offset().top;
                        $("html,body").animate({scrollTop: a}, 'slow');
                        index = layedit.build('postContent');
                    } else {
                        layer.msg(result.msg);
                        // window.location.reload();
                    }
                }
            });
        }

        function replyString(pic, username, postNum, content) {
            var str = '<table class="post_reply"><tr><td valign="top" class="user_info" rowspan="2">';
            str += '<dl style="margin: 0 auto;padding: 8px;" width="10%;">';
            str += '<img src="';
            str += pic;
            str += '" width="88px" height="88px;" alt="">';
            str += '<br><a href="${path}/toUserInfo.do?userId=';
            str += userId;
            str += '">';
            str += username;
            str += '</a><br>';
            str += '<label for="postNum">发帖数:</label><span name="psotNum" id="postNum">'
            str += postNum;
            str += '</span></dl></td><td width="90%;"><div class="post_body">';
            str += content;
            str += '</div></td></tr><tr><td valign="bottom"><div class="post_info" >回复于：';
            str += new Date().toLocaleString();
            <c:if test="${not empty logUser}">
            <c:if test="${logUser.level == 2 || logUser.id == board.userId}">
            str += '<a href="javascript:;" style="float: right;color: inherit;" ';
            str += 'onclick="deleteReply()">删除 </a></div>';
            </c:if>
            </c:if>
            str += '</td></tr></table>';
            return str;
        }
    </script>
    <script>
        $(function () {
            if (document.body.scrollTop < 160) {
                $("#toolBar").hide();
            }
            $(window).scroll(function () {
                if (document.body.scrollTop > 160) {
                    $("#toolBar").show();
                } else {
                    $("#toolBar").hide();
                }
            });
        });

        // 收藏帖子
        function toFavorite() {
            var param = {};
            param.postId = "${post.id}";
            param.userId = "${logUser.id}";
            param.postTitle = "${post.title}";
            if (param.userId.length < 0) {
                layer.msg("请先登陆！");
                // 跳至登陆页面
            }
            $.ajax({
                type: "post"
                , url: "${path}/favorite/addPost2Favorite"
                , data: param
                , dataType: "json"
                , success: function (result) {
                    if (result.code == 0) {
                        layer.msg("收藏成功!", {icon: 1});
                    } else {
                        layer.msg(result.msg, {icon: 2});
                    }
                }
            });

        }

        // 隐藏工具条
        function hideTool() {
            $("#toolBar").css("display", "none");
            $(window).unbind();
        }
    </script>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp" %>
    </div>
    <div style="margin: 10px 20%;  width: 60%">
        <div class="post_title">
            <span class="detail_title">${post.title}</span>[<a style="color: white;"
                                                               href="${path}/toBoardUI.do?boardId=${post.boardId}">
            ${post.boardName}</a>]
            <span class="layui-badge" id="topSpan">置顶</span>
            <span style="float: right;padding-right: 20px;">浏览数：${post.viewNum}</span>
        </div>
        <table width="100%" class="post_reply">
            <tr>
                <td valign="top" class="user_info" width="10%;" rowspan="2">
                    <%--坛主信息--%>
                    <dl style="margin: 0 auto;padding: 8px;">
                        <%--图片--%>
                        <img src="${pUser.pic}" width="88px" height="88px" alt="">
                        <br>
                        <a href="${path}/toUserInfo.do?userId=${pUser.id}">${pUser.username}</a><br>
                        <label for="postNum">发帖数:</label><span id="postNum">${pUser.postNum}</span>
                    </dl>
                </td>
                <td>
                    <div class="post_body">
                        ${post.content}
                    </div>
                </td>
            </tr>
            <tr>
                <td valign="bottom">
                    <div class="post_info">
                        发表于：
                        <script>
                            document.write(new Date('${post.createtime}').toLocaleString());
                        </script>
                        <c:if test="${not empty logUser}">
                            <span class="layui-breadcrumb" style="float: right;" lay-separator="|">
                                <a href="javascript:;" style="color: inherit;" onclick="toFavorite()">收藏</a>
                                <c:if test="${logUser.level == 2 || logUser.id == board.userId}">
                                    <a class="delete_post" href="javascript:;" style="color: inherit;">删除 </a>
                                    <c:if test="${post.isTop}">
                                        <a class="top_post" href="javascript:;" style="color: inherit;">取消置顶 </a>
                                    </c:if>
                                    <c:if test="${post.isTop == false}">
                                        <a class="top_post" href="javascript:;" style="color: inherit;">置顶 </a>
                                    </c:if>
                                </c:if>
                            </span>
                            <div style="float: right;">
                            </div>
                        </c:if>
                    </div>
                </td>
            </tr>
        </table>
        <hr class="layui-bg-blue">
        <div id="replyList">
            <%--<c:forEach var="r" items="${postReplyList}">--%>
            <%--<table class="post_reply">--%>
            <%--<tr>--%>
            <%--<td valign="top" class="user_info" rowspan="2">--%>
            <%--&lt;%&ndash;坛主信息&ndash;%&gt;--%>
            <%--<dl style="margin: 0 auto;padding: 8px;" width="10%;">--%>
            <%--&lt;%&ndash;图片&ndash;%&gt;--%>
            <%--<img src="${r.pic}" width="88px" height="88px;" alt="">--%>
            <%--<br><a href="${path}/toUserInfo.do?userId=${r.userId}">${r.username}</a><br>--%>
            <%--<label for="postNum">发帖数:</label><span name="psotNum" id="postNum">${r.postNum}</span>--%>
            <%--</dl>--%>
            <%--</td>--%>
            <%--<td width="90%;">--%>
            <%--<div class="post_body">--%>
            <%--${r.content}--%>
            <%--</div>--%>
            <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
            <%--<td valign="bottom">--%>
            <%--<div class="post_info" >--%>
            <%--回复于：--%>
            <%--<script>--%>
            <%--document.write(new Date('${r.createtime}').toLocaleString());--%>
            <%--</script>--%>
            <%--&lt;%&ndash;<fmt:formatDate value="${post.createtime}" pattern="yyyy-MM-dd hh:mm:ss"/>&ndash;%&gt;--%>
            <%--<a href="javascript:;" style="float: right;color: inherit;">删除 </a>--%>
            <%--</div>--%>
            <%--</td>--%>
            <%--</tr>--%>
            <%--</table>--%>
            <%--</c:forEach>--%>
        </div>
        <script>
            layui.use('flow', function () {
                var $ = layui.jquery; //不用额外加载jQuery，flow模块本身是有依赖jQuery的，直接用即可。
                var flow = layui.flow;
                flow.load({
                    elem: '#replyList' //指定列表容器
                    , isAuto: false
                    , done: function (page, next) { //到达临界点（默认滚动触发），触发下一页
                        var lis = [];
                        //以jQuery的Ajax请求为例，请求下一页数据（注意：page是从2开始返回）
                        $.get('${path}/postReply/postReplyList.do?postId=${post.id}&page=' + page, function (res) {
                            //假设你的列表返回在data集合中
                            layui.each(res.data, function (index, item) {
                                var str = '<table class="post_reply"><tr><td valign="top" class="user_info" rowspan="2">';
                                str += '<dl style="margin: 0 auto;padding: 8px;" width="10%;">';
                                str += '<img src="';
                                str += item.pic;
                                str += '" width="88px" height="88px;" alt="">';
                                str += '<br><a href="${path}/toUserInfo.do?userId=';
                                str += item.userId;
                                str += '">';
                                str += item.username;
                                str += '</a><br>';
                                str += '<label for="postNum">发帖数:</label><span name="psotNum" id="postNum">'
                                str += item.postNum;
                                str += '</span></dl></td><td width="90%;"><div class="post_body">';
                                str += item.content;
                                str += '</div></td></tr><tr><td valign="bottom"><div class="post_info" >回复于：';
                                str += new Date(item.createtime).toLocaleString();
                                <c:if test="${not empty logUser}">
                                <c:if test="${logUser.level == 2 || logUser.id == board.userId}">
                                str += '<a href="javascript:;" style="float: right;color: inherit;" ';
                                str += 'onclick="deleteReply(\'' + item.id + '\')">删除 </a></div>';
                                </c:if>
                                </c:if>
                                str += '</td></tr></table>';
                                lis.push(str);
                            });
                            //执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
                            //pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多

                            next(lis.join(''), page < res.count);
                        });
                    }
                });
            });
        </script>
        <c:if test="${not empty logUser}">
            <div id="new_reply" class="reply">
                <div>
                    <textarea id="postContent" name="content" style="display: none;"></textarea>
                    <script>
                        var index;
                        var layedit;
                        layui.use(['layedit'], function () {
                            layedit = layui.layedit;
                            layedit.set({
                                uploadImage: {
                                    url: '${path}/upload/uploadImg.do' //接口url
                                    , type: 'post' //默认post
                                }
                            });
                            index = layedit.build('postContent', {
                                height: 150
                            }); //建立编辑器
                        });
                    </script>
                </div>
                <div style="margin-top: 10px; text-align: right;">
                    <input class="layui-btn layui-btn-normal" id="submit_new_post_form" onclick="submitPostReply()"
                           name="commit" type="submit"
                           value="提交回复">
                </div>
                <ol class="notice">
                    <li>请遵守IT家园<a href="/help#user_criterion" rel="nofollow">用户行为准则</a>，不得违反国家法律法规。</li>
                    <li>转载文章请注明出自“IT家园（www.xxx.xxx）”。如是商业用途请联系原作者。</li>
                    <li>为了维护良好的技术讨论环境，请不要讨论政治 相关话题。</li>
                </ol>
            </div>
        </c:if>
    </div>
    <c:if test="${not empty logUser}">
        <div id="toolBar" class="detail_tbox">
            <div class="detail_title_fixed"
                 style="display: block; position: fixed; top: 0px; border: 1px solid rgb(25, 140, 197); z-index: 99999;">
                <span class="title text_overflow">${post.title} [
                    <a style="color: inherit;" href="${path}/toBoardUI.do?boardId=${post.boardId}">
                            ${post.boardName}
                    </a>]</span>
                <div class="fixed-r">
                    <a href="#new_reply" class="layui-btn layui-btn-sm">快速回复</a>
                    <a href="javascript:;" onclick="toFavorite()" class="layui-btn layui-btn-sm">收藏帖子</a>
                    <c:if test="${logUser.level == 2 || logUser.id == board.userId}">
                    <c:if test="${post.isTop}">
                        <a class="top_post layui-btn layui-btn-sm" href="javascript:;">取消置顶 </a>
                    </c:if>
                    <c:if test="${post.isTop == false}">
                        <a class="top_post layui-btn layui-btn-sm" href="javascript:;">置顶 </a>
                    </c:if>
                    </c:if>
                    <button class="layui-btn layui-btn-sm" onclick="hideTool()">
                        <i class="layui-icon">&#x1006;</i>
                    </button>
                </div>
            </div>
        </div>
    </c:if>
    <div class="bbs_footerPush">
    </div>
</div>

<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp" %>
</div>
</body>
</html>
