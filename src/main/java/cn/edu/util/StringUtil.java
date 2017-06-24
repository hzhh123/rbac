package cn.edu.util;

import java.util.ArrayList;
import java.util.List;

public class StringUtil {
  public static Integer[] parse(String str){
	  String[] s=str.split(",");
	  Integer[] a=new Integer[s.length];
	  for(int i=0;i<s.length;i++){
		  a[i]=Integer.parseInt(s[i]);
	  }
	  return a;
  }
  public static List<Integer> parseForList(String str){
	  String[] s=str.split(",");
	 List<Integer>list=new ArrayList<Integer>();
	  for(int i=0;i<s.length;i++){
		  list.add(Integer.parseInt(s[i]));
	  }
	  return list;
  }
}
