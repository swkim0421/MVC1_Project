package packImgBBS;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardMgr {
	private DBConnectionMgr pool;
	private static final String SAVEFORDER="D:/Java/pradi/jsp2/Proj_First/WebContent/uploadFolder";
	private static final String ENCTYPE="UTF-8";
	private static int  MAXSIZE=10*1024*1024;
	
	public BoardMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public void insertImgBoard(HttpServletRequest req) throws UnsupportedEncodingException {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql=null;
		File thumbFile = null;
		MultipartRequest multi=null;
		int filesize=0;
		String filename=null;
		try {
			
			multi = new MultipartRequest(req, SAVEFORDER,MAXSIZE,ENCTYPE,new DefaultFileRenamePolicy());
			if(multi.getFilesystemName("filename") != null) {
				filename = multi.getFilesystemName("filename");				
				filesize=(int) multi.getFile("filename").length();
				
////////////////////////////썸네일 처리 시작 //////////////////////////////
ParameterBlock parameterBlock = new ParameterBlock();
parameterBlock.add(SAVEFORDER + "/" + filename);
RenderedOp renderedOp = JAI.create("fileload", parameterBlock);

BufferedImage bufferedImage = renderedOp.getAsBufferedImage();
BufferedImage bufferedImageThumb = new BufferedImage(133, 150, BufferedImage.TYPE_INT_RGB);

Graphics2D graphics2d = bufferedImageThumb.createGraphics();
graphics2d.drawImage(bufferedImage, 0, 0, 133, 150, null);


thumbFile = new File(SAVEFORDER + "/thm_" + filename);
ImageIO.write(bufferedImageThumb, "jpg", thumbFile);		
//////////////////////////////썸네일 처리 끝 //////////////////////////////
			}
								
		con=pool.getConnection();	
		sql="insert tblBoard(name,content,subject,ref,pos,depth,regdate,pass,count,ip,filename,filesize,tblcode,id)";
		sql+="values(?,?,?,?,0,0,now(),?,0,?,?,?,?,?)";
		pstmt=con.prepareStatement(sql);
		int ref=1;
		int tblcode=2; 
		
		
		
		pstmt.setString(1, multi.getParameter("name"));
		pstmt.setString(2, multi.getParameter("content"));
		pstmt.setString(3, multi.getParameter("subject"));
		pstmt.setInt(4, ref);
		pstmt.setString(5, multi.getParameter("pass"));
		pstmt.setString(6, multi.getParameter("ip"));
		pstmt.setString(7, filename);
		pstmt.setInt(8, filesize);
		pstmt.setInt(9, tblcode);
		pstmt.setString(10, multi.getParameter("id"));
				
		pstmt.executeUpdate();
		
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}finally {
			pool.freeConnection(con,pstmt);
		}
	}
	
	public BoardBean getImgBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql=null;
		BoardBean bean=new BoardBean();
		
		try {
			con=pool.getConnection();
			sql="select * from tblBoard where num=? and tblcode=2";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
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
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		
		
		return bean;
		
	}
	//조회수 
	
	public void upCount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql=null;
		
		try {
			con=pool.getConnection();
			sql="update tblBoard set count=count+1 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt);
		}
	}
	
	
	//리스트 뿌려주기
	public List<BoardBean> getBoardImgList(int start,int end) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		String sql=null;
		List<BoardBean> vlist =new ArrayList<>();
		
		try {
			con=pool.getConnection();
			sql="select * from tblBoard where tblcode=2 order by num desc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean bean=new BoardBean();
				
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setFilename(rs.getString("filename"));
				bean.setSubject(rs.getString("subject"));
				bean.setCount(rs.getInt("count"));
				
				vlist.add(bean);
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		
		return vlist;
	}
	
	// 전체 레코드수 얻기
	public int getTotalImgCount() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql=null;
		int totalRecord=0;
		try {
			con=pool.getConnection();
			sql="select count(num) from tblBoard where tblcode=2";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				totalRecord+=rs.getInt(1);
				
				
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return totalRecord;
	}
	// 댓글 추가
	public void replyBoard(int num,String content,String name,String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql=null;
		ResultSet rs= null;
		
		try {
			con=pool.getConnection();
			sql="insert into tblReply(name,id,content,regdate,Ref)";
			sql+="values(?,?,?,now(),?)";
			pstmt=con.prepareStatement(sql);
			

			
			pstmt.setString(1, name);
			pstmt.setString(2, id);
			pstmt.setString(3, content);
			pstmt.setInt(4, num);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt);
		}
	}
	//댓글 뿌려주기
	
	public List<BoardBean> getReplyBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		String sql=null;
		List<BoardBean> vlist =new ArrayList<>();
		
		try{
			con=pool.getConnection();
			sql="select content,regdate,name from tblReply where Ref=? order by lino";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
			while (rs.next()) {
				BoardBean bean=new BoardBean();
				bean.setContent(rs.getString("content"));				
				bean.setRegdate(rs.getString("regdate"));
				bean.setName(rs.getString("name"));
				
				vlist.add(bean);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		
		
		
		return vlist; 
	}
	// 수정하기
	public String updateImgBoard(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql=null;
		MultipartRequest multi=null;
		int filesize=0;
		String filename=null;
		String url = "1";
		File thumbFile = null;
		try {
			con=pool.getConnection();
			
			multi = new MultipartRequest(req, SAVEFORDER,MAXSIZE,ENCTYPE,new DefaultFileRenamePolicy());
			int num= Integer.parseInt(multi.getParameter("num"));
			
			if(multi.getFilesystemName("filename") == null) {
				
				sql="update tblBoard set subject=?, content=? where num=?";
			pstmt=con.prepareStatement(sql);																	
			
			url = "read.jsp?nowPage="+multi.getParameter("nowPage")+"&num="+num;
			
			pstmt.setString(1, multi.getParameter("subject"));
			pstmt.setString(2, multi.getParameter("content"));
			pstmt.setInt(3, num);
			pstmt.executeUpdate();
			
			}else {
			///////////////////////////////////////////////////////////////
			sql = "select filename from tblBoard where num=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1) != null) {
					if(!rs.getString(1).equals("")) {
					File file[] = {new File(SAVEFORDER + "/thm_" + rs.getString(1)),new File(SAVEFORDER + "/" + rs.getString(1))};
						for (int i = 0; i < file.length; i++) {						
							Thread.sleep(100);
							System.gc();
							file[i].delete();
							System.gc();
						}
					
					}
				}
				}
			/////////////////////////////////////////////////////////////
			sql="update tblBoard set subject=?, content=?, filename=? ,filesize=? where num=?";
			pstmt=con.prepareStatement(sql);
											
			if(multi.getFilesystemName("filename") != null) {
				filename = multi.getFilesystemName("filename");				
				filesize=(int) multi.getFile("filename").length();		
				
				////////////////////////////썸네일 처리 시작 //////////////////////////////
				ParameterBlock parameterBlock = new ParameterBlock();
				parameterBlock.add(SAVEFORDER + "/" + filename);
				RenderedOp renderedOp = JAI.create("fileload", parameterBlock);
				
				BufferedImage bufferedImage = renderedOp.getAsBufferedImage();
				BufferedImage bufferedImageThumb = new BufferedImage(133, 150, BufferedImage.TYPE_INT_RGB);
				
				Graphics2D graphics2d = bufferedImageThumb.createGraphics();
				graphics2d.drawImage(bufferedImage, 0, 0, 133, 150, null);
				
				
				thumbFile = new File(SAVEFORDER + "/thm_" + filename);
				ImageIO.write(bufferedImageThumb, "jpg", thumbFile);		
				//////////////////////////////썸네일 처리 끝 //////////////////////////////
				
			}
			
			
			url = "read.jsp?nowPage="+multi.getParameter("nowPage")+"&num="+num;
			
			pstmt.setString(1, multi.getParameter("subject"));
			pstmt.setString(2, multi.getParameter("content"));
			pstmt.setString(3, filename);
			pstmt.setInt(4, filesize);
			pstmt.setInt(5, num);
			pstmt.executeUpdate();
			////////////////////////////////////////////////////////////////////////
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return url;
	}
	
	
	
	//삭제
	public void deleteBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		String sql=null;
		try {
			con = pool.getConnection();
			sql = "select filename from tblBoard where num=?";
			pstmt= con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
			if(rs.getString(1) != null) {
				if(!rs.getString(1).equals("")) {
				File file[] = {new File(SAVEFORDER + "/thm_" + rs.getString(1)),new File(SAVEFORDER + "/" + rs.getString(1))};
					for (int i = 0; i < file.length; i++) {						
						Thread.sleep(100);
						System.gc();
						file[i].delete();
						System.gc();
					}
				
				}
			}
			}
			
			sql="delete from tblBoard where num=?";
			pstmt =con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "delete from tblreply where ref = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
	}catch(Exception e) {
		e.printStackTrace();
	}finally {
		pool.freeConnection(con,pstmt,rs);
	}
	
}
	
	//닉네임 얻기
	public String getNicName(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql=null;
		String name=null;
		
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
	
	
	
	//다운로드 소스 
	
	public void downLoad(HttpServletRequest req, HttpServletResponse res,
			JspWriter out,PageContext pageContext) {
		
	try{
		String filename = req.getParameter("filename");
		File file = new File(SAVEFORDER + File.separator + filename);
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
		
		
		
		public int replyCnt(int num) {
			Connection con=null;
			PreparedStatement pstmt=null;
			String sql=null;
			ResultSet rs=null;
			int cnt=0;
			try {
				con=pool.getConnection();
				sql="select count(ref) from tblreply where ref=?";
				pstmt=con.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				
				rs=pstmt.executeQuery();
				if(rs.next()) {
				cnt=rs.getInt(1);
				}
				
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				pool.freeConnection(con,pstmt,rs);
			}
			return cnt;
		}
		
		
	
}




