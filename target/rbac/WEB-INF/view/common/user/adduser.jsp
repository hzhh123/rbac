<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/plugin/bootstrapV3/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/plugin/font/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/plugin/bootstrapvalidator/css/bootstrapValidator.min.css">
</head>
<body>
<div class="container">
    <fieldset>
        <c:choose>
            <c:when test="${user==null}">
                <legend>添加用户</legend>
            </c:when>
            <c:otherwise>
                <legend>修改用户</legend>
            </c:otherwise>
        </c:choose>
    </fieldset>
    <form id="form" method="POST" role="form">
        <input type="hidden" value="${user.id}" name="id">
        <div class="form-group">
            <input type="text" class="form-control" name="username"  placeholder="用户名" value="${user.username}"></div>
        <div class="form-group">
            <input type="password" class="form-control" name="password" placeholder="密码" value="${user.password}"></div>
        <div class="form-group">
            <c:if test="${user==null}">
                <input type="radio" name="statue" value="1" checked>有效
                <input type="radio" name="statue" value="0">无效
            </c:if>
            <c:if test="${user!=null}">
                <input type="radio" name="statue" value="1" <c:if test="${user.statue==1}">checked</c:if>>有效
                <input type="radio" name="statue" value="0" <c:if test="${user.statue==0||user.statue==null}">checked</c:if>>无效
            </c:if>
        </div>
        <div class="form-group">
            <input type="checkbox" checked name="roleids" value="" style="display: none;">
            <c:if test="${user!=null}">
                <c:if test="${roles.size()!=0}">
                    <c:forEach var="item" items="${roles}">
                        <input type="checkbox" name="roleids" value="${item.id}"  <c:if test="${item.ischeck==true}">checked</c:if>>${item.rolename}
                    </c:forEach>
                </c:if>
            </c:if>
            <c:if test="${user==null}">
                <c:forEach var="item" items="${roles}">
                    <input type="checkbox" name="roleids" value="${item.id}">${item.rolename}
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
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/plugin/bootstrapvalidator/js/bootstrapValidator.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/plugin/bootstrapvalidator/js/language/zh_CN.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/js/serializeObject.js"></script>
<script type="text/javascript">
    $(function () {
        $('form').bootstrapValidator({
            message: '输入值无效',
            feedbackIcons: {/*输入框不同状态，显示图片的样式*/
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {/*验证*/
                username: {/*键名和input name值对应*/
                    message: '用户名无效',
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '用户名不能为空'
                        },
                        regexp: {/* 只需加此键值对 */
                            regexp: /^[a-zA-Z0-9_\.]+$/,
                            message: '只能是数字和字母_.'
                        },
                        stringLength: {/*长度提示*/
                            min: 6,
                            max: 30,
                            message: '用户名长度必须在6到30之间'
                        }/*最后一个没有逗号*/
                        , threshold :  6 , //有6字符以上才发送ajax请求，（input中输入一个字符，插件会向服务器发送一次，设置限制，6字符以上才开始）
                    remote: {//ajax验证。server result:{"valid",true or false} 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}
                        url: '/user/validateUsername',//验证地址
                        message: '用户已存在',//提示消息
                        delay :  2000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                        type: 'POST'//请求方式
                        /**自定义提交数据，默认值提交当前input value
                         *  data: function(validator) {
                               return {
                                   password: $('[name="passwordNameAttributeInYourForm"]').val(),
                                   whatever: $('[name="whateverNameAttributeInYourForm"]').val()
                               };
                            }
                         */
                    }
                    }
                },
                password: {
                    message:'密码无效',
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        stringLength: {
                            min: 6,
                            max: 30,
                            message: '用户名长度必须在6到30之间'
                        },
                        different: {//不能和用户名相同
                            field: 'username',
                            message: '不能和用户名相同'
                        },
                        regexp: {/* 只需加此键值对 */
                            regexp: /^[a-zA-Z0-9_\.]+$/,
                            message: '只能是数字和字母_.'
                        }
                    }
                }

            }
        });

        $('#login-btn').click(function(e){
                event.preventDefault();
                $.ajax({
                    url:'/user/saveOrUpdate',
                    data:$('#form').serializeObject(),
                    dataType:'json',
                    type:'post',
                    success:function(data){
                        if(data=="1"){
                            location.href="/user";
                        }else if(data=="0"){
                            alert("用户名已存在");
                        } else{
                            alert("出错了!")
                        }
                    }
            });
        })

    })
</script>
</body>
</html>