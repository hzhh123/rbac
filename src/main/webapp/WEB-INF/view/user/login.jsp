<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/23
  Time: 18:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>登陆页面</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="asserts/scci/common/layui/css/layui.css">

    <style type="text/css">
        @media (min-width: 768px) {
            .login-box {
                position: fixed;
                top: 50%;
                left: 50%;
                border:1px solid #ccc;
                background-color: rgba(255, 255, 255, 1);
                -webkit-transform: translateX(-50%) translateY(-50%);
                transform: translateX(-50%) translateY(-50%);
            }
        }

        @media (max-width: 768px) {
        }
    </style>
</head>
<body>
<div class="layui-tab layui-tab-brief login-box" lay-filter="docDemoTabBrief">
    <ul class="layui-tab-title">
        <li class="layui-this">登陆</li>
        <li>注册</li>
    </ul>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show">
            <form class="layui-form " action="/login" id="loginForm">
                <div class="layui-form-item">
                    <label class="layui-form-label">用户名</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" required lay-verify="required|username" name="username"
                               autocomplete="off" placeholder="请输入用户名">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">密码</label>
                    <div class="layui-input-block">
                        <input type="password" class="layui-input" required lay-verify="required|password"
                               name="password" autocomplete="off" placeholder="请输入密码">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit="" lay-filter="login">立即提交</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="layui-tab-item">
            <form class="layui-form" action="" id="registerForm">
                <div class="layui-form-item">
                    <label class="layui-form-label">用户名</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" lay-verify="required|username" name="username"
                               autocomplete="off" placeholder="请输入用户名">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">密码</label>
                    <div class="layui-input-block">
                        <input type="password" class="layui-input" lay-verify="required|password" name="password"
                               id="pass" autocomplete="off" placeholder="请输入密码">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">密码确认</label>
                    <div class="layui-input-block">
                        <input type="password" class="layui-input" lay-verify="required|configpassword"
                               name="configpassword" autocomplete="off" placeholder="请再输入一次密码">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit="" lay-filter="register">提交</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
<script src="asserts/scci/common/plugin/layui/layui.js"></script>
<script>
    layui.use('element', function () {
        var $ = layui.jquery
            , element = layui.element(); //Tab的切换功能，切换事件监听等，需要依赖element模块
    });
    layui.use('form', function () {
        var form = layui.form();
        form.verify({
            username: function (value, item) { //value：表单的值、item：表单的DOM对象
                if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)) {
                    return '用户名不能有特殊字符';
                }
                if (/(^\_)|(\__)|(\_+$)/.test(value)) {
                    return '用户名首尾不能出现下划线\'_\'';
                }
                if (/^\d+\d+\d$/.test(value)) {
                    return '用户名不能全为数字';
                }
            }

            //我们既支持上述函数式的方式，也支持下述数组的形式
            //数组的两个值分别代表：[正则匹配、匹配不符时的提示文字]
            , password: [
                /^[\S]{6,12}$/
                , '密码必须6到12位，且不能出现空格'
            ],
            configpassword: function (value, item) {
                if (!/^[\S]{6,12}$/.test(value)) {
                    return '确认密码必须6到12位，且不能出现空格';
                }
                if (value != $('#pass').val()) {
                    return '确认密码和密码不一致';
                }
            }
        });
        //监听提交
        form.on('submit(login)', function(data){
            //layer.msg(JSON.stringify(data.field));
            //layer.msg($('#loginForm').serialize());
            var url=$('#loginForm').attr('action');
            $.ajax({
                url:url,
                type:'POST',
                data:$('#loginForm').serialize(),
                dataType:'json',
                success:function (data) {
                    if(data=="1"){
                        window.location="/index";
                    }else {
                        layer.msg("用户名或密码不正确！");
                    }
                }
            })
            return false;
        });
    });
</script>
</body>
</html>
