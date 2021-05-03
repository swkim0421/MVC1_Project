package packB;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import packA.DBConnectionMgr;

public class BoardMgr_lyj {

	private DBConnectionMgr pool; // 객체 선언, 객체 반환
	private static final String SAVEFOLDER = "D:/Java/pradi/jsp2/Proj_First/WebContent/uploadFolder";
	private final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 5*1024*1024;
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
	public BoardMgr_lyj() {
		try {
			pool = DBConnectionMgr.getInstance(); // getInstance 메소드로 
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	// 게시판 리스트
	public Vector<BoardBean_lyj> getBoardList(String keyField, String keyWord,
			int start, int end) {
		
		Vector<BoardBean_lyj> vlist = new Vector<BoardBean_lyj>();
		try {
			con = pool.getConnection();	// pool 객체를 통해 DB 연결
			if(keyWord.equals("null") || keyWord.equals("")) {
				// 검색어가 없을 때 실행
				sql = "select * from tblBoard where tblcode=3 order by ref desc, pos limit ?, ?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			} else {
				sql = "select * from tblBoard where " + keyField + " like ? ";
					sql += "order by ref desc, pos limit ?, ?";
					
					
					
					
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1,  "%" + keyWord + "%");
					pstmt.setInt(2, start);
					pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardBean_lyj bean = new BoardBean_lyj();
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setCount(rs.getInt("count"));
				vlist.add(bean); // vlist에 add를 이용하여 bean 배열 뒤 추가
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 총 게시물 수
	public int getTotalCount(String keyField, String keyWord) {

		int totalCount = 0;
		try {
			con = pool.getConnection();
			if(keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(num) from tblBoard where tblcode=3"; // 모든 게시물의 개수 구함
				pstmt = con.prepareStatement(sql);
			} else {
				sql = "select count(num) from tblBoard where tblcode=3 and " + keyField + " like ? "; // 검색된 게시물의 개수
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	// 게시판 입력
	public int insertBoard(HttpServletRequest req) {

		MultipartRequest multi = null;
		int filesize = 0;
		String filename = null;
		int resCnt = 0;
		
		try {
			con = pool.getConnection();
			sql = "select max(num) from tblBoard where tblcode=3"; // 게시글 맨위로
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int ref = 1;
			int tblcode = 3;
			if(rs.next())
				ref = rs.getInt(1) + 1;
			
			File file = new File(SAVEFOLDER);
			if(!file.exists())
				file.mkdirs();
			
			req.setCharacterEncoding("UTF-8");
			multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE,
						new DefaultFileRenamePolicy());
			
			if(multi.getFilesystemName("filename") != null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFile("filename").length();
			}
			/*
			 * String content = multi.getParameter("content");
			 * if(multi.getParameter("contentType").equalsIgnoreCase("TEXT")) { content =
			 * UtilMgr_lyj.replace(content, "<", "&It;"); }
			 */

			sql = "insert tblBoard(name, content, subject, ref, pos, depth, regdate,"
			 		+ "pass, count, ip, filename, filesize, tblcode, id)";
			sql += "values(?, ?, ?, ?, 0, 0, now(), ?, 0, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
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
			resCnt = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return resCnt;
	}
	
	// 게시물 리턴
	public BoardBean_lyj getBoard(int num) {

		BoardBean_lyj bean = new BoardBean_lyj(); // SQL 문의 결과를 저장하기 위해서 객체생성
		try {
			con = pool.getConnection();
			sql = "select * from tblBoard where tblcode=3 and num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setContent(rs.getString("content"));
				bean.setSubject(rs.getString("subject"));
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
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	// 조회수 증가
	public void upCount(int num) {
		
		try {
			con = pool.getConnection();
			sql = "update tblBoard set count=count+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,  num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	// 게시물 삭제
	public void deleteBoard(int num) {

		try {
			con = pool.getConnection();
			sql = "select filename from tblBoard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,  num);
			rs = pstmt.executeQuery();
			if(rs.next() && rs.getString(1) != null) { // 0이 아닌 1부터 시작! 반드시 순차적 접근만 가능!!
				if(!rs.getString(1).equals("")) {
					File file = new File(SAVEFOLDER + "/" + rs.getString(1));
					if(file.exists())
						UtilMgr_lyj.delete(SAVEFOLDER + "/" + rs.getString(1));
				}
			}
			
			sql = "delete from tblBoard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,  num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	// 게시물 수정
	public void updateBoard(BoardBean_lyj bean) {

		try {
			con = pool.getConnection();
			sql = "update tblBoard set name=?, subject=?, content=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getSubject());
			pstmt.setString(3, bean.getContent());
			pstmt.setInt(4, bean.getNum());
			pstmt.executeQuery();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	// 게시물 답변
	public void replyBoard(BoardBean_lyj bean) {

		try {
			con = pool.getConnection();
			sql = "insert tblBoard (name, content, subject, ref, pos, depth, regdate"
					+ "pass, count, ip, tblcode";
			sql += "valuse(?, ?, ?, ?, ?, ?, now(), ?, 0, ?, ?)";
			int depth = bean.getPos() + 1; // 매개변수로 받은 depth값에 1을 증가
			int pos = bean.getPos() + 1; // 매개변수로 받은 pos값에 1을 증가
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getContent());
			pstmt.setString(3, bean.getSubject());
			pstmt.setInt(4, bean.getRef());
			pstmt.setInt(5, pos);
			pstmt.setInt(6, depth);
			pstmt.setString(7, bean.getPass());
			pstmt.setString(8, bean.getIp());
			pstmt.setInt(9, bean.getTblcode());
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	// 답변에 위치값 증가
	public void replyUpBoard(int ref, int pos) {

		try {
			con = pool.getConnection();
			sql = "update tblBoard set pos = pos + 1 where ref=? and pos > ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, pos);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	public void downLoad(HttpServletRequest req, HttpServletResponse res,
			JspWriter out, PageContext pageContext) {
		try {
			String filename = req.getParameter("filename");
			File file = new File(UtilMgr_lyj.con(SAVEFOLDER + File.pathSeparator + filename));
			byte b[] = new byte[(int)file.length()];
			// res 응답객체
			res.setHeader("Accept-Ranges", "bytes");
			String strClient = req.getHeader("User-Agent");
			if(strClient.indexOf("MSIE6.0") != -1) {
				res.setContentType("application/smnet;charset=UTF-8");
				res.setHeader("Content-Disposition", "filename=" + filename + ";");
			} else {
				res.setContentType("application/smnet;charset=UTF-8");
				res.setHeader("Content-Disposition", "attachment;filename=" + filename + ";");
			}
			out.clear();
			out=pageContext.pushBody(); // 파일 존재 여부에 따라 스트링 방식으로 브라우저로 파일을 전송한다.
			if(file.isFile()) {
				BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
				BufferedOutputStream outs = new BufferedOutputStream(res.getOutputStream());
				int read = 0;
				while((read = fin.read(b)) != -1) {
					outs.write(b, 0, read);
				}
				outs.close();
				fin.close();
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	// 페이징 및 블럭 테스트를 위한 게시물 저장 메서드
	public void post1000() {

		try {
			con = pool.getConnection();
			sql = "insert tblBoard(name, content, subject, ref, pos, depth, regdate"
					+ "pass, count, ip, filename, filesize, tblcode, id)";
			sql += "values('aaa', 'bbb', 'ccc', 0, 0, 0, now(), '1111', 0, '127.0.0.1', null, 0, 0, 'ddd');";
			pstmt = con.prepareStatement(sql);
			for(int i=0; i<1000; i++) {
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
}
