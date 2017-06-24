package cn.edu.util.jstree;


import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/6/23.
 */
public class JstreeNodeUtil {
    public static List<TreeNode> tree(List<TreeNode>nodes, String id) {
        //递归转化为树形
        List<TreeNode> treeNodes=new ArrayList<TreeNode>();
        for(TreeNode treeNode : nodes) {
            TreeNode node=new TreeNode();
            node.setId(treeNode.getId());
            node.setParent(treeNode.getParent());
            node.setText(treeNode.getText());
            node.setA_attr(treeNode.getA_attr());
            node.setIcon(treeNode.getIcon());
            node.setLi_attr(treeNode.getLi_attr());
            node.setStatue(treeNode.getStatue());
            System.out.println(id==treeNode.getParent());
            System.out.println(id);
            System.out.println(treeNode.getParent());
            if(id==treeNode.getParent()){
                node.setChildren(tree(nodes, node.getId()));
                treeNodes.add(node);
            }

        }
        return treeNodes;
    }




}
