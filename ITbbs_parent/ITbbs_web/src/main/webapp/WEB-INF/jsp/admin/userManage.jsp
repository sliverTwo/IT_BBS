<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>用户管理</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp" %>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp" %>
    </div>
        <div style="float: left;margin: 0 10px 0 0;padding: 0;">
            <%@include file="/WEB-INF/jsp/inc/adminNavbar.jsp" %>
        </div>
        <div style="margin-top: 0px;">
            <table id="userList" lay-filter="userList" >
            </table>
            <script type="text/html" id="bar">
                    <a class="layui-btn layui-btn-xs" lay-event="del">冻结</a>
                <!-- 这里同样支持 laytpl 语法，如： -->
                    <a class="layui-btn layui-btn-xs" lay-event="start">启用</a>
            </script>
            <script>
                layui.use(['table', 'layer'], function () {
                    var table = layui.table;
                    var layer = layui.layer;
                    //转换静态表格
                    table.init('userList', {
                        // height: 550 //设置高度
                         limit: 4 //注意：请务必确保 limit 参数（默认：10）是与你服务端限定的数据条数一致
                        , skin: 'nob'
                        , even: true

                    });
                    table.render( {
                        elem:'#userList'
                        // ,height: 450 //设置高度
                        ,url:'${path}/user/listUser.do' //数据接口
                        // , skin: 'nob'
                        , even: true
                        , text:{
                            none:'暂无板块信息'
                        }
                        ,cols: [[ //表头
                            {field: 'username',  title: '用户名',width:'8%'}
                            , {field: 'mail', title: '邮箱',width:'15%',align:'center'}
                            , {field: 'postNum', title: '发帖数',width:'8%',align:'center'}
                            , {field: 'score', title: '积分',width:'5%',align:'center'}
                            , {field:'createtime' , title: '注册日期',width:'15%',align:'center'
                                ,templet:function(d){
                                    return new Date(d.createtime).toLocaleString();
                                }
                            }
                            , {field: 'lastLoginTime', title: '最后登陆时间',width:'15%',align:'center'
                                ,templet:function(d){
                                    return new Date(d.lastLoginTime).toLocaleString();
                                }
                            }
                            , {field: 'deleted', title: '状态',sort: true,width:'8%',align:'center'
                                ,templet:function(d){
                                    if(d.deleted){
                                        return "冻结";
                                    }
                                    return "使用中"
                                }
                            }
                            ,{ width:'10%', align:'center', toolbar: '#bar'}
                        ]]


                    });
                    table.on('tool(userList)', function (obj) {
                        console.log(obj);
                        var layEvent = obj.event;
                        var data = obj.data;
                        if(layEvent == 'del'){
                            if(data.deleted){
                                layer.alert('该用户已经被冻结！');
                                return false;
                            }

                            layer.prompt({
                                formType: 2,
                                value: '',
                                title: '请输入冻结原因',
                                area: ['500px', '150px'] //自定义文本域宽高
                            }, function(value, index, elem){
                                console.log(value);
                                var param = {};
                                param.userId = data.id;
                                param.reason = value;
                                // 向服务器发送冻结请求。
                                $.post("${path}/user/freezeUser.do",param,function (result) {
                                    if(result.code == 0){
                                        layer.msg("冻结成功！",{icon:1})
                                        //执行重载
                                        table.reload('userList');
                                    }else{
                                        layer.msg(result.msg,{icon:1});
                                    }

                                },'json');
                                layer.close(index);
                                // 删除按钮禁用
                            });
                        }
                        if(layEvent == 'start'){
                            if(!data.deleted){
                                layer.alert('该用户正在使用中！');
                                return false;
                            }
                            layer.prompt({
                                formType: 2,
                                value: '',
                                title: '请输入启用原因',
                                area: ['500px', '150px'] //自定义文本域宽高
                            }, function(value, index, elem){
                                var param = {};
                                param.userId = data.id;
                                param.reason = value;
                                // 向服务器发送冻结请求。
                                $.post("${path}/user/launchUser.do",param,function (result) {
                                    if(result.code == 0){
                                        layer.msg("启用成功！",{icon:1});
                                        //执行重载
                                        table.reload('userList');
                                    }else{
                                        layer.msg(result.msg,{icon:2});
                                    }

                                },'json');
                                layer.close(index);
                            });
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
<div id="delReason" style="display: none;">
    <div class="layui-input-block">
        <textarea name="desc" placeholder="请输入内容" class="layui-textarea"></textarea>
    </div>
</div>
</html>

