package cn.edu.util.file;

import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Administrator on 2017/7/25.
 */
public class FileUtil {
   public static List<String> matchList(String path,String prefix) {
       List<String>list=new ArrayList<String>();
       try {
           String content = FileUtils.readFileToString(new File(path));
           String regex=prefix+".*:before";
           Pattern pattern = Pattern.compile(regex);
           Matcher matcher = pattern.matcher(content);
           while (matcher.find()){
               list.add(matcher.group());
           }
           return list;
       }catch (IOException e){
           e.printStackTrace();
       }
       return null;
   }
   public static void main(String[] args){
       String basePath=System.getProperty("user.dir");
		String path="/rbac/src/main/webapp/assets/admin/plugin/bootstrapV3/css/bootstrap.css";
		String readPath=basePath+path;
		List<String>slist= FileUtil.matchList(readPath,"glyphicon");
		for(String s:slist){
            System.out.println(s);
        }
   }
}
