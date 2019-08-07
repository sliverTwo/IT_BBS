<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>积分充值</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp" %>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp" %>
        <%@ include file="/WEB-INF/jsp/inc/userNavbar.jsp" %>
    </div>
    <div class="bbs_page">
        <div style="margin-left: 25%;margin-top: 5%;">
            <form action="" class="layui-form">
                <div class="layui-form-item">
                    <label class="layui-form-label">当前积分</label>
                    <div class="layui-input-block" style="padding-top: 10px;">
                        <label>${logUser.score}</label>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">充值积分</label>
                    <div class="layui-input-block" style="width: 200px;">
                        <select id="score" name="score" lay-filter="scoreFilter">
                            <option value="10">10</option>
                            <option value="20">20</option>
                            <option value="50">50</option>
                            <option value="100">100</option>
                            <option value="200">200</option>
                            <option value="500">500</option>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">金额</label>
                    <div class="layui-input-block" style="padding-top: 10px;">
                        <span id="amount">1</span><span>元</span>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit lay-filter="form">充值</button>
                        <button type="reset" id="back" class="layui-btn layui-btn-primary" >返回</button>
                    </div>
                </div>
            </form>
        </div>
        <script>
            $(function () {
                $('#back').click(function () {
                        var link = '${path}/user/index.do';
                        window.location.href = link;
                    });
                layui.use('form', function () {
                    var form = layui.form;

                    //监听提交
                    form.on('submit(form)', function (data) {
                        var param = {};
                        param.score = data.field.score;
                        param.money = param.score / 10;
                        param.userId = "${logUser.id}";
                        httpPost("${path}/order/pay",param);
                        return false;
                    });
                    form.on('select(scoreFilter)', function(data){
                        console.log(data.value); //得到被选中的值
                        $('#amount').text(data.value / 10);
                    });
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
