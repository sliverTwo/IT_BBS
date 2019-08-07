<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>问题详情</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp" %>
    <style>
        .question_title {
            color: #333;
            font-size: 20px;
            font-weight: normal;
            margin-bottom: 5px;
            margin-top: 10px;
        }

        .question_title, .question_content, .answered {
            padding-left: 30px;
        }

        #bar {
            text-align: right;
        }

        .question_content {
            font-size: 14px;
            overflow: hidden;
            position: relative;
            color: #666;
            line-height: 24px;
            word-break: break-all;
            word-wrap: break-word;
            margin-top: 10px;
        }

        .answer {
            min-height: 150px;
        }

        .answer_count {
            height: 40px;
            border-bottom: 1px solid #eee;
            font-size: 16px;
            height: 50px;
            line-height: 50px;
            float: left;
            margin-left: 20px;
            color: #333;
        }

        .editAnswer {
            margin-bottom: 20px;
        }

        .page {
            margin-top: 20px;
            margin-left: 18%;
            width: 60%;
            background: white;
            font-size: 14px;
            padding: 0 20px 50px;
        }
    </style>
    <script src="${path}/js/commonScript.js"></script>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp" %>
    </div>
    <div class="page">
        <%--问题详情区--%>
        <div id="question">
            <%--提问信息--%>
            <div style="padding: 10px 0px 5px  30px;">
                <img src="${question.pic}" width="35px" height="35px" alt="${question.username}">
                <a href="${path}/toUserInfo.do?userId=${question.questionUserId}">
                    <span style="margin-left: 15px;">${question.username}</span>
                </a>
                <span>
                于 <script>document.write(new Date('${question.createtime}').toLocaleString());</script>
                提问</span>
            </div>
            <hr class="layui-bg-gray">
            <%--问题--%>
            <div>
                <%--标题--%>
                <span class="question_title">
                    ${question.title}<span class="layui-badge" style="margin-left: 5px;">积分：${question.payScore}</span>
                </span><br>
                <%--内容--%>
                <div class="question_content">
                    ${question.question}
                </div>
                <div id="bar">
                    <span class="layui-breadcrumb" lay-separator="|">
                      <%--<a href="">分享</a>--%>
                      <%--<a href="">收藏</a>--%>
                    </span>
                </div>
            </div>
        </div>
        <hr class="layui-bg-gray">
        <div class="answer_count">
            <p><span id="count">${answerCount}</span>个回答</p>
        </div>
        <%--相关回答区--%>
        <div class="answer" id="answerList">
            <%--回答者信息--%>
            <%--<c:forEach var="a" items="${answerList}">--%>
                <%--<hr class="layui-bg-gray">--%>
                <%--<div class="answered">--%>
                    <%--<div style="margin-bottom: 10px;">--%>
                        <%--<a href="">--%>
                            <%--<img src="${a.pic}" alt="${a.username}" width="35px" height="35px">--%>
                                <%--${a.username}--%>
                        <%--</a>--%>
                        <%--于 <fmt:formatDate value="${a.createtime}" pattern="yyyy/MM/dd HH:mm:ss"/>--%>
                        <%--回答--%>
                        <%--<span style="float: right ;">--%>
                            <%--<c:if test="${not empty logUser && logUser.id == question.questionUserId}">--%>
                                <%--<c:if test="${empty question.usefulAnswerId}">--%>
                                    <%--<button id="${a.id}" class="ackBtn layui-btn layui-btn-sm"--%>
                                            <%--onclick="ackAnswer('${a.id}')">采用--%>
                                    <%--</button>--%>
                                <%--</c:if>--%>
                            <%--</c:if>--%>
                            <%--<c:if test="${not empty question.usefulAnswerId &&  a.id == question.usefulAnswerId}">--%>
                                <%--<span style="letter-spacing: 2px;" class="layui-btn layui-btn-sm">--%>
                                    <%--已采用<i class="layui-icon">&#xe605;</i>--%>
                                <%--</span>--%>
                            <%--</c:if>--%>
                        <%--</span>--%>
                    <%--</div>--%>
                    <%--<div class="question_content">--%>
                            <%--${a.content}--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</c:forEach>--%>
            <%--回答编辑区--%>
            <script>
                layui.use('flow', function () {
                    var $ = layui.jquery; //不用额外加载jQuery，flow模块本身是有依赖jQuery的，直接用即可。
                    var flow = layui.flow;
                    flow.load({
                        elem: '#answerList' //指定列表容器
                        , isAuto: false
                        , done: function (page, next) { //到达临界点（默认滚动触发），触发下一页
                            var lis = [];
                            //以jQuery的Ajax请求为例，请求下一页数据（注意：page是从2开始返回）
                            $.get('${path}/answer/answerList.do?questionId=${question.id}&page=' + page, function (res) {
                                // console.log(res);
                                //假设你的列表返回在data集合中
                                layui.each(res.data, function (index, item) {
                                    var str = '<hr class="layui-bg-gray"><div class="answered"><div style="margin-bottom: 10px;">';
                                    str += '<img src="';
                                    str += item.pic;
                                    str += '" width="35px" height="35px"" alt="">';
                                    str += '<a style="margin-left: 15px;" href="${path}/toUserInfo.do?userId=';
                                    str += item.userId;
                                    str += '">';
                                    str += item.username;
                                    str += '</a> 于 ';
                                    str += new Date(item.createtime).toLocaleString();
                                    str += ' 回答<span style="float: right ;">';
                                    <c:if test="${not empty logUser && logUser.id == question.questionUserId && empty question.usefulAnswerId}">
                                        str += '<button id="';
                                        str+=  item.id + '" class="ackBtn layui-btn layui-btn-sm"';
                                        str += ' onclick="ackAnswer(\''+ item.id + '\')">采用</button>';
                                    </c:if>
                                    <c:if test="${not empty question.usefulAnswerId }">
                                        if(item.id == '${question.usefulAnswerId}'){
                                            str += '<span style="letter-spacing: 2px;" class="layui-btn layui-btn-sm">';
                                            str += '已采用<i class="layui-icon">&#xe605;</i></span>';
                                        }
                                    </c:if>
                                    str += '</span></div><div class="question_content">';
                                    str += item.content;
                                    str += '</div></div>';
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
        </div>
        <c:if test="${(not empty logUser )&&(logUser.id != question.questionUserId) && empty question.usefulAnswerId}">
            <hr class="layui-bg-gray">
            <div class="editAnswer">
                <div>
                    <textarea id="answerContent" name="content" style="display: none;"></textarea>
                    <script>
                        var layedit;
                        var index;
                        layui.use(['layedit'], function () {
                            layedit = layui.layedit;
                            layedit.set({
                                uploadImage: {
                                    url: '${path}/upload/uploadImg.do' //接口url
                                    , type: 'question' //默认question
                                }
                            });
                            index = layedit.build('answerContent', {
                                height: 150
                            }); //建立编辑器
                        });
                    </script>
                </div>
                <div style="margin-top: 10px; text-align: right;">
                    <input class="layui-btn layui-btn-normal" id="submit_new_question_form"
                           name="commit" type="submit" onclick="submitAnswer()"
                           value="我要回答">
                </div>
            </div>
        </c:if>
    </div>
    <div class="bbs_footerPush">
    </div>
</div>

<div class="bbs_footer">
    <%@ include file="/WEB-INF/jsp/inc/foot.jsp" %>
</div>
</body>
<%--回答问题--%>
<script>
    var userId = "${logUser.id}";
    var qId = "${question.id}";

    function submitAnswer() {
        if ($.trim(userId) == "") {
            layer.alert("请先登陆");
            return false;
        }

        var param = {};
        param.userId = userId;
        param.questionId = qId;
        param.content = layedit.getContent(index);
        if ($.trim(param.content).length <= 0) {
            layer.alert("回答不能为空！");
            return false;
        }
        console.log(param);
        $.ajax({
            type: "POST",
            url: "${path}/answer/saveAnswer.do",
            data: param,
            dataType: "json",
            async: true,
            success: function (result) {
                if (result.code == 0) {
                    <%--window.location.href="${path}/user/index.do";--%>
                    console.log(result);
                    $("#answerList").prepend(replyString(param.content, result.data));
                    var a = $("#answerList").offset().top;
                    $("html,body").animate({scrollTop: a}, 'slow');
                    index = layedit.build('answerContent');
                    // 增加回答数
                    var count = Number.parseInt($('#count').text()) + 1;
                    $('#count').text(count);
                } else {
                    layer.msg(result.msg);
                    // window.location.reload();
                }
            }
        });
    }

    function replyString(content, time) {
        var str = '<hr class="layui-bg-gray">';
        str += '<div class="answered"> <div style="margin-bottom: 10px;">';
        str += '<a href="${path}/toUserInfo.do?userId=${logUser.id}">';
        str += '<img src="${logUser.pic}" alt="${logUser.username}" width="35px" height="35px">';
        str += ' ${logUser.username}</a> 于 ';
        str += tolocalTime(time)
        str += '回答 </div> <div class="question_content">';
        str += content;
        str += '</div></div>';
        return str;
    }

    // 确认答案
    function ackAnswer(answerId) {
        if (answerId.length < 32) {
            return false;
        }
        var param = {};
        param.answerId = answerId;
        param.questionId = qId;
        $.post("${path}/answer/ackAnswer.do", param, function (result) {
            // 确认成功
            if (result.code == 0) {
                $('#' + answerId).removeClass('ackBtn').html('已采用<i class="layui-icon">&#xe605;</i>');
                $('.ackBtn').remove();
            } else {
                layer.msg(result.msg);
            }
        }, 'json');
        console.log(answerId);
    }
</script>
</html>
