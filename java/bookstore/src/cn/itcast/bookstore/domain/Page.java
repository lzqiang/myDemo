package cn.itcast.bookstore.domain;

import java.util.List;

public class Page {
	private List list;//代表分页数据
	private Integer totalpage;//总页数
	private Integer pagesize=5;//每页显示记录的数量
	private Integer totalrecord;//总记录数  可以从dao中取得
	
	private Integer startIndex;//每页第一条记录的索引号
	private Integer pageNum;//用户要看的页码
	
	private Integer startpage;//开始页码
	private Integer endpage;//结束页码
	
	//计算
	public Page(int totalrecord,int pageNum){
		this.totalrecord=totalrecord;
		this.pageNum=pageNum;
		
		//计算总页数
		if(totalrecord%pagesize==0){
			totalpage=totalrecord/pagesize;
		}else{
			totalpage=totalrecord/pagesize+1;
		}
		//计算每页第一条记录的索引号
		startIndex=(pageNum-1)*pagesize;
		
		//根据当前用户要看的页码来计算开始和结束页码
		if(totalpage<=6){
			startpage=1;
			endpage=totalpage;
		}else{
			startpage=pageNum-3;
			endpage=pageNum+2;
			if(startpage<=1){
				startpage=1;
				endpage=6;
			}
			if(endpage>=totalpage){
				startpage=totalpage-5;
				endpage=totalpage;
			}
		}
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public Integer getTotalpage() {
		return totalpage;
	}

	public void setTotalpage(Integer totalpage) {
		this.totalpage = totalpage;
	}

	public Integer getPagesize() {
		return pagesize;
	}

	public void setPagesize(Integer pagesize) {
		this.pagesize = pagesize;
	}

	public Integer getTotalrecord() {
		return totalrecord;
	}

	public void setTotalrecord(Integer totalrecord) {
		this.totalrecord = totalrecord;
	}

	public Integer getStartIndex() {
		return startIndex;
	}

	public void setStartIndex(Integer startIndex) {
		this.startIndex = startIndex;
	}

	public Integer getPageNum() {
		return pageNum;
	}

	public void setPageNum(Integer pageNum) {
		this.pageNum = pageNum;
	}

	public Integer getStartpage() {
		return startpage;
	}

	public void setStartpage(Integer startpage) {
		this.startpage = startpage;
	}

	public Integer getEndpage() {
		return endpage;
	}

	public void setEndpage(Integer endpage) {
		this.endpage = endpage;
	}
	
}
