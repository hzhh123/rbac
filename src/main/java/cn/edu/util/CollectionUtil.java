package cn.edu.util;

import java.util.List;

public class CollectionUtil {

	public static List<?> removeDuplicate(List<?> list) {
		for (int i = 0; i < list.size() - 1; i++) { // 从左向右循环
			for (int j = list.size() - 1; j > i; j--) { // 从右往左内循环
				if (list.get(j).equals(list.get(i))) {
					list.remove(j); // 相等则移除
				}
			}
		}
		return list;
	}
}
