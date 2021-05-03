package packA;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class MemberMgr_Proj {

	private DBConnectionMgr pool;		// <<<<<<<<<
	
	public MemberMgr_Proj() {
		try {
			pool = DBConnectionMgr.getInstance(); // 싱글턴패턴
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
			
	// 로그인
	public int loginMember(String id, String pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int flag = 0;
		try {
			con = pool.getConnection();
			if(!pass.equals("")) {
			sql = "select id, memberLevel from tblMember where id=? and pass = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			}else {
				sql = "select id, memberLevel from tblMember where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag = rs.getInt("memberLevel");
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;	
	}
}