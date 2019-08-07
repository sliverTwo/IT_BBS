<%@ page  pageEncoding="utf-8"%>
<div >
    <span>
        友情链接:
        <a href="https://www.baidu.com/" target="_blank" style="padding-right: 15px;">百度</a>
        <a href="https://www.csdn.net/" target="_blank" style="padding-right: 15px;">CSDN</a>
        <a href="http://www.runoob.com/" target="_blank" style="padding-right: 15px;">菜鸟教程</a>
    </span>
    <span style="margin-left: 23%">
        <a href="mailto:${adminMail}">联系管理员</a>
        &copy; 2017-2018
    </span>

</div>

<script type="text/javascript">
    function updateuseronlinetime(){
        $.ajax({
            type: "POST",
            url: "${path}/common/updateuseronlinetime.do",
            async: true,
            success: function(data){
            }
        });
    }
    /* setInterval("updateuseronlinetime()",30000); */
</script>
<%@ include file="/WEB-INF/jsp/inc/commonfoot.jsp"%>