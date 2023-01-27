package vo;

public class BbsFree {
// 하나의 자유게시판 게시글 정보를 저장할 클래스
	private int bf_idx, bf_read, bf_reply;
	private String bf_ismem, bf_writer, bf_pw, bf_header, bf_title, bf_content, bf_ip, bf_date, bf_isdel;
	
	public int getBf_idx() {
		return bf_idx;
	}
	public void setBf_idx(int bf_idx) {
		this.bf_idx = bf_idx;
	}
	public int getBf_read() {
		return bf_read;
	}
	public void setBf_read(int bf_read) {
		this.bf_read = bf_read;
	}
	public int getBf_reply() {
		return bf_reply;
	}
	public void setBf_reply(int bf_reply) {
		this.bf_reply = bf_reply;
	}
	public String getBf_ismem() {
		return bf_ismem;
	}
	public void setBf_ismem(String bf_ismem) {
		this.bf_ismem = bf_ismem;
	}
	public String getBf_writer() {
		return bf_writer;
	}
	public void setBf_writer(String bf_writer) {
		this.bf_writer = bf_writer;
	}
	public String getBf_pw() {
		return bf_pw;
	}
	public void setBf_pw(String bf_pw) {
		this.bf_pw = bf_pw;
	}
	public String getBf_header() {
		return bf_header;
	}
	public void setBf_header(String bf_header) {
		this.bf_header = bf_header;
	}
	public String getBf_title() {
		return bf_title;
	}
	public void setBf_title(String bf_title) {
		this.bf_title = bf_title;
	}
	public String getBf_content() {
		return bf_content;
	}
	public void setBf_content(String bf_content) {
		this.bf_content = bf_content;
	}
	public String getBf_ip() {
		return bf_ip;
	}
	public void setBf_ip(String bf_ip) {
		this.bf_ip = bf_ip;
	}
	public String getBf_date() {
		return bf_date;
	}
	public void setBf_date(String bf_date) {
		this.bf_date = bf_date;
	}
	public String getBf_isdel() {
		return bf_isdel;
	}
	public void setBf_isdel(String bf_isdel) {
		this.bf_isdel = bf_isdel;
	}
	
}
