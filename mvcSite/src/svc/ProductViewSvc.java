package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ProductViewSvc {
	public int readUpdate(String piid) {
		int result = 0;
		Connection conn = getConnection();
		ProductProcDao productProcDao = ProductProcDao.getInstance();
		productProcDao.setConnection(conn);
		
		result = productProcDao.readUpdate(piid);
		if (result == 1)	commit(conn);
		else				rollback(conn);
		close(conn);
		
		return result;
	}
	
	public ProductInfo getProductInfo(String piid) {
		ProductInfo pi = null;
		Connection conn = getConnection();
		ProductProcDao productProcDao = ProductProcDao.getInstance();
		productProcDao.setConnection(conn);
		
		pi = productProcDao.getProductInfo(piid);
		close(conn);
		
		return pi;
	}
}
