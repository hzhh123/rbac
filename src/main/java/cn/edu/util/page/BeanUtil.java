package cn.edu.util.page;

import java.util.List;

import com.github.pagehelper.Page;

/**
 * @author：hzhh123
 * @date：2017年4月25日 下午4:50:24
 */
public class BeanUtil {
	public static <T> PageResult<T> toPagedResult(List<T> datas) {
		PageResult<T> result = new PageResult<T>();
        if (datas instanceof Page) {
            Page page = (Page) datas;
            result.setPageNumber(page.getPageNum());
            result.setPageSize(page.getPageSize());
            result.setRows(page.getResult());
            result.setTotal(page.getTotal());
         }
        else {
            result.setPageNumber(1);
            result.setPageSize(datas.size());
            result.setRows(datas);
            result.setTotal(datas.size());
        }
        return result;
    }
}
