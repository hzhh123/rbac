package cn.edu.util.page;

import java.util.List;

/**
 * @author：hzhh123
 * @date：2017年4月25日 下午4:51:04
 */
public class PageResult<T> {
private List<T> rows;//数据
	
	private int pageNumber;//当前页
	
	private int pageSize;//条数
	
	private long total;//总条数

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	
	
	
}
