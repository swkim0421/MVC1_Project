package packA;

import java.sql.*;
import java.util.*;

import packImgBBS.BoardBean;



public class mainMgr {

	private DBConnectionMgr pool;
	private static final String SAVEFOLDER = "D:/Java/pradi/jsp/Proj_BBS/WebContent/upload";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 5 * 1024 * 1024;
	
	
	public mainMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public int navLogin(String id, String pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		int memberLevel = 0;
		try {
			con = pool.getConnection();
			sql = "select id,memberLevel member from tblmember where id=? and pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				memberLevel = rs.getInt(2);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return memberLevel;
	}
	
	public boolean infoAuth(String id, String pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		boolean result = false;
		try {
			con = pool.getConnection();
			sql = "select id from tblmember where id=? and pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			rs = pstmt.executeQuery();
			result = rs.next();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return result;
	}
	
	public memberBean infoData(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		boolean result = false;
		memberBean mb = null;
		try {
			con = pool.getConnection();
			sql = "select * from tblmember where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			mb = new memberBean();
			if(rs.next()) {
				mb.setName(rs.getString("name"));
				mb.setSex(rs.getString("sex"));
				mb.setBirthday(rs.getString("birthday"));
				mb.setEmail(rs.getString("email"));
				mb.setZipcode(rs.getString("zipcode"));
				mb.setAddress(rs.getString("address"));
				String [] hb = {rs.getString("hobby")};
				mb.setHobby(hb);
				mb.setJob(rs.getString("job"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return mb;
	}
	
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
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return vlist;
		}
	
	
		public int myInfoUpdate(memberBean mb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			int okay = 0;
			try {
				con = pool.getConnection();
				
				sql = "update tblmember set ";
				sql += "name=?,";
				sql += "sex=?,";
				sql += "birthday=?,";
				sql += "email=?,";
				sql += "zipcode=?,";
				sql += "address=?,";
				sql += "hobby=?,";
				sql += "job=? ";
				sql += "where id = ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mb.getName());
				pstmt.setString(2, mb.getSex());
				pstmt.setString(3, mb.getBirthday());
				pstmt.setString(4, mb.getEmail());
				pstmt.setString(5, mb.getZipcode());
				pstmt.setString(6, mb.getAddress());
				
				String hobby[] = mb.getHobby();
				char hb[] = {'0','0','0','0','0'};
				String list[] = {"음악","미술", "체육","문학","정치"};
				
				for (int i = 0; i < hobby.length; i++) {
					for (int j = 0; j < list.length; j++) {
							if(hobby[i].equals(list[j])) {
								hb[j] = '1';
							}
						}
				}
				
				pstmt.setString(7, new String(hb));
				
				pstmt.setString(8, mb.getJob());
				pstmt.setString(9, mb.getId());
				
				okay = pstmt.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return okay;
		}
	
		
		
		public int insertFaqBoard(FaqBean fb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			int result = 0;
			
			try {
				con = pool.getConnection();
				sql = "insert faqBoard (tab, subject, content, regdate, id) values (?, ?, ?, now(), ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, fb.getTab());
				pstmt.setString(2, fb.getSubject());
				pstmt.setString(3, fb.getContent());
				pstmt.setString(4, fb.getId());
				
				result = pstmt.executeUpdate();
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return result;
		}
	
		public Vector<FaqBean> listFaqBoard(int start, int end) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			Vector<FaqBean> vfb = new Vector<FaqBean>();
			
			try {
				con = pool.getConnection();
				start = 0;
				end = 5;
				sql = "select * from faqBoard order by num asc limit ?,?;";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					FaqBean fb = new FaqBean();
					fb.setNum(rs.getInt("num"));
					fb.setTab(rs.getString("tab"));
					fb.setSubject(rs.getString("subject"));
					fb.setContent(rs.getString("content"));
					fb.setRegdate(rs.getString("regdate"));
					fb.setId(rs.getString("id"));
					
					vfb.add(fb);
				}
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return vfb;
		}
		public FaqBean modifyData(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			FaqBean fb = null;
			
			try {
				con = pool.getConnection();
				sql = "select * from faqBoard where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1,num);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					fb = new FaqBean();
					fb.setNum(rs.getInt("num"));
					fb.setTab(rs.getString("tab"));
					fb.setSubject(rs.getString("subject"));
					fb.setContent(rs.getString("content"));
					fb.setRegdate(rs.getString("regdate"));
					fb.setId(rs.getString("id"));
				}
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return fb;
		}
		public int updateFaq(FaqBean fb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			int result = 0;
			
			try {
				con = pool.getConnection();
				sql = "update faqBoard set tab = ?, subject = ?, content = ?, regdate = now() where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, fb.getTab());
				pstmt.setString(2, fb.getSubject());
				pstmt.setString(3, fb.getContent());
				pstmt.setInt(4, fb.getNum());
				
				result = pstmt.executeUpdate();
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return result;
		}
		
		
		public  Vector<BoardBean> mainPageView(String noticeType) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			BoardBean fb = null;
			Vector<BoardBean> vlist = new Vector<BoardBean>();
			
			
			try {
				con = pool.getConnection();
				if(noticeType.equals("notice")) {
					sql = "select * from tblBoard where tblcode = 3 order by num desc limit 0, 5;";
					pstmt = con.prepareStatement(sql);
				}else {
					sql = "select * from tblBoard where tblcode != 3 order by num desc limit 0, 5;";
					pstmt = con.prepareStatement(sql);
				}
				
				rs = pstmt.executeQuery();
				while (rs.next()) {
					fb = new BoardBean();
					
					fb.setNum(rs.getInt("num"));
					fb.setName(rs.getString("name"));
					fb.setSubject(rs.getString("subject"));
					fb.setPos(rs.getInt("pos"));
					fb.setRef(rs.getInt("ref"));
					fb.setDepth(rs.getInt("depth"));
					fb.setRegdate(rs.getString("regdate"));
					fb.setCount(rs.getInt("count"));
					fb.setFilename(rs.getString("filename"));
					fb.setId(rs.getString("id"));
					fb.setTblcode(rs.getInt("tblcode"));
					
					vlist.add(fb);
				}
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return vlist;
		}
}
