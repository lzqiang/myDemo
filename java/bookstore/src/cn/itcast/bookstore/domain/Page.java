package cn.itcast.bookstore.domain;

import java.util.List;

public class Page {
	private List list;//�����ҳ����
	private Integer totalpage;//��ҳ��
	private Integer pagesize=5;//ÿҳ��ʾ��¼������
	private Integer totalrecord;//�ܼ�¼��  ���Դ�dao��ȡ��
	
	private Integer startIndex;//ÿҳ��һ����¼��������
	private Integer pageNum;//�û�Ҫ����ҳ��
	
	private Integer startpage;//��ʼҳ��
	private Integer endpage;//����ҳ��
	
	//����
	public Page(int totalrecord,int pageNum){
		this.totalrecord=totalrecord;
		this.pageNum=pageNum;
		
		//������ҳ��
		if(totalrecord%pagesize==0){
			totalpage=totalrecord/pagesize;
		}else{
			totalpage=totalrecord/pagesize+1;
		}
		//����ÿҳ��һ����¼��������
		startIndex=(pageNum-1)*pagesize;
		
		//���ݵ�ǰ�û�Ҫ����ҳ�������㿪ʼ�ͽ���ҳ��
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
