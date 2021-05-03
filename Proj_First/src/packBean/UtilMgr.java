package packBean;

import java.io.File;

public class UtilMgr {
	
	
	public static String replace(String str,String pattern, String replace) {
		
		int i=0,j=0;
		StringBuffer res = new StringBuffer();
		
		while ((j = str.indexOf(pattern, i)) >= 0) {
			res.append(str.substring(i, j));
			res.append(replace);
			i = j + pattern.length();
		}
		res.append(str.substring(i));
		return res.toString();
	}
	
	public static void delete(String s) {
		
		File file = new File(s);
		if(file.isFile()) {
			file.delete();
		}
	}
/*
	public static String con(String s) {
		String str = null;
		try {
			str = new String(s.getBytes("8859_1"), "ksc5601");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	*/

}
