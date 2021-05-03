package packA;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class MemberMgr {
	private DBConnectionMgr pool;
	
	
//DBConnectionMgr 연결하기위해 객체 선언
	public MemberMgr() {
		 
		try {  
			pool = DBConnectionMgr.getInstance(); 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
/////////////////////	//Id 중복확인////////////////
	public boolean checkId(String id) {
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		boolean flag =false;
		String sql = null;
		
		try {
			con=pool.getConnection();
			sql = "SELECT ID FROM TBLMEMBER WHERE ID=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			flag = pstmt.executeQuery().next();
			
		} catch (SQLException ex) {
			System.out.println("SQLException : "+ex.getMessage());
		}catch(Exception e) {
			System.out.println("Exception : "+e.getMessage());
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		
		return flag;
	}
///////////////////////////////중복확인 끝///////////////////
	
	
/////////////// 우편번호 검색 시작 ///////////////
public  Vector<ZipcodeBean> zipcodeRead(String area3) {

Connection				con		=	null;
PreparedStatement	pstmt	=	null;
ResultSet					rs			=	null;
String						sql		=	null;
Vector<ZipcodeBean> vlist = new Vector<ZipcodeBean>();

try {

	con = pool.getConnection();
	sql = "select * from tblZipcode where area3 like ?";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1, "%" + area3 + "%");
	rs = pstmt.executeQuery();
	
	while (rs.next()) {
		ZipcodeBean bean = new ZipcodeBean();
		bean.setZipcode(rs.getString("zipcode"));
		bean.setArea1(rs.getString("area1"));
		bean.setArea2(rs.getString("area2"));
		bean.setArea3(rs.getString("area3"));
		bean.setArea4(rs.getString("area4"));
		
		vlist.add(bean);
	}
	
} catch (SQLException e) {
	System.out.println("SQLException : "
				+ e.getMessage());
} catch (Exception e) {
	// 상위 익셉션이 아래에 배치되어야 함
	System.out.println("Exception : "
			+ e.getMessage());			
} finally {
	pool.freeConnection(con, pstmt, rs);
}

return vlist;
}
/////////////// 우편번호 검색 끝 ///////////////

///////////회원가입////////////////
	public boolean inserttotblmember(memberBean bean) {
		Connection con = null;
		String sql = null;
		boolean flag = false;
		PreparedStatement pstmt = null;
		
		try {
			con= pool.getConnection();
			sql = "INSERT INTO TBLMEMBER VALUES(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPass());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getSex());
			pstmt.setString(5, bean.getBirthday());
			pstmt.setString(6, bean.getEmail());
			pstmt.setString(7, bean.getZipcode());
			pstmt.setString(8, bean.getAddress());
			
			
			String[] hobby = bean.getHobby();
			char[] hb= {'0','0','0','0','0'};
			String[] list = {"음악","미술","체육","문학","정치"};
			
			for(int i=0;i<hobby.length;i++) {
			for(int j=0;j<list.length;j++) {
				if(hobby[i].equals(list[j])) {
					hb[j] = '1';
				}
				
			}
		}
			
			pstmt.setNString(9, new String(hb));
			pstmt.setString(10, bean.getJob());
			pstmt.setInt(11, bean.getMemberLevel());
			
			
			
			if(pstmt.executeUpdate()==1) {
				flag=true;
			}
			
		} catch (SQLException ex) {
			
			System.out.println("SQLException : "+ex.getMessage());
		}catch(Exception e) {
			System.out.println("Exception : "+e.getMessage());
		}finally {
			pool.freeConnection(con,pstmt);
		}
		
		return flag;
	}
	/////////////////////////회원가입 끝///////////////////////

}
