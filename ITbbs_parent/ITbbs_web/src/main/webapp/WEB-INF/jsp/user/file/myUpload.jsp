<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
<head>
    <title>上传文件列表</title>
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
                        , {field: 'introduce', title: '介绍',width:'35%'}
                        , {field: 'createtime', title: '上传时间',width:'18%',align: 'center'
                            , templet: function (d) {
                                return new Date(d.createtime).toLocaleString();
                            }
                        }
                        , {field: 'downloadNum', title: '下载次数', align: 'center',width:'10%'}
                        , {field: 'score', title: '积分',align: 'center',width:'8%'}
                        , {align: 'center', toolbar: '#bar'}
                    ]]
                    , id: 'fileListId'
                    , text: {
                        none: '你暂未上传资源文件！'
                    }
                });
                //监听工具条
                table.on('tool(fileList)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-interceptor="对应的值"
                    var data = obj.data; //获得当前行数据
                    var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                    var tr = obj.tr; //获得当前行 tr 的DOM对象
                    var url = path + "/file/download"//?fileId=" + data.id;
                    if (layEvent === 'download') { //查看
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
                                    // var downloadNum = data.downloadNum+1;
                                    obj.update({
                                        downloadNum:data.downloadNum+1
                                    });
                                    // window.open(url);
                                    // window.location.href = url;
                                    downloadFile(url,data.id);
                                }else{

                                    layer.msg(result.msg);
                                }
                            }
                        });
                        // window.location.href = path + "/file/download.do?fileId=" + file.id;

                    }else if(layEvent === 'del'){
                        layer.confirm('确认删除？',{icon:3,title:'提示'},function (index) {
                            $.post('${path}/file/deleteFile.do',{fileId:data.id},function(reslut){
                                if(reslut.code == 0){
                                    obj.del();
                                }else{
                                    layer.msg(result.msg,{icon:1});
                                }
                            },'json');
                            layer.close(index);
                        });
                    }
                });
            });
            function downloadFile(url,fileid){

                //定义一个form表单,通过form表单来发送请求
                var form=$("<form>");

                //设置表单状态为不显示
                form.attr("style","display:none");

                //method属性设置请求类型为post
                form.attr("method","post");
                form.attr("target","");
                //action属性设置请求路径,
                //请求类型是post时,路径后面跟参数的方式不可用
                //可以通过表单中的input来传递参数
                form.attr("action",url);
                $("body").append(form);//将表单放置在web中

                //在表单中添加input标签来传递参数
                //如有多个参数可添加多个input标签
                var input1=$("<input>");
                input1.attr("type","hidden");//设置为隐藏域
                input1.attr("name","fileId");//设置参数名称
                input1.attr("value",fileid);//设置参数值
                form.append(input1);//添加到表单中

                form.submit();//表单提交
            }

        </script>
        <script type="text/html" id="bar">
            <a class="layui-btn layui-btn-xs" lay-event="download">下载</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
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
