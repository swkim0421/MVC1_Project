package packImgBBS;

import java.io.File;

public class UtilMgr {

	//첫번째 매개변수로 받은 문자열 중에 두번째 매개변수의 문자열을 세번째 매개변수로 변환시키는 메소드
		public static String replace(String str, String pattern, String replace) {
			                                       //  content,     "<"        ,   "&lt;"     
			int s = 0, e = 0;
			StringBuffer result = new StringBuffer();

			while ((e = str.indexOf(pattern, s)) >= 0) {
				result.append(str.substring(s, e));
				result.append(replace);
				s = e + pattern.length();
			}
			result.append(str.substring(s));
			return result.toString();
		}

		//매개변수로 받은 파일(문자열)을 삭제 시키는 메소드
		public static void delete(String s) {
			File file = new File(s);
			 
			if (file.isFile()) {
				file.delete();
			}
			
		}

	    
		public static String con(String s) {
			String str = null;
			try {
				str = new String(s.getBytes("8859_1"), "ksc5601");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return str;
		}

}
