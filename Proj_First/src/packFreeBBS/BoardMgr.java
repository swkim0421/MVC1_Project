package packFreeBBS;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardMgr {

	 private DBConnectionMgr pool;
	
	 private static final String SAVEFOLDER = "D:/Project/proj/Proj_First/WebContent/freeBBS_jsp/fileUpload";
	 private static final String ENCTYPE = "UTF-8";
	 private static int MAXSIZE = 10*1024*1024; //총 파일 사이즈 : 10MB
	 
	 public BoardMgr() {
	  try {
		  pool = DBConnectionMgr.getInstance();
	  } catch (Exception e) {
	   e.printStackTrace();	
	  }
}
 
	  //게시판 리스트
	  public List<BoardBean> getFreeBoardList(String keyField, String keyWord, int start, int end){
	  Connection con = null;
	  PreparedStatement pstmt = null;
	  ResultSet rs = null;
	  String sql = null;
	  List<BoardBean> list = new ArrayList<>();

	  try {
		   con = pool.getConnection();
		   if (keyWord.equals("null") || keyWord.equals("")) {
			   
			sql = "select * from tblBoard order by ref asc limit ?, ?;";
		    pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
		   }else{
			sql = "select * from  tblBoard where " + keyField + " like ? ";
			sql += "order by ref desc, pos limit ? , ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyWord + "%");
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
		   }
		   
		   rs = pstmt.executeQuery();
		   while(rs.next()){

			    BoardBean bean = new BoardBean();
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setCount(rs.getInt("count"));
				list.add(bean);
		   }

		  } catch (SQLException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
				return list;
			}

	 //총 게시물수
	 public int getTotalCount(String keyField, String keyWord){

	  Connection con = null;
	  PreparedStatement pstmt = null;
	  ResultSet rs = null;
	  String sql = null;
	  int totalCount = 0;

	  try {
			con = pool.getConnection();
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(num) from tblBoard where tblcode=1";
				pstmt = con.prepareStatement(sql);
			} else {
				sql = "select count(num) from  tblBoard where tblcode=1 and " + keyField + " like ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

	 //게시판 입력
	 public void insertFreeBoard(HttpServletRequest req){
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  String sql = null;
		  ResultSet rs = null;
		  MultipartRequest multi = null;
		  int filesize=0;
		  String filename=null;

		  try {
		   con = pool.getConnection();
		   sql = "select max(num) from tblBoard";
		   pstmt = con.prepareStatement(sql);
		   rs = pstmt.executeQuery();
		   int ref = 1;
		   
		   if(rs.next())
			   ref = rs.getInt(1)+1;

		   //자동 폴더 생성
		   File file = new File(SAVEFOLDER);

		   if(!file.exists()){
		    file.mkdirs();
		   }
		   multi = new MultipartRequest(req,SAVEFOLDER,MAXSIZE,ENCTYPE,
		     new DefaultFileRenamePolicy());
		   if(multi.getFilesystemName("filename")!=null){
		    filename = multi.getFilesystemName("filename");
		    filesize = (int)multi.getFile("filename").length();
		   }
		   String content = multi.getParameter("content");
		   if(multi.getParameter("contentType").equalsIgnoreCase("TEXT")){
		    content = UtilMgr.replace(content, "<", "&lt;");
		   }

		   sql = "insert tblBoard(name,content,subject,ref,pos,depth,regdate,pass,count,ip,filename,filesize,tblcode, id)";
		   sql += "values(?, ?, ?, ?, 0, 0, now(), ?, 0, ?, ?, ?, 1, ?)";
		   pstmt = con.prepareStatement(sql);
		   pstmt.setString(1, multi.getParameter("name"));
		   pstmt.setString(2, content);
		   pstmt.setString(3, multi.getParameter("subject"));
		   pstmt.setInt(4, ref);
		   pstmt.setString(5, multi.getParameter("pass"));
		   pstmt.setString(6, multi.getParameter("ip"));
		   pstmt.setString(7, filename);
		   pstmt.setInt(8, filesize);
		   pstmt.setString(9, multi.getParameter("id"));
		   pstmt.executeUpdate();

		  } catch (Exception e) {
		   e.printStackTrace();
		  } finally {
		   pool.freeConnection(con, pstmt,rs);
		  }
		 }
	 
	 //게시물 리턴
	 public BoardBean getFreeBoard(int num){
	  Connection con = null;
	  PreparedStatement pstmt = null;
	  ResultSet rs = null;
	  String sql = null;
	  BoardBean bean = new BoardBean();

	  try {
	   con = pool.getConnection();
	   sql = "select * from tblBoard where num=?";
	   pstmt = con.prepareStatement(sql);
	   pstmt.setInt(1, num);
	   rs = pstmt.executeQuery();

	   if(rs.next()) {
			    bean.setNum(rs.getInt("num"));
			    bean.setName(rs.getString("name"));
			    bean.setSubject(rs.getString("subject"));
			    bean.setContent(rs.getString("content"));
			    bean.setPos(rs.getInt("pos"));
			    bean.setRef(rs.getInt("ref"));
			    bean.setDepth(rs.getInt("depth"));
			    bean.setRegdate(rs.getString("regdate"));
			    bean.setPass(rs.getString("pass"));
			    bean.setCount(rs.getInt("count"));
			    bean.setFilename(rs.getString("filename"));
			    bean.setFilesize(rs.getInt("filesize"));
			    bean.setIp(rs.getString("ip"));
			    bean.setTblcode(rs.getInt("tblcode"));
			    bean.setId(rs.getString("id"));
	   }
	  } catch (Exception e) {
	   e.printStackTrace();
	  }finally{
		  	pool.freeConnection(con, pstmt, rs);
	  }
	  return bean;
	 }
	 
	 //조회수 증가
	 public void upCount(int num){

	  Connection con = null;
	  PreparedStatement pstmt = null;
	  String sql = null;

	  try {
	   con = pool.getConnection();
	   sql = "update tblBoard set count=count+1 where num=?";
	   pstmt = con.prepareStatement(sql);
	   pstmt.setInt(1, num);
	   pstmt.executeUpdate();
	   
	  } catch (Exception e) {
	   e.printStackTrace();
	  }finally{
	   pool.freeConnection(con, pstmt);
	  }
	}

	 //게시물 삭제
	 public void deleteFreeBoard(int num){

	  Connection con = null;
	  PreparedStatement pstmt = null;
	  String sql = null;
	  ResultSet rs = null;

	  try {
	   con = pool.getConnection();
	   sql = "select filename from tblBoard where num=?";
	   pstmt = con.prepareStatement(sql);
	   pstmt.setInt(1, num);
	   rs = pstmt.executeQuery();

	   if(rs.next() && rs.getString(1) != null){
	    if(!rs.getString(1).equals("")){

	     //파일이 첨부된 게시물
	      File file = new File(SAVEFOLDER+"/"+rs.getString(1));
	      if(file.exists())
	       UtilMgr.delete(SAVEFOLDER+"/"+rs.getString(1));
	      }
	    }	  
	   
	    sql = "delete from tblBoard where num=?";
	    pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, num);
		pstmt.executeUpdate();
	   
	   }catch (Exception e) {
	   e.printStackTrace();
	  } finally {
	   pool.freeConnection(con, pstmt, rs);
	  }
    }
	 //게시물 수정
	 public void updateFreeBoard(BoardBean bean){
		 
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  String sql = null;
	  try {
		   con = pool.getConnection();
		   sql = "update tblBoard set name=?,subject=?,content=? where num=?";
		   pstmt = con.prepareStatement(sql);
		   pstmt.setString(1, bean.getName());
		   pstmt.setString(2, bean.getSubject());
		   pstmt.setString(3, bean.getContent());
		   pstmt.setInt(4, bean.getNum());
		   pstmt.executeUpdate();
		   
		  } catch (Exception e) {
		   e.printStackTrace();
		  }finally{
		   pool.freeConnection(con, pstmt);
		  }
		 }

	 //게시물 답변
	 public void replyFreeBoard(BoardBean bean) {
		 Connection con = null;
		 	PreparedStatement pstmt = null;
		 	ResultSet rs = null;
		 	String sql = null;
		 	
		 	try {
		 		con = pool.getConnection();
		 		sql = "insert tblBoard (name, content, subject, ref, pos, depth, regdate, pass, count, ip)";
		 			sql += "values(?, ?, ?, ?, ?, ?, now(), ?, 0, ?)";
		 			int depth = bean.getDepth() +1;
		 			int pos = bean.getPos() + 1;
		 			
		 		   pstmt = con.prepareStatement(sql);
		 		   pstmt.setString(1, bean.getName());
		 		   pstmt.setString(2, bean.getContent());
		 		   pstmt.setString(3, bean.getSubject());
		 		   pstmt.setInt(4, bean.getRef());
		 		   pstmt.setInt(5, pos);
		 		   pstmt.setInt(6, depth);
		 		   pstmt.setString(7, bean.getPass());
		 		   pstmt.setString(8, bean.getIp());
		 		   pstmt.executeUpdate();
		 		   
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				   pool.freeConnection(con, pstmt, rs);
			  }
	 }

	 //답변에 위치값 증가
	 public void replyUpFreeBoard(int ref, int pos) {
		 	Connection con = null;
		 	PreparedStatement pstmt = null;
		 	ResultSet rs = null;
		 	String sql = null;
		 	
		 	try {
		 		con = pool.getConnection();
		 		sql = "update tblBoard set pos= pos + 1 where ref=? and pos > ?";
		 					 			
		 		   pstmt = con.prepareStatement(sql);
		 		   pstmt.setInt(1, ref);
		 		   pstmt.setInt(2, pos);
		 		   pstmt.executeUpdate();
		 		   
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				   pool.freeConnection(con, pstmt, rs);
			  }
	 }
	 
	//로그인된 계정의 이름을 게시판에서 글작성시 표시됨
		public String getWriterName(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			String name = null;
			
			try {
				con=pool.getConnection();
				sql="select * from tblMember where id=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs=pstmt.executeQuery();

				if(rs.next()) {			
				name=rs.getString("name");
				}
			}catch (Exception e) {
				e.printStackTrace();
				System.out.println(e.getMessage());
			}finally {
				pool.freeConnection(con,pstmt,rs);
			}
			return name;
		}

		 //파일 다운로드
		 public void downLoad(HttpServletRequest req, HttpServletResponse res, JspWriter out,PageContext pageContext) {
				
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
		 
		//페이징 및 블럭 테스트를 위한 게시물 저장 메소드 
				public void post1000(){
					Connection objConn = null;
					PreparedStatement objPstmt = null;
					ResultSet objRs = null;
					String sql = null;
					try {
						objConn = pool.getConnection();
						sql = "insert tblBoard(name,content,subject,ref,pos,depth,regdate,pass,count,ip,filename,filesize)";
						sql+="values('aaa', 'bbb', 'ccc', 0, 0, 0, now(), '1234',0, '127.0.0.1', null, 0);";
						objPstmt = objConn.prepareStatement(sql);
						for (int i = 0; i < 1000; i++) {
							objPstmt.executeUpdate();
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(objConn, objPstmt);
					}
				}
}