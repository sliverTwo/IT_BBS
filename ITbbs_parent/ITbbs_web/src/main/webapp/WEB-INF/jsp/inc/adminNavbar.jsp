<%@ page contentType="text/html;charset=UTF-8"  %>
<ul class="layui-nav layui-nav-tree layui-bg-cyan" lay-filter="test" style="height: 100%">
    <!-- 侧边导航: <ul class="layui-nav layui-nav-tree layui-nav-side"> -->
    <li class="layui-nav-item">
        <a href="${path}/user/admin.do">用户管理</a>
    </li>
    <li class="layui-nav-item">
        <a href="${path}/board/toBoardListUI.do">版块管理</a>
    </li>
    <li class="layui-nav-item">
        <a href="${path}/admin/toApplyList.do">版主申请处理</a>
    </li>
    <li class="layui-nav-item">
        <a href="${path}/publicInfo/toListPublicInfoManageUI.do">公共信息管理</a>
    </li>
    <li class="layui-nav-item"><a href="${path}/basicSet/toBasicSetUI">基础设置</a></li>
    <li class="layui-nav-item"><a href="${path}/user/toListPage?url=changePassword">密码管理</a></li>
</ul>