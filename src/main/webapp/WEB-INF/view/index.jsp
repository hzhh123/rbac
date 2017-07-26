<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Title</title>
    <link rel="shortcut icon" href="/assets/admin/image/favicon.ico">
    <link rel="stylesheet" href="/assets/admin/plugin/bootstrapV3/css/bootstrap.min.css">
    <link rel="stylesheet" href="/assets/admin/plugin/font/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/assets/admin/plugin/layui/css/layui.css">
    <link rel="stylesheet" href="/assets/admin/plugin/font/simple-line-icons/css/simple-line-icons.css">
    <link rel="stylesheet" href="/assets/admin/plugin/metisMenu/css/metisMenu.css">
    <link rel="stylesheet" href="/assets/admin/plugin/metisMenu/css/mm-vertical.css">
    <link rel="stylesheet" href="/assets/admin/css/style.css">
    <link rel="stylesheet" href="/assets/admin/css/default.css" />
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">
                <img src="/assets/admin/image/logo.png" style="height: 40px;position: absolute;top: 5px;left: 50px;">
            </a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
           <ul class="navbar-nav nav">
               <li><a href="" class="toggle-sidebar task"><i class="fa fa-tasks"></i></a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">Link</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">${sessionScope.sessionUser.username} <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="/logout">退出</a></li>
                        <li><a href="#">Another action</a></li>
                        <li><a href="#">Something else here</a></li>
                        <li><a href="#">Separated link</a></li>
                    </ul>
                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div>
</nav>
<aside>
    <nav class="sidebar-nav">
        <%--<div class="sidebar-search">--%>
            <%--<form action="" class="form-horizontal">--%>
                <%--<input type="text" class="form-control" placeholder="请输入搜索菜单">--%>
            <%--</form>--%>
        <%--</div>--%>
        <ul class="metismenu" id="menu1"></ul>
    </nav>
</aside>
<div class="content">
    <section class="layout-main"  >
        <div class="layout-main-tab">
            <button class="tab-btn btn-left"><i class="fa fa-backward"></i></button>
            <nav class="tab-nav">
                <div class="tab-nav-content">
                    <a href="javascript:;" class="content-tab active" data-id="home.html">首页</a>
                </div>
            </nav>
            <button class="tab-btn btn-right"><i class="fa fa-forward"></i></button>
        </div>
        <div class="layout-main-body" >
            <iframe class="body-iframe" id="iframe0" name="iframe0" width="100%" height="100%" src="/menu/home" frameborder="0" data-id="home.html" seamless></iframe>
        </div>
        <div class="footer">
            <a href="#" class="sidebar-toggle" title="侧边导航菜单切换"><i class="fa fa-chevron-circle-right fa-3x"></i></a>
            <div class="footer-tip">2017@测试</div>
        </div>
    </section>

</div>
<script type="text/javascript" src="https://cdn.bootcss.com/jquery/2.2.4/jquery.js"></script>
<script type="text/javascript" src="/assets/admin/plugin/bootstrapV3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/assets/admin/plugin/metisMenu/js/metisMenu.js"></script>
<script type="text/javascript" src="/assets/admin/plugin/scroll/jquery.nicescroll.min.js"></script>
<script type="text/javascript" src="/assets/admin/plugin/layer/layer.js"></script>
<script type="text/javascript" src="/assets/admin/plugin/layui/layui.js"></script>
<script type="text/javascript" src="/assets/admin/js/style.js"></script>
<script type="text/javascript">
    $(function () {
        $('.toggle-sidebar').mouseenter(function () {
            layer.tips("切换菜单", this);
        });
        init(50);
        resize();
        function init(h){
            $('aside').height($(window).height()-h);
            if($(window).width()<768){
                $('aside').animate({'left':-220},"fast");
                $('.layout-main').animate({'left':0},"fast");
            }else {
                $('aside').animate({'left':0},"fast");
                $('.layout-main').animate({'left':220},"fast");
            }
            $('#overlay').css('display','none');

        }

        function resize(){
            $(window).resize(function () {
                init(50);
            })
        }

        $('aside').niceScroll({
            cursorcolor:"#343a40",
            cursoropacitymax:1,
            touchbehavior:false,
            cursorwidth:"6px",
            cursorborder:"0",
            cursorborderradius:"5px"
        });

        $('.toggle-sidebar').click(function () {
            if($('aside').css('left')=='0px'){
                $('aside').animate({'left':-220},"fast");
                $('.layout-main').animate({'left':0},"fast");

            }
            if($('aside').css('left')=='-220px'){
                $('aside').animate({'left':0},"fast");
                $('.layout-main').animate({'left':220},"fast");
            }
            return false;
        })

        var docHeight = $(document).height(); //获取窗口高度

       // 添加遮盖层
        $('body').append('<div id="overlay"></div>');
        $('#overlay')
            .height(docHeight)
            .css({
                'opacity': .8, //透明度
                'position': 'absolute',
                'top': 0,
                'left': 220,
                'background-color': 'black',
                'width': '100%',
                'display':'none',
                'z-index': 5000 //保证这个悬浮层位于其它内容之上
            });
       $('#overlay').on('click',function () {
           $(this).css('display','none');
           //$('aside').css('display','none');
           //$(this).animate({'left':-$(window).width()},"fast");
           $('aside').animate({'left':-220},"fast");
       });
       $('.sidebar-toggle').click(function () {
           $('aside').animate({'left':0},"fast");
           $('#overlay').css('display','block');
           //$('aside').css('display','block');
           //$('#overlay').animate({'left':220},"fast");
       })
    })
</script>
</body>
</html>