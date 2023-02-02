package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ComboCtgrSvc {
	public ArrayList<ProductCtgrBig> getBigList() {
		ArrayList<ProductCtgrBig> bigList = new ArrayList<ProductCtgrBig>();	
		Connection conn = getConnection();
		ComboCtgrProcDao comboCtgrProcDao = ComboCtgrProcDao.getInstance();
		comboCtgrProcDao.setConnection(conn);
		
		bigList = comboCtgrProcDao.getBigList();
		close(conn);
		
		return bigList;
	}
	
	public ArrayList<ProductCtgrSmall> getSmallList() {
		ArrayList<ProductCtgrSmall> smallList = new ArrayList<ProductCtgrSmall>();	
		Connection conn = getConnection();
		ComboCtgrProcDao comboCtgrProcDao = ComboCtgrProcDao.getInstance();
		comboCtgrProcDao.setConnection(conn);
		
		smallList = comboCtgrProcDao.getSmallList();
		close(conn);
		
		return smallList;
	}
}
