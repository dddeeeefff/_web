package vo;

import java.util.*;

public class ProductInfo {
	private String pi_id, pb_id, pb_name, ps_id, pi_name, pi_img1, pi_img2, pi_isview, pi_date;
	private String po_color, po_memory, po_rank, po_name, po_isview;
	
	private int pi_max, pi_min, pi_dc, pi_sale, ai_idx, po_inc, po_dec;
	private ArrayList<ProductOption> stockList;
	
	public String getPi_id() {
		return pi_id;
	}
	public void setPi_id(String pi_id) {
		this.pi_id = pi_id;
	}
	public String getPb_id() {
		return pb_id;
	}
	public void setPb_id(String pb_id) {
		this.pb_id = pb_id;
	}
	public String getPb_name() {
		return pb_name;
	}
	public void setPb_name(String pb_name) {
		this.pb_name = pb_name;
	}
	public String getPs_id() {
		return ps_id;
	}
	public void setPs_id(String ps_id) {
		this.ps_id = ps_id;
	}
	public String getPi_name() {
		return pi_name;
	}
	public void setPi_name(String pi_name) {
		this.pi_name = pi_name;
	}
	public String getPi_img1() {
		return pi_img1;
	}
	public void setPi_img1(String pi_img1) {
		this.pi_img1 = pi_img1;
	}
	public String getPi_img2() {
		return pi_img2;
	}
	public void setPi_img2(String pi_img2) {
		this.pi_img2 = pi_img2;
	}
	public String getPi_isview() {
		return pi_isview;
	}
	public void setPi_isview(String pi_isview) {
		this.pi_isview = pi_isview;
	}
	public String getPi_date() {
		return pi_date;
	}
	public void setPi_date(String pi_date) {
		this.pi_date = pi_date;
	}
	public String getPo_color() {
		return po_color;
	}
	public void setPo_color(String po_color) {
		this.po_color = po_color;
	}
	public String getPo_memory() {
		return po_memory;
	}
	public void setPo_memory(String po_memory) {
		this.po_memory = po_memory;
	}
	public String getPo_rank() {
		return po_rank;
	}
	public void setPo_rank(String po_rank) {
		this.po_rank = po_rank;
	}
	public String getPo_name() {
		return po_name;
	}
	public void setPo_name(String po_name) {
		this.po_name = po_name;
	}
	public String getPo_isview() {
		return po_isview;
	}
	public void setPo_isview(String po_isview) {
		this.po_isview = po_isview;
	}
	public int getPi_max() {
		return pi_max;
	}
	public void setPi_max(int pi_max) {
		this.pi_max = pi_max;
	}
	public int getPi_min() {
		return pi_min;
	}
	public void setPi_min(int pi_min) {
		this.pi_min = pi_min;
	}
	public int getPi_dc() {
		return pi_dc;
	}
	public void setPi_dc(int pi_dc) {
		this.pi_dc = pi_dc;
	}
	public int getPi_sale() {
		return pi_sale;
	}
	public void setPi_sale(int pi_sale) {
		this.pi_sale = pi_sale;
	}
	public int getAi_idx() {
		return ai_idx;
	}
	public void setAi_idx(int ai_idx) {
		this.ai_idx = ai_idx;
	}
	public int getPo_inc() {
		return po_inc;
	}
	public void setPo_inc(int po_inc) {
		this.po_inc = po_inc;
	}
	public int getPo_dec() {
		return po_dec;
	}
	public void setPo_dec(int po_dec) {
		this.po_dec = po_dec;
	}
	public ArrayList<ProductOption> getStockList() {
		return stockList;
	}
	public void setStockList(ArrayList<ProductOption> stockList) {
		this.stockList = stockList;
	}
}
