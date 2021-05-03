package packBean;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class BoardMgr {
	private DBConnectionMgr pool;
	private static final String SAVEFOLDER = "D:/Java/pradi/jsp2/Proj_First/WebContent/uploadFolder";
	private static final String ENCTYPE = "UTF-8";
	private static final int MAXSIZE = 10*1024*1024;
	
	String sql = null;
	ResultSet objRs = null;
	Connection objConn = null;
	PreparedStatement objpstmt = null;
	
	////////////////DBConnectionMgr �뿰寃�
	public BoardMgr() {
		
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			System.out.println("Boardmgr EXception : "+e.getMessage());
		}
	}
	
	/////////////////////////////////list.jsp寃뚯떆�뙋 由ъ뒪�듃(�씠�빐�븞�뤌)(�셿
	public Vector<BoardBean> getBoardList(String keyField, String keyWord,int start,int end) {
		
		Vector<BoardBean> vlist = new Vector<BoardBean>();
		
		try {
			
			if(keyWord.equals("null")||keyWord.equals("")) {
				sql = "select * from tblboard where tblcode=4 order by num desc limit ?,?;";
				objpstmt = objConn.prepareStatement(sql);
				objpstmt.setInt(1, start);
				objpstmt.setInt(2, end);
			}else {
				sql = "select * from tblBoard where" + keyField +
						"like ? order by ref desc,pos limit ?,?";
				objpstmt = objConn.prepareStatement(sql);
				objpstmt.setString(1, "%"+keyWord+"%");
				objpstmt.setInt(2, start);
				objpstmt.setInt(3, end);
			}
			objRs = objpstmt.executeQuery();
			while(objRs.next()) {
				BoardBean bean = new BoardBean();
				bean.setNum(objRs.getInt("num"));
				bean.setName(objRs.getString("name"));
				bean.setSubject(objRs.getString("subject"));
				bean.setPos(objRs.getInt("pos"));
				bean.setRef(objRs.getInt("ref"));
				bean.setDepth(objRs.getInt("depth"));
				bean.setRegdate(objRs.getString("Regdate"));
				bean.setCount(objRs.getInt("count"));
				vlist.add(bean);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch(Exception e){
			e.printStackTrace();
		}finally {
			pool.freeConnection(objConn,objpstmt,objRs);
		}
		
	
		return vlist;
	}
		
	//
	/////////////////////////////////////寃뚯떆臾� �엯�젰(�셿
	public int insertBoard(HttpServletRequest req) {
		
		MultipartRequest multi = null;
		int filesize = 0;
		String filename = null;
		int resCnt = 0;
		int tblcode = 4;
		
		try {
			objConn = pool.getConnection();
			sql = "SELECT MAX(NUM) FROM TBLBOARD where tblcode=4";
			objpstmt = objConn.prepareStatement(sql);
			objRs = objpstmt.executeQuery();
			int ref = 1;
			if(objRs.next()) {
				ref = objRs.getInt(1)+1;
			}
			File file = new File(SAVEFOLDER);
			if(!file.exists()) {
				file.mkdirs();
			}
			req.setCharacterEncoding("UTF-8");
			multi = new MultipartRequest(req, SAVEFOLDER,MAXSIZE,ENCTYPE,
					new DefaultFileRenamePolicy());
			
			if(multi.getFilesystemName("filename")!=null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int) multi.getFile("filename").length();
			}
			String content = multi.getParameter("content");
//			if(multi.getParameter("contentType").equalsIgnoreCase("TEXT")) {
//				content = UtilMgr.replace(content,"<","&lt;");
//			}
			sql = "insert tblBoard(name,content,subject,ref,pos,depth,regdate,pass,count,ip,filename,filesize,tblcode)";
			sql+="values(?,?,?,?,0,0,now(),?,0,?,?,?,?)";
			 
			objpstmt = objConn.prepareStatement(sql);
			objpstmt.setString(1, multi.getParameter("name"));
			objpstmt.setString(2, content);
			objpstmt.setString(3, multi.getParameter("subject"));
			objpstmt.setInt(4, ref);
			objpstmt.setString(5, multi.getParameter("pass"));
			objpstmt.setString(6, multi.getParameter("ip"));
			objpstmt.setString(7, filename);
			objpstmt.setInt(8, filesize);
			objpstmt.setInt(9, tblcode);
			

			resCnt = objpstmt.executeUpdate();
			//executeUpdate �궗�슜�떆
			//insert,update,delete媛숈씠 �궡�슜�쓣 �꽔嫄곕굹 吏��슱�븣�궗�슜�븿,異쒕젰�떆 0�삉�뒗 1濡� 諛섑솚
			//executeQuery�뒗 珥� 異쒕젰 媛��닔濡� 諛섑솚(select臾몄뿉�꽌留� �궗�슜)
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(objConn,objpstmt,objRs);
		}
		
		return resCnt;
		
	}
	//
	////////////////////////////////////select(�셿
	public BoardBean getBoard(int num) {
		BoardBean bean = new BoardBean();
		
		try {
			objConn = pool.getConnection();
			sql = "select * from tblboard where tblcode=4 and num=?";
			objpstmt = objConn.prepareStatement(sql);
			objpstmt.setInt(1, num);
			objRs = objpstmt.executeQuery();
			

			if(objRs.next()) {
				bean.setNum(objRs.getInt("num"));
				bean.setName(objRs.getString("name"));
				bean.setSubject(objRs.getString("subject"));
				bean.setContent(objRs.getString("content"));
				bean.setPos(objRs.getInt("pos"));
				bean.setRef(objRs.getInt("ref"));
				bean.setDepth(objRs.getInt("depth"));
				bean.setRegdate(objRs.getString("regdate"));
				bean.setPass(objRs.getString("pass"));
				bean.setIp(objRs.getString("ip"));
				bean.setCount(objRs.getInt("count"));
				bean.setFilename(objRs.getString("filename"));
				bean.setFilesize(objRs.getInt("filesize"));
				bean.setTblcode(objRs.getInt("tblcode"));
				bean.setId(objRs.getString("id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(objConn,objpstmt,objRs);
		}
		return bean;
	}
	
	///////////////////////////議고쉶�닔 利앷�(�셿
	public void upCount(int num) {
		String sql = null;
		
		try {
			objConn = pool.getConnection();
			sql = "UPDATE TBLBOARD SET COUNT=COUNT+1 WHERE NUM=?";
			objpstmt = objConn.prepareStatement(sql);
			objpstmt.setInt(1, num);
			objpstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(objConn,objpstmt);
		}
	}
	
/////////////////////寃뚯떆臾쇱궘吏�(�셿
	public void deleteBoard(int num) {
		try {
			objConn = pool.getConnection();
			sql = "select filename from tblboard where num=?";
			objpstmt = objConn.prepareStatement(sql);
			objpstmt.setInt(1, num);
			objRs=objpstmt.executeQuery();
			
			
			if(objRs.next()&&objRs.getString(1)!=null) {
				if(!objRs.getString(1).equals("")) {
					File file = new File(SAVEFOLDER + "/" +objRs.getString(1));
					if(file.exists()) {
						UtilMgr.delete(SAVEFOLDER + "/" +objRs.getString(1));
					}
				}
			}
			
			sql = "delete from tblboard where num=?";
			objpstmt = objConn.prepareStatement(sql);
			objpstmt.setInt(1, num);
			objpstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(objConn,objpstmt,objRs);
		}
	}

/////////////////////寃뚯떆臾쇱닔�젙(�셿
	public void updateBoard(BoardBean bean) {
		
		try {
			objConn =pool.getConnection();
			sql = "update tblBoard set name=?,subject=?,content=? where num=?";
			objpstmt=objConn.prepareStatement(sql);
			objpstmt.setString(1, bean.getName());
			objpstmt.setString(2, bean.getSubject());
			objpstmt.setString(3, bean.getContent());
			objpstmt.setInt(4, bean.getNum());
			objpstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(objConn,objpstmt);
		}
	}
	
	//寃뚯떆臾� �떟蹂�(�셿
	public void reply(BoardBean bean) {
		
		
		String Id = "F12+Alt";
		int tblcode =4;
		int depth = bean.getDepth()+1;
		int pos = bean.getPos()+1;
		
		try {
			objConn=pool.getConnection();
			sql = "insert tblBoard(name,content,subject,ref,"
					+ "pos,depth,regdate,pass,count,ip,filename,filesize,tblcode,id)";
			sql += "values(?, ?, ?, ?, 0, 0, now(), ?, 0, ?, ?, ?,?,?)";
			
			objpstmt = objConn.prepareStatement(sql);
		
			objpstmt.setString(1, bean.getName());
			objpstmt.setString(2,bean.getContent());
			objpstmt.setString(3, bean.getSubject());
			objpstmt.setInt(4, bean.getRef());
//			objpstmt.setInt(5, depth);
			objpstmt.setString(5, bean.getPass());
			objpstmt.setString(6, bean.getIp());
			objpstmt.setString(7, bean.getFilename());
			objpstmt.setInt(8, bean.getFilesize());
			objpstmt.setInt(9, tblcode);
			objpstmt.setString(10,Id);
			
			objpstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(objConn,objpstmt,objRs);
		}
	}
	
	//�떟蹂��뿉 �쐞移섍컪 利앷�
	
	public void replyupboard(int ref, int pos) {
		try {
			objConn=pool.getConnection();
			sql = "update tblboard set pos=pos+1 where ref=? and pos > ?";
			objpstmt=objConn.prepareStatement(sql);
			objpstmt.setInt(1, ref);
			objpstmt.setInt(2, pos);
			objpstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(objConn,objpstmt);
		}
	}
	
	//
	public int getTotalCount(String keyField, String keyWord) {
		int totalCount = 0;
		try {
			objConn = pool.getConnection();
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(num) from tblBoard where tblcode=4";
				objpstmt = objConn.prepareStatement(sql);
			} else {
				sql = "select count(num) from  tblBoard where tblcode=4 and " + keyField + " like ? ";
				objpstmt = objConn.prepareStatement(sql);
				objpstmt.setString(1, "%" + keyWord + "%");
			}
			objRs = objpstmt.executeQuery();
			if (objRs.next()) {
				totalCount = objRs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(objConn, objpstmt, objRs);
		}
		return totalCount;
	}
	
	//�럹�씠吏�(�셿 �씠�빐紐삵븿
	public void postpost() {
		try {
			objConn = pool.getConnection();
			sql = "insert tblBoard(name,content,subject,ref,"
					+ "pos,depth,regdate,pass,count,ip,filename,filesize,tblcode,id)";
			sql+="value('aaa','qwe','ewq',0,0,0,now(),'1234',0,'127.0.0.1',null,0,4,'anonymus');";
			objpstmt = objConn.prepareStatement(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(objConn,objpstmt);
		}
	}
	
	
	
	///////////�떎�슫濡쒕뱶(0320蹂듬텤)
	public void downLoad(HttpServletRequest req, HttpServletResponse res,
			JspWriter out,PageContext pageContext) {
		
	try{
		String filename = req.getParameter("filename");
		File file = new File(SAVEFOLDER + File.separator + filename);
		byte b[] = new byte[(int)file.length()];
		
		res.setHeader("Accept-Ranges", "bytes");
		String strClient = req.getHeader("User-Agent");

		if (strClient.indexOf("Trident") > 0 || strClient.indexOf("MSIE") > 0) {
			res.setContentType("application/smnet;charset=UTF-8");
			res.setHeader("Content-Disposition", "filename="
					+ new String(filename.getBytes("EUC-KR"),"8859_1") + ";");
		} else {
			res.setContentType("application/smnet;charset=UTF-8");
			res.setHeader("Content-Disposition",
				"attachment;filename=" 
				+ new String(filename.getBytes("UTF-8"),"ISO-8859-1") + ";");
		}

		out.clear();
		if (file.isFile()) {
			BufferedInputStream fin = new BufferedInputStream(
							new FileInputStream(file));
			BufferedOutputStream outs = new BufferedOutputStream(
							res.getOutputStream());
			int read = 0;
			while ((read = fin.read(b)) != -1) {
				outs.write(b, 0, read);
			}
			outs.close();
			fin.close();
		}
	}catch(Exception e){
		e.printStackTrace();
	}
			
}	
	public static void main(String[] args) {
		new BoardMgr().postpost();
	}
	
///////////////////////
}
