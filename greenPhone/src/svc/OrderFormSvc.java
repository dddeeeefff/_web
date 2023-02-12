package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class OrderFormSvc {
	public ArrayList<SellCart> getCartList (String kind, String sql) {
		ArrayList<SellCart> cartList = new ArrayList<SellCart>();
		Connection conn = getConnection();
		OrderDao orderDao = OrderDao.getInstance();
		orderDao.setConnection(conn);
		
		cartList = orderDao.getCartList(kind, sql);
		close(conn);
		
		return cartList;
	}
	
	public ArrayList<MemberInfo> getAddrList(String miid) {
		ArrayList<MemberInfo> addrList = new ArrayList<MemberInfo>();
		Connection conn = getConnection();
		OrderDao orderDao = OrderDao.getInstance();
		orderDao.setConnection(conn);
		
		addrList = orderDao.getAddrList(miid);
		close(conn);
		
		return addrList;
	}
}
