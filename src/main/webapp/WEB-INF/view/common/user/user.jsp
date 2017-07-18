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
    <link rel="stylesheet" href="assets/admin/plugin/bootstrap-dialog/css/bootstrap-dialog.css">
    <link rel="stylesheet" href="assets/admin/plugin/bootstrap-table/dist/bootstrap-table.min.css">
</head>
<body>
<div class="container-fluid">
    <div class="panel panel-primary">
        <div class="panel-heading">
           <h4 class="panel-title"><i class="fa fa-search"></i> 查询</h4>
        </div>
        <div class="panel-body">
            <form id="search-form" method="POST" class="form-inline" role="form">

                <div class="form-group">
                    <label class="control-label" for="">用户名</label>
                    <input type="text" name="username" class="form-control" id="" placeholder="输入用户名">
                </div>

                <div class="form-group">
                    <label class="control-label">状态</label>
                    <select name="statue" class="form-control">
                        <option value="">请选择</option>
                        <option value="1">有效</option>
                        <option value="0">无效</option>
                    </select>
                </div>

                <button id="search-btn" type="button" class="btn btn-primary">查询</button>
                <button  type="reset" class="btn btn-default">重置</button>
            </form>
        </div>
    </div>
    <div id="toolbar" class="btn-group">
       <a class="btn btn-primary" title="添加" href="/user/prepareAdd"><i class="fa fa-plus-circle"></i></a>
       <a class="btn btn-warning" title="修改" id="edit"><i class="fa fa-edit"></i></a>
       <a class="btn btn-danger" title="删除" id="delete"><i class="fa fa-trash-o"></i></a>
    </div>
    <table id="table1"></table>
    <input type="hidden" id="index">
</div>
<%--<script type="text/javascript" src="https://cdn.bootcss.com/jquery/2.2.4/jquery.js"></script>--%>
<script type="text/javascript" src="assets/admin/plugin/jquery.min.js"></script>
<script type="text/javascript" src="assets/admin/plugin/bootstrapV3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="assets/admin/plugin/bootstrap-dialog/js/bootstrap-dialog.js"></script>
<script type="text/javascript" src="assets/admin/plugin/bootstrap-table/dist/bootstrap-table.min.js"></script>
<script type="text/javascript" src="assets/admin/plugin/bootstrap-table/dist/locale/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript" src="assets/admin/plugin/bootstrap-table/dist/bootstrap-table-editable.js"></script>
<script type="text/javascript" src="assets/admin/plugin/bootstrap-table/dist/bootstrap-editable.js"></script>
<script type="text/javascript" src="assets/admin/plugin/bootstrap-table/dist/bootstrap-table-resizable.js"></script>
<script type="text/javascript" src="assets/admin/plugin/bootstrap-table/dist/colresizable.js"></script>
<script type="text/javascript" src="assets/admin/plugin/bootstrap-table/dist/export/bootstrap-table-export.js"></script>
<script type="text/javascript" src="assets/admin/plugin/bootstrap-table/dist/export/tableExport.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/js/serializeObject.js"></script>
<script type="text/javascript">

    function update(id) {
        BootstrapDialog.show({
            title: '<i class="fa fa-edit"></i> 修改',
            message: $('<div style="padding: 15px;"></div>').load('common/userOption.html'),
            onshown:function (dialogRef) {
                $.ajax({
                    url:'/user/prepareEdit2',
                    data:{"id":id},
                    dataType:'json',
                    type:'post',
                    success:function (data) {
                      var user=data.user;
                      var roles=data.roles;
                      $('#form').find('[name=id]').val(user.id);
                      $('#form').find('[name=username]').val(user.username);
                      $('#form').find('[name=password]').val(user.password);
                      $('#form').find('[name=statue][value='+user.statue+']').attr('checked','checked');
                      $('#roles').append('<input type="checkbox" checked name="roleids" value="" style="display: none;">');
                      for(var i=0;i<roles.length;i++){
                          if(roles[i].ischeck){
                              $('#roles').append('<input type="checkbox" name="roleids" value="'+roles[i].id+'" checked>'+roles[i].rolename+'');
                          }else{
                              $('#roles').append('<input type="checkbox" name="roleids" value="'+roles[i].id+'">'+roles[i].rolename+'');
                          }

                      }
                    }
                })
            },
            buttons: [{
                label: '确定',
                cssClass:'btn-primary',
                action: function(dialog) {
                    $.ajax({
                        url:'/user/saveOrUpdate',
                        data:$('#form').serializeObject(),
                        dataType:'json',
                        type:'post',
                        success:function(data){
                            if(data=="1"){
                                alert("修改成功！");
                                var username=$('#form').find('[name=username]').val();
                                var statue=$('#form').find('[name=statue]:checked').val();
                                console.log(statue);
                                    //var row=$('#table1').bootstrapTable('getRowByUniqueId',id);
                                    $('#table1').bootstrapTable('updateRow', {
                                        index: $('#index').val(),
                                        row: {
                                            username: username,
                                            statue:statue
                                        }
                                    });

                            }else if(data=="0"){
                                alert("用户名已存在");
                            } else{
                                alert("出错了!")
                            }
                            dialog.close();
                        }
                    });
                }
            }, {
                label: '关闭',
                action: function(dialog) {
                    dialog.close();
                }
            }]
        });
    }
    function del(id){
        BootstrapDialog.confirm({
            title: '提示',
            message: '确定要删除记录吗?',
            type: BootstrapDialog.TYPE_DANGER, // <-- Default value is BootstrapDialog.TYPE_PRIMARY
            closable: true, // <-- Default value is false
            draggable: true, // <-- Default value is false
            btnOKLabel: '确定', // <-- Default value is 'OK',
            btnOKClass: 'btn-primary', // <-- If you didn't specify it, dialog type will be used,
            btnCancelLabel: '取消', // <-- Default value is 'Cancel',
            callback: function(result) {
                // result will be true if button was click, while it will be false if users close the dialog directly.
                if(result) {
                    var ids=new Array();
                    ids.push(id);
                    //发送ajax删除数据
                    $.ajax({
                        url:'/user/delete',
                        data:{"ids":ids},
                        dataType:'json',
                        type:'post',
                        success:function (data) {
                            if(data==1){
                                alert("删除成功！")
                                $('#table1').bootstrapTable('remove', {field: 'id', values: ids});
                            }else {
                                alert("删除失败！");
                            }
                        }
                    });
                }else {

                }
            }
        });
//        BootstrapDialog.show({
//            title: '提示',
//            message: '确定要删除记录吗?',
//            buttons: [{
//                cssClass:'btn-primary',
//                label: '确定',
//                action: function(dialog) {
//                    var ids=new Array();
//                    ids.push(id);
//                        //发送ajax删除数据
//                        $.ajax({
//                            url:'/user/delete',
//                            data:{"ids":ids},
//                            dataType:'json',
//                            type:'post',
//                            success:function (data) {
//                                if(data==1){
//                                    alert("删除成功！")
//                                    $('#table1').bootstrapTable('remove', {field: 'id', values: ids});
//                                }else {
//                                    alert("删除失败！");
//                                }
//                            }
//                        });
//
//                    dialog.close();
//                }
//            }, {
//                label: '取消',
//                action: function(dialog) {
//                    dialog.close();
//                }
//            }]
//        });

    }
    $(function () {
       // $.selectArray={statue:[{idxNum:'1',name:'有效'},{idxNum:'0',name:'无效'}]};
        getTableData();
        function getTableData() {
            $('#table1').bootstrapTable({
                url: '/user/list',
                method: 'post',
                showColumns: true,
                resizable: true,
                showExport: true,
                exportDataType: "all",
                contentType: 'application/x-www-form-urlencoded',
                search: false,
                toolbar: '#toolbar',
                pagination: true,//显示分页
                showRefresh: true,
                showToggle: true,
                sortOrder: 'asc',
                sortStable: true,
                sidePagination: "server",
                pageNumber: 1,
                pageSize: 10,
                escape: true,
                pageList: [5, 10, 15, 20],
                queryParamsType: '',
                //showPaginationSwitch:true,
//            clickToSelect: true,
                queryParams: function (params) {
                    var param = {
                        pageSize: params.pageSize,
                        pageNumber: params.pageNumber,
                        username: $('#search-form').find('[name=username]').val(),
                        statue: $('#search-form').find('[name=statue]').val()
                    };
                    return param;
                },
                uniqueId: "id",
                onEditableSave: function (field, row, oldValue, $el) {
                    $.ajax({
                        type: "post",
                        url: "/user/update",
                        data: row,
                        dataType: 'json',
                        success: function (data, status) {
                            if (status == "success") {
                                // alert('编辑成功！');
                            }
                        },
                        error: function () {
                            alert('编辑失败');
                        },
                        complete: function () {

                        }


                    });
                },
                columns: [
                    {
                        checkbox: true
                    }, {
                        field: '',
                        title: '操作',
                        formatter: function (value, row, index) {
                            return "<div class='btn-group'><a class=\"btn btn-warning btn-xs\" title=\"修改\" onclick='update(" + row.id + ")'><i class=\"fa fa-edit\"></i></a>"
                                + "<a class=\"btn btn-danger btn-xs\" title=\"删除\" onclick='del(" + row.id + ")'><i class=\"fa fa-trash-o\"></i></a><a class=\"btn btn-info btn-xs\" title=\"关联角色\" " +
                                "href='/user/association?id=" + row.id + "'><i class=\"fa fa-user\"></i></a></div>"
                        }
                    }
                    , {
                        field: 'id',
                        title: 'ID'
                    }, {
                        field: 'username',
                        title: '用户名',
                        editable: {
                            type: 'text',
                            title: '用户名',
                            validate: function (v) {
                                if (!v) return '用户名不能为空';

                            }
                        }
                    },{
                        field: 'password',
                        title: '密码',
                        editable: {
                            type: 'text',
                            title: '密码',
                            validate: function (v) {
                                if (!v) return '密码不能为空';

                            }
                        }
                    }, {
                        field: 'statue',
                        title: '状态',
                        //当进行行内编辑时(editable),formatter会与editable冲突，只能选择editable
//                    formatter:function(value,row,index){
//                        //通过formatter可以自定义列显示的内容
//                        //value：当前field的值
//                        //row：当前行的数据
//                        return value=="1"?"有效":"无效";
//                    },
                        editable: {
                            type: 'select',
                            title: '状态',
                            //select远程加载,推荐使用第二种
                            //第一种
                            source: function () {
                                var result = [];
                                $.ajax({
                                    url: '/user/statue',
                                    type: "get",
                                    async: false,
                                    data: {},
                                    dataType: 'json',
                                    success: function (data, status) {
                                        for (var i = 0; i < data.length; i++) {
                                            result.push({value: data[i].value, text: data[i].text});
                                        }
                                    }
                                });
                                return result;
                            }
                            //第二种
                            //source:'/user/statue'
                        }

                    }]
//            ,onCheck:function (row){
//              alert(row.id);
//
//            }
            });
        }
        $('#delete').click(function () {
            var ret=$('#table1').bootstrapTable('getSelections');
            var ids=new Array();
                if(ret.length>0){
                    for(var i=0;i<ret.length;i++){
                      ids.push(ret[i].id);
                    }

                    BootstrapDialog.confirm({
                        title: '提示',
                        message: '确定要删除记录吗?',
                        type: BootstrapDialog.TYPE_DANGER, // <-- Default value is BootstrapDialog.TYPE_PRIMARY
                        closable: true, // <-- Default value is false
                        draggable: true, // <-- Default value is false
                        btnOKLabel: '确定', // <-- Default value is 'OK',
                        btnOKClass: 'btn-primary', // <-- If you didn't specify it, dialog type will be used,
                        btnCancelLabel: '取消', // <-- Default value is 'Cancel',
                        callback: function (result) {
                            // result will be true if button was click, while it will be false if users close the dialog directly.
                            if (result) {
                                //发送ajax删除数据
                                $.ajax({
                                    url: '/user/delete',
                                    data: {"ids": ids},
                                    dataType: 'json',
                                    type: 'post',
                                    success: function (data) {
                                        if (data == 1) {
                                            alert("删除成功！")
                                            $('#table1').bootstrapTable('remove', {field: 'id', values: ids});
                                        } else {
                                            alert("删除失败！");
                                        }
                                    }
                                });
                            } else {

                            }
                        }
                    });

                }else{
                    alert("请选择要删除的记录！")
                }
        })

        $('#edit').click(function () {
            var ret=$('#table1').bootstrapTable('getSelections');
            if(ret.length!=1){
                alert("请选择要编辑的记录且选择记录数只能为一!");
            }else{
                //编辑
                var id=ret[0].id;
                location.href="/user/prepareEdit?id="+id;
            }
        })

        $('#table1').on("click-row.bs.table",function(e, row, $element) {
            var index= $element.data('index');
            $('#index').val(index);
        });

        $('#search-btn').click(function () {
            var username=$('#search-form').find('[name=username]').val();
            var statue=$('#search-form').find('[name=statue]').val();
           //$('#table1').bootstrapTable('refresh',{url:'/user/list?username='+username+'&statue='+statue})
           $('#table1').bootstrapTable('refresh',{query:{username:username,statue:statue}})
        })

    })
</script>
</body>
</html>