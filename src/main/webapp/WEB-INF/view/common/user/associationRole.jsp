<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/6/18
  Time: 13:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/plugin/bootstrapV3/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/plugin/font/font-awesome-4.7.0/css/font-awesome.min.css">
</head>
<body>
<div class="container">
    <form id="form" method="POST" role="form">
        <input type="hidden" name="userid" value="${user.id}">
        <div class="form-group">
            <input type="checkbox" checked name="roleids" value="" style="display: none;">
                <c:if test="${roles.size()!=0}">
                    <c:forEach var="item" items="${roles}">
                        <input type="checkbox" name="roleids" value="${item.id}"  <c:if test="${item.ischeck==true}">checked</c:if>>${item.rolename}
                    </c:forEach>
                </c:if>
        </div>
        <button id="login-btn" type="submit" class="btn btn-primary">保存</button>
        <button  type="reset" class="btn btn-default">重置</button>
        <a  type="button" class="btn btn-warning" href="/user">返回</a>
    </form>
</div>
<script type="text/javascript" src="https://cdn.bootcss.com/jquery/2.2.4/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/plugin/bootstrapV3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/js/serializeObject.js"></script>
<script type="text/javascript">
    $(function () {
        $('#login-btn').click(function(e){
            event.preventDefault();
            $.ajax({
                url:'/user/addRole',
                data:$('#form').serializeObject(),
                dataType:'json',
                type:'post',
                success:function(data){
                    if(data=="1"){
                        alert("修改成功！");
                        setTimeout("location.href=\"/user\"", 1000 );
                    } else{
                        lert("失败!")
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("错误!")
                }
            });
        })
    })
</script>
</body>
</html>
