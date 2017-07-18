<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/plugin/bootstrapV3/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/plugin/font/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/plugin/bootstrap-dialog/css/bootstrap-dialog.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/plugin/tree/jstree/themes/default/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/plugin/bootstrap-table/dist/bootstrap-table.min.css">
    <style type="text/css">
        #data .fa-folder{
            color:#337ab7;
        }
    </style>
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
                    <label class="control-label" for="">角色名</label>
                    <input type="text" name="rolename" class="form-control" id="" placeholder="输入角色名">
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
       <a class="btn btn-primary" title="添加" id="add"><i class="fa fa-plus-circle"></i></a>
       <a class="btn btn-danger" title="删除" id="delete"><i class="fa fa-trash-o"></i></a>
    </div>
    <table id="table1"></table>
    <input type="hidden" id="index">
</div>
<%--<script type="text/javascript" src="https://cdn.bootcss.com/jquery/2.2.4/jquery.js"></script>--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/plugin/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/plugin/bootstrapV3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/plugin/bootstrap-dialog/js/bootstrap-dialog.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/plugin/bootstrap-table/dist/bootstrap-table.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/plugin/bootstrap-table/dist/locale/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/plugin/bootstrap-table/dist/bootstrap-table-editable.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/plugin/bootstrap-table/dist/bootstrap-editable.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/plugin/bootstrap-table/dist/bootstrap-table-resizable.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/plugin/bootstrap-table/dist/colresizable.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/plugin/bootstrap-table/dist/export/bootstrap-table-export.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/plugin/bootstrap-table/dist/export/tableExport.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/js/serializeObject.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/admin/plugin/tree/jstree/jstree.js"></script>
<script type="text/javascript">

    function update(id) {
        BootstrapDialog.show({
            title: '<i class="fa fa-edit"></i> 修改',
            message: $('<div style="padding: 15px;"></div>').load('common/roleOption.html'),
            onshown:function (dialogRef) {
                $.ajax({
                    url:'/role/prepareEdit',
                    data:{"id":id},
                    dataType:'json',
                    type:'post',
                    success:function (data) {
                        var role=data;
                      $('#form').find('[name=id]').val(role.id);
                      $('#form').find('[name=rolename]').val(role.rolename);
                      $('#form').find('[name=desc]').val(role.desc);
                      $('#form').find('[name=statue][value='+role.statue+']').attr('checked','checked');

                    }
                })
            },
            buttons: [{
                label: '确定',
                cssClass:'btn-primary',
                action: function(dialog) {
                    $.ajax({
                        url:'/role/saveOrUpdate',
                        data:$('#form').serializeObject(),
                        dataType:'json',
                        type:'post',
                        success:function(data){
                            if(data.msg=="1"){
                                alert("修改成功！");
                                var rolename=$('#form').find('[name=rolename]').val();
                                var desc=$('#form').find('[name=desc]').val();
                                var statue=$('#form').find('[name=statue]:checked').val();
                                console.log(statue);
                                    //var row=$('#table1').bootstrapTable('getRowByUniqueId',id);
                                    $('#table1').bootstrapTable('updateRow', {
                                        index: $('#index').val(),
                                        row: {
                                            rolename: rolename,
                                            statue:statue,
                                            desc:desc
                                        }
                                    });

                            }else if(data.msg=="0"){
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
                        url:'/role/delete',
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
    }

    function association(id) {
        BootstrapDialog.show({
            title: '<i class="fa fa-share-alt"></i> 关联资源',
            message: $('<div style="padding: 15px;"></div>').load('common/associationOption.html'),
            onshown:function (dialogRef) {
                $('#data').data('jstree', false).empty();
                $('#data').jstree({
                    'core' : {
                        'data' : function (obj, cb) {
                            $.ajax({
                                url:'/role/ajax_nodes',
                                dataType:'json',
                                data:{"roleid":id},
                                type:'post',
                                success:function (data) {
                                    cb.call(this, data);
                                }
                            });

                        }

                    },
                    "types" : {
                        "default" : {
                            "icon" : "fa fa-folder"
                        }
                    },
                    plugins: ["types","checkbox","wholerow"]
                });
            },
            buttons: [{
                label: '确定',
                cssClass:'btn-primary',
                action: function(dialog) {
                    var ids=new Array();
                    var ref = $('#data').jstree(true),
                        nodes = ref.get_selected();
                    if(nodes==""){
                        ids.push("");
                    }else {
                        ids=nodes;
                    }
                   $.ajax({
                       url:'role/association',
                       data:{"roleid":id,"ids":ids},
                       dataType:"json",
                       type:'post',
                       success:function (data) {
                           if(data=="1"){
                               alert("成功");
                           }
                       },
                       error:function (xhr,status,error) {
                           alert(error);
                       }
                   })
                    dialog.close();
                }
            }, {
                label: '关闭',
                action: function(dialog) {
                    dialog.close();
                }
            }]
        });
    }
    $(function () {
       // $.selectArray={statue:[{idxNum:'1',name:'有效'},{idxNum:'0',name:'无效'}]};
        getTableData();
        function getTableData() {
            $('#table1').bootstrapTable({
                url: '/role/list',
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
                        rolename: $('#search-form').find('[name=rolename]').val(),
                        statue: $('#search-form').find('[name=statue]').val()
                    };
                    return param;
                },
                uniqueId: "id",
                onEditableSave: function (field, row, oldValue, $el) {
                    $.ajax({
                        type: "post",
                        url: "/role/update",
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
                                + "<a class=\"btn btn-danger btn-xs\" title=\"删除\" onclick='del(" + row.id + ")'><i class=\"fa fa-trash-o\"></i></a><a class=\"btn btn-info btn-xs\" title=\"关联资源\" " +
                                "onclick='association(" + row.id + ")'><i class=\"fa fa-share-alt\"></i></a></div>"
                        }
                    }
                    , {
                        field: 'id',
                        title: 'ID'
                    }, {
                        field: 'rolename',
                        title: '角色名',
                        editable: {
                            type: 'text',
                            title: '角色名',
                            validate: function (v) {
                                if (!v) return '角色名不能为空';

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
                            source: [{value:1,text:"有效"},{value:0,text:"无效"}]
                            //第二种
                            //source:'/user/statue'
                        }

                    }, {
                        field: 'desc',
                        title: '描述',
                        formatter:function (value) {
                            return value==null?'':value;
                        },
                        editable: {
                            type: 'textarea',
                            title: '描述',
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
                                    url: '/role/delete',
                                    data: {"ids": ids},
                                    dataType: 'json',
                                    type: 'post',
                                    success: function (data) {
                                        if (data == "1") {
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



        $('#table1').on("click-row.bs.table",function(e, row, $element) {
            var index= $element.data('index');
            $('#index').val(index);
        });

        $('#search-btn').click(function () {
            var rolename=$('#search-form').find('[name=rolename]').val();
            var statue=$('#search-form').find('[name=statue]').val();
           $('#table1').bootstrapTable('refresh',{query:{rolename:rolename,statue:statue}})
        });
        $('#add').click(function () {
            BootstrapDialog.show({
                title: '<i class="fa fa-edit"></i> 添加',
                message: $('<div style="padding: 15px;"></div>').load('common/roleOption.html'),
                onshown:function (dialogRef) {
                    $('#form').find('[name=statue][value="1"]').attr("checked","checked");
                },
                buttons: [{
                    label: '确定',
                    cssClass:'btn-primary',
                    action: function(dialog) {
                        $.ajax({
                            url:'/role/saveOrUpdate',
                            data:$('#form').serializeObject(),
                            dataType:'json',
                            type:'post',
                            success:function(data){
                                if(data.msg=="1"){
                                    alert("添加成功！");
                                    var rolename=$('#form').find('[name=rolename]').val();
                                    var desc=$('#form').find('[name=desc]').val();
                                    var statue=$('#form').find('[name=statue]:checked').val();
                                    console.log(statue);
                                    var id=data.role.id;
                                    //var row=$('#table1').bootstrapTable('getRowByUniqueId',id);
                                    $('#table1').bootstrapTable('append', {
                                            id:id,
                                            rolename: rolename,
                                            statue:statue,
                                            desc:desc
                                    });

                                }else if(data.msg=="0"){
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
        })

    })
</script>
</body>
</html>