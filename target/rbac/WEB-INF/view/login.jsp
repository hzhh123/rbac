<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Title</title>
    <link rel="stylesheet" href="assets/admin/plugin/bootstrapV3/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/admin/plugin/font/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/admin/plugin/bootstrapvalidator/css/bootstrapValidator.min.css">
</head>
<body>
<div class="col-md-3 col-md-offset-4" style="background-color:#fff;position: relative;top:100px;padding:50px;border: 1px solid #ccc;">
    <fieldset>
        <legend>登陆</legend>
    </fieldset>
    <form id="login" method="POST" role="form">
        <div class="form-group">
            <input type="text" class="form-control" name="username"  placeholder="用户名"></div>
        <div class="form-group">
        <input type="password" class="form-control" name="password" placeholder="密码"></div>
        <!-- <div class="form-group">
            <a href=""><img src="assets/admin/image/loading.gif" alt=""></a>
        </div>
        <div class="form-group">
            <input type="text" class="form-control" name="code" placeholder="验证码">
        </div> -->

        <button id="login-btn" type="button" class="btn btn-primary">登陆</button>
    </form>
</div>
<script type="text/javascript" src="https://cdn.bootcss.com/jquery/2.2.4/jquery.js"></script>
<script type="text/javascript" src="assets/admin/plugin/bootstrapV3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="assets/admin/plugin/bootstrapvalidator/js/bootstrapValidator.js"></script>
<script type="text/javascript" src="assets/admin/plugin/bootstrapvalidator/js/language/zh_CN.js"></script>
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
                },
                code: {
                    validators: {
                        notEmpty: {
                            message: '不能为空'
                        }
                    }
                }
            }
        });

        $('#login-btn').click(function(){
            $.ajax({
              url:'/login',
              data:$('#login').serialize(),
              dataType:'json',
              type:'post',
              success:function(data){
                  if(data==1){
                      location.href="/index";
                   }else{
                    alert("用户名和密码不对!")
                   }
                }
            });
        })
            
    })
</script>
</body>
</html>