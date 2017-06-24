package cn.edu.model;

public class Menu {
	private Integer id;

    private String name;

    private String url;

    private String icon;

    private Integer parentid;

    private String order;

    private String isheader;

    private String statue;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon == null ? null : icon.trim();
    }

    public Integer getParentid() {
        return parentid;
    }

    public void setParentid(Integer parentid) {
        this.parentid = parentid;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order == null ? null : order.trim();
    }

    public String getIsheader() {
        return isheader;
    }

    public void setIsheader(String isheader) {
        this.isheader = isheader == null ? null : isheader.trim();
    }

    public String getStatue() {
        return statue;
    }

    public void setStatue(String statue) {
        this.statue = statue == null ? null : statue.trim();
    }
    @Override
   	public int hashCode() {
   		// TODO Auto-generated method stub
   		return super.hashCode();
   	}

   	@Override
   	public boolean equals(Object obj) {
   		// TODO Auto-generated method stub
   		if(obj instanceof Menu){
   			Menu m=(Menu)obj;
   	   		return this.id.equals(m.id)&&this.name.equals(m.name);
   		}
   		return false;
   	}

	@Override
	public String toString() {
		return "Menu [id=" + id + ", name=" + name + ", url=" + url + ", icon=" + icon + ", parentid=" + parentid
				+ ", order=" + order + ", isheader=" + isheader + ", statue=" + statue + "]";
	}
   	

	
}