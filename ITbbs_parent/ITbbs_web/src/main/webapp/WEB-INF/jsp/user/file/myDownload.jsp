<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>下载历史记录</title>
    <%@include file="/WEB-INF/jsp/inc/commonStaticResource.jsp" %>
</head>
<body>
<div class="bbs_container">
    <div class="bbs_header">
        <%@ include file="/WEB-INF/jsp/inc/top.jsp" %>
        <%@ include file="/WEB-INF/jsp/inc/userNavbar.jsp" %>
    </div>
    <div class="bbs_page">
        <table lay-filter="fileList" id="fileList" border="1"
               style="width: 100%;margin-top: 55px;text-align: center;display: none;">
        </table>
        <script>
            layui.use('table', function () {
                var table = layui.table;
                table.render({
                    elem: '#fileList'
                    , height: 500
                    , url: '${path}/file/listUploadFileByUserId.do' //数据接口
                    , page: true //开启分页
                    , cols: [[ //表头
                        {field: 'filename', title: '文件名',width:'15%'}
                        , {field: 'introduce', title: '介绍',width:'38%'}
                        , {field: 'createtime', title: '上传时间',width:'18%',align: 'center'
                            , templet: function (d) {
                                return new Date(d.createtime).toLocaleString();
                            }
                        }
                        , {field: 'downloadNum', title: '下载次数', align: 'center',width:'12%'}
                        , {field: 'username', title: '上传者', align: 'center',width:'12%'}
                        , {field: 'score', title: '积分',align: 'center',width:'8%'}
                        , {align: 'center', toolbar: '#bar'}
                    ]]
                    , id: 'fileListId'
                    , text: {
                        none: '你暂未下载过文件！'
                    }
                });
                //监听工具条
                table.on('tool(fileList)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-interceptor="对应的值"
                    var data = obj.data; //获得当前行数据
                    var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                    var tr = obj.tr; //获得当前行 tr 的DOM对象
                    var url = path + "/file/download.do?fileId=" + data.id;
                    if (layEvent === 'download') { //查看
                        alert("oj");
                        var param = {};
                        param.fileId = data.id;
                        console.log(param);
                        $.ajax({
                            url: path + '/file/checkDownloadQX'
                            ,data:param
                            ,type:'POST'
                            ,async:true
                            ,success:function (result) {
                                if(result.code==0){
                                    // window.open(url);
                                    var downloadNum = data.downloadNum+1
                                    obj.update({
                                        downloadNum:downloadNum
                                    });
                                    window.location.href = url;
                                }else{
                                    layer.msg(result.msg);
                                }
                            }
                        });
                        // window.location.href = path + "/file/download.do?fileId=" + file.id;

                    }
                });
            });
        </script>
        <script type="text/html" id="bar">
            <a class="layui-btn layui-btn-xs" lay-event="download">下载</a>
            <%--<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>--%>
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
