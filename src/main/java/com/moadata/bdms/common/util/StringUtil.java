package com.moadata.bdms.common.util;

import org.apache.commons.lang.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * StringUtil
 * 
 */
public final class StringUtil {
    
    private StringUtil() {
        throw new AssertionError();
    }
    
    /**
     * 문자열의 Empty or Null 체크
     * 
     * @param str
     * @return
     */
    public static boolean isEmpty(String str) {
        //return (str == null || str.trim().equals(""));
        return (str == null || str.trim().length() == 0);
    }
    
    /**
     * 문자열의 Null 값 치환
     * 
     * @param str
     * @param replacer
     * @return
     */
    public static String nvl(String str, String replacer) {
        if (str == null || str.equals("null")) {
            return replacer;
        } else {
            return str;
        }
    }
    
    /**
     * 문자열을 특정 크기로 잘라낸다.
     * 
     * @param strSource
     * @param cutByte
     * @return
     */
    public static String cutString(String strSourceStr, int cutByte,
            String strPostfixStr) {
        
        boolean bTrim = false;
        String strSource = strSourceStr;
        String strPostfix = strPostfixStr;
        
        if (strSource == null) { return ""; }
        
        strPostfix = (strPostfix == null) ? "" : strPostfix;
        int postfixSize = 0;
        for (int i = 0; i < strPostfix.length(); i++) {
            if (strPostfix.charAt(i) < 256) {
                postfixSize += 1;
            } else {
                postfixSize += 2;
            }
        }
        
        if (postfixSize > cutByte) { return strSource; }
        
        if (bTrim) {
            strSource = strSource.trim();
        }
        char[] charArray = strSource.toCharArray();
        
        int strIndex = 0;
        int byteLength = 0;
        for (; strIndex < strSource.length(); strIndex++) {
            
            int byteSize = 0;
            if (charArray[strIndex] < 256) {
                // 1byte character 이면
                byteSize = 1;
            } else {
                // 2byte character 이면
                byteSize = 2;
            }
            
            if ((byteLength + byteSize) > cutByte - postfixSize) {
                break;
            }
            
            byteLength += byteSize;
            // byteLength = byteLength += byteSize;
        }
        
        if (strIndex == strSource.length()) {
            strPostfix = "";
        } else {
            if ((byteLength + postfixSize) < cutByte) {
                strPostfix = " " + strPostfix;
            }
        }
        
        return strSource.substring(0, strIndex) + strPostfix;
    }
    
    /**
     * delimeter로 년,월,일을 구분해서 나눈다.
     * 
     * @param value
     *            HHMMSS로 구성되어 있는 String
     * @return 구분자로 구분이 된 결과 값
     */
    public static String formatDate(String str, String delimeter) {
        if (str == null || str.length() != 8) { return ""; }
        
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(str.substring(0, 4));
        buffer.append(delimeter);
        buffer.append(str.substring(4, 6));
        buffer.append(delimeter);
        buffer.append(str.substring(6, 8));
        
        return buffer.toString();
    }
    
    public static String formatDate(String str) {
        return formatDate(str, ".");
    }
    
    /**
     * delimeter로 시,분,초 을 구분해서 나눈다.
     * 
     * @param value
     *            HHMMSS로 구성되어 있는 String
     * @return 구분자로 구분이 된 결과 값
     */
    public static String formatTime(String str, String delimeter) {
        if (str == null || str.length() != 6) { return ""; }
        
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(str.substring(0, 2));
        buffer.append(delimeter);
        buffer.append(str.substring(2, 4));
        buffer.append(delimeter);
        buffer.append(str.substring(4, 6));
        
        return buffer.toString();
    }
    
    public static String formatTime(String str) {
        return formatTime(str, ":");
    }
    
    /**
     * 넘어온 값에 세자리마다 ','를 넣어주는 함수.
     * 
     * @param value
     *            comma를 붙여야 되는 숫자
     * @return 세자리 마다 ,가 붙어 있는 String
     */
    public static String formatNumber(int value) {
        return formatNumber(String.valueOf(value));
    }
    
    /**
     * 넘어온 값에 세자리마다 ','를 넣어주는 함수. 숫자인지는 체크하지 않음.
     * 
     * @param value
     *            comma를 붙여야 되는 String
     * @return 세자리 마다 ,가 붙어 있는 String
     */
    public static String formatNumber(String str) {
        if (str == null || str.equals("")) { return "0"; }
        
        if (str.length() <= 3) {
            return str;
        } else {
            String remainder = str.substring(str.length() - 3, str.length());
            
            return formatNumber(str.substring(0, str.length() - 3)) + ","
                    + remainder;
        }
    }
    
    /**
     * 999,999,999 또는 999,999,999.99 format으로 되어있는 자료를 ','가 없는 형식으로 변환
     * 
     * @param value
     *            String type의 데이터
     * @return String 숫자 format으로 변환된 데이터
     */
    public static String unformatNumber(String value) {
        if (value == null) { return "err-numberFormat(null)"; }
        
        StringBuffer res = new StringBuffer();
        
        StringTokenizer st = new StringTokenizer(value, ",");
        
        try {
            while (st.hasMoreTokens()) {
                res.append(st.nextToken());
            }
        } catch (NoSuchElementException nse) {
        }
        
        return res.toString();
    }
    
    /**
     * 지역번호나 핸드폰의 통신업자번호를 파싱(0삭제)하여 리턴한다.
     * 
     * @param value
     *            파싱할 번호 String
     * @param gubun
     *            지역번호인지 통신업자번호인지를 구분하는 구분자( R or H )
     * @return 파싱된 결과 값
     */
    public static String formatTel1(String value, String gubun) {
        if (value == null || value.equals("") || value.length() != 4) {
            return "";
        } else if (gubun.equalsIgnoreCase("R") && value.equals("0002")) {
            return "02";
        } else {
            return value.substring(1);
        }
    }
    
    /**
     * 전화번호를 파싱(0삭제)하여 리턴한다.
     * 
     * @param value
     *            파싱할 번호 String
     * @return 파싱된 결과 값
     */
    public static String formatTel2(String value) {
        return formatTel2(value, null);
    }
    
    /**
     * 전화번호를 파싱(0삭제)하여 리턴한다.
     * 
     * @param value
     *            파싱할 번호 String
     * @param delimeter
     *            국번과 번호를 구분하는 문자( eg. '-'...)
     * @return value 파싱된 결과 값
     */
    public static String formatTel2(String valueStr, String delimeter) {
        
        String value = valueStr;
        if (value == null || value.equals("") || value.length() != 8) {
            return "";
        } else if (value.startsWith("0")) {
            if (delimeter != null) {
                value = value.substring(1, 4) + delimeter + value.substring(4);
            } else {
                value = value.substring(1);
            }
            
            return value;
        } else {
            if (delimeter != null) {
                value = value.substring(0, 4) + delimeter + value.substring(4);
            }
            
            return value;
        }
    }
    
    /**
     * 넘어온 값에 네자리마다 '-'를 넣어주는 함수.
     * 
     * @param value
     *            파싱할 번호 String
     * @return 파싱된 결과 값
     */
    public static String formatCard(String value) {
        if (value == null || value.equals("") || value.length() != 16) {
            return value;
        } else {
            return value.substring(0, 4) + "-" + value.substring(4, 8) + "-"
                    + value.substring(8, 12) + "-" + value.substring(12, 16);
        }
    }
    
    /**
     * 문자열의 앞에 있는 0을 삭제하여 리턴한다.
     * 
     * @param value
     *            파싱할 번호 String
     * @return value 파싱된 결과 값
     */
    public static String firstZeroDel(String valueStr) {
        String value = valueStr;
        if (value == null || value.equals("")) { return ""; }
        while (value.startsWith("0")) {
            value = value.substring(1);
        }
        
        return value;
    }
    
    /**
     * 8859-1을 euc-kr로 바꾼다.
     * 
     * @param str
     *            인코딩할 문자열 String
     * @return 인코딩된 결과 값
     */
    public static String toKorean(String value) {
        String str = value;
        try {
            if (str != null) {
                str = new String(str.getBytes("8859_1"), "utf-8");
            }
        } catch (UnsupportedEncodingException e) {
            return "ENCORDING ERROR";
        }
        
        return str;
    }
    
    /**
     * euc-kr을 8859-1로 바꾼다.
     * 
     * @param str
     *            인코딩할 문자열 String
     * @return 인코딩된 결과 값
     */
    public static String toEnglish(String value) {
        String str = value;
        try {
            if (str != null) {
                str = new String(str.getBytes("utf-8"), "8859_1");
            }
        } catch (UnsupportedEncodingException e) {
            return "ENCORDING ERROR";
        }
        
        return str;
    }
    
    /**
     * lpad 함수
     * 
     * @param str
     *            대상문자열, len 길이, addStr 대체문자
     * @return 문자열
     */
    
    public static String lpad(String str, int len, String addStr) {
        String result = str;
        int templen = len - result.length();
        
        for (int i = 0; i < templen; i++) {
            result = addStr + result;
        }
        
        return result;
    }
    
    /**
     * 문자열을 치환함
     * 
     * @param str
     * @param sourceStr
     * @param targetStr
     * @return
     */
    public static String replace(String value, String sourceStr,
            String targetStr) {
        
        String str = value;
        if (str == null || sourceStr == null || targetStr == null
                || str.length() == 0 || sourceStr.length() == 0) { return str; }
        
        int position = 0;
        int sourceStrLength = sourceStr.length();
        int targetStrLength = targetStr.length();
        
        while (true) {
            position = str.indexOf(sourceStr, position);
            if (position != -1) {
                if ((position + sourceStrLength) < str.length()) {
                    str = str.substring(0, position) + targetStr
                            + str.substring(position + sourceStrLength);
                } else {
                    str = str.substring(0, position) + targetStr;
                }
                
                position = position + targetStrLength;
                
                if (position > str.length()) {
                    position = str.length();
                }
            } else {
                break;
            }
        }
        
        return str;
    }
    
    /**
     * 문자열의 Null을 Empty로 치환함
     * 
     * @param str
     * @return
     */
    public static String replaceNull(String str) {
        if (str != null) {
            return str;
        } else {
            return "";
        }
    }
    
    /**
     * 문자열의 \n을 <br>
     * 로 치환함
     * 
     * @param str
     * @return
     */
    public static String replaceHtmlString(String value) {
        String str = value;
        if (str != null && str.length() > 0) {
            str = replace(str, "\n", "<br>");
        }
        
        return str;
    }
    
    /**
     * 문자열 치환
     * 
     * @param value
     * @return
     */
    public static String replaceContentString(String value) {
        String str = value;
        if (str != null && str.length() > 0) {
            str = replace(str, "&qquot;", "'");
            str = replace(str, "&amp;", "&");
            str = replace(str, "<!--<p>-->", "");
        }
        
        return str;
    }
    
    /**
     * 문자열 치환
     * 
     * @param value
     * @return
     */
    public static String replaceScriptString(String value) {
        String str = value;
        if (str != null && str.length() > 0) {
            str = replace(str, "\\", "\\\\");
            str = replace(str, "'", "\\'");
            str = replace(str, "\"", "\\\"");
        }
        
        return str;
    }
    
    /**
     * 문자열 치환
     * 
     * @param value
     * @return
     */
    public static String replaceQuot(String value) {
        String str = value;
        if (str != null && str.length() > 0) {
            str = replace(str, "<br>", " ");
            str = replace(str, "<br/>", " ");
            // str = replace(str, "<", "");
            // str = replace(str, ">", "");
            str = replace(str, "=", "");
            str = replace(str, "%", "");
            str = replace(str, "+", "");
            str = replace(str, "'", "");
            str = replace(str, "/", "");
            str = replace(str, "\"", "");
            str = replace(str, "\r", " ");
            str = replace(str, "\n", " ");
            str = replace(str, "\r\n", " ");
        }
        
        return str;
    }
    
    /**
     * 문자열 치환
     * 
     * @param value
     * @return
     */
    public static String replaceSQLString(String value) {
        String str = value;
        if (str != null && str.length() > 0) {
            str = replace(str, "'", "''");
        }
        
        return str;
    }
    
    /**
     * 문자열 치환
     * 
     * @param value
     * @return
     */
    public static String replaceContentString2(String value) {
        String str = value;
        if (str != null && str.length() > 0) {
            str = replace(str, "&amp;", "&");
            str = replace(str, "\"", "&quot;");
            str = replace(str, "&", "&amp;");
            str = replace(str, "<", "&lt;");
            str = replace(str, ">", "&gt;");
        }
        
        return str;
    }
    
    /**
     * 구분자를 가진 String을 받아서 List형태로 리턴함
     * 
     * @param str
     * @param delim
     * @return
     */
    public static List<String> getTokens(String str, String delim) {
        if (str == null || delim == null || str.equals("") || delim.equals("")) { return null; }
        
        List<String> list = new ArrayList<String>();
        
        StringTokenizer st = new StringTokenizer(str, delim);
        
        while (st.hasMoreTokens()) {
            list.add(st.nextToken());
        }
        
        return list;
    }
    
    /**
     * string[] 을 받아서 List 형태로 리턴함.
     * 
     * @param str
     * @return
     */
    public static List<String> getList(String[] str) {
        List<String> list = new ArrayList<String>();
        
        for (int i = 0; i < str.length; i++) {
            list.add(str[i]);
        }
        
        return list;
    }
    
    /**
     * 파일 확장자를 리턴함
     * 
     * @param filename
     * @return
     */
    public static String getFileExtension(String filename) {
        String extension = null;
        
        if (filename != null && filename.lastIndexOf('.') > 0
                && filename.length() >= 3) {
            extension = filename.substring(filename.lastIndexOf('.') + 1,
                                           filename.length());
        }
        
        return extension;
    }
    
    /**
     * <pre>
     * String[] items = { &quot;yellow&quot;, &quot;green&quot;, &quot;red&quot; };
     * String[] numberItem = { &quot;1&quot;, &quot;2&quot;, &quot;3&quot; };
     * 
     * assertEquals(&quot;'yellow','green','red'&quot;,
     *              StringUtil.makeSqlInStatement(items, true));
     * assertEquals(&quot;1,2,3&quot;, StringUtil.makeSqlInStatement(numberItem, false));
     * </pre>
     * 
     * @param items
     *            in 조건에 들어갈 아이템들
     * @param quote
     *            인용부호를 붙이는지 여부 true 면 붙인다
     * @return 만들어진 in 조건문
     */
    public static String makeSqlInStatement(String[] items, boolean quote) {
        if (items == null || items.length == 0) { return ""; }
        
        StringBuffer retStr = new StringBuffer("");
        for (int i = 0; i < items.length; i++) {
            retStr.append((!quote ? items[i] : "'" + items[i] + "'") + ",");
        }
        
        return retStr.toString().substring(0, retStr.length() - 1);
    }
    
    /**
     * 랜덤 문자열 만들기
     * 
     * @param len
     * @return
     */
    public static String randomStr(int len) {
        char[] initRandomChar = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i',
                'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u',
                'v', 'w', 'x', 'y', 'x', 'A', 'B', 'C', 'D', 'E', 'F', 'G',
                'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
                'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4',
                '5', '6', '7', '8', '9' };
        
        StringBuffer sb = new StringBuffer();
        
        int i = 0;
        while (i < len) {
            sb.append(initRandomChar[(int) (Math.random() * initRandomChar.length)]);
            i++;
        }
        
        return sb.toString();
    }
    
    /**
     * HTML에서 태그를 제외한 문자만 추출하는 유틸메서드
     * 
     * @param html
     *            the html
     * @return the string
     */
    public static String extractTextFormHTML(String html) {
        if (StringUtils.isEmpty(html)) { return ""; }
        
        String extractText = html.replaceAll("(?:<!--.*?(?:--.*?--\\s*)*.*?-->)|(?:<(?:[^>'\"]*|\".*?\"|'.*?')+>)", "");
        
        return extractText;
        
    }
    
    /**
     * @param str
     * @param token
     */
    
    public static String[] strToStrarr(String str) {
        return strToStrarr(str, ";");
    }
    
    public static String[] strToStrarr(String str, String token) {
        String[] retValue;
        
        StringTokenizer st = new StringTokenizer(str, token);
        retValue = new String[st.countTokens()];
        
        int i = 0;
        while (st.hasMoreTokens()) {
            String temp = st.nextToken();
            retValue[i] = temp;
            i++;
        }
        
        return retValue;
    }
    
    public static String intToIp(long i) {
        return ((i >> 24) & 0xFF) + "." + ((i >> 16) & 0xFF) + "."
                + ((i >> 8) & 0xFF) + "." + (i & 0xFF);
    }
    
    public static Long ipToInt(String addr) {
        String[] addrArray = addr.split("\\.");
        long num = 0;
        for (int i = 0; i < addrArray.length; i++) {
            int power = 3 - i;
            num += ((Integer.parseInt(addrArray[i]) % 256 * Math
                    .pow(256, power)));
        }
        return num;
    }
    
    /**
     * XSS FILTER
     * 
     * @param param
     * @return
     */
    public static String xssFilter(String param) {
        if(param == null) {
            return null;
        }
        
        param = param.replaceAll("(?i)script","").replaceAll("(?i)iframe", "").replaceAll("(?i)javacript", "j*vascript");
        param = param.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
        //param = param.replaceAll("\"", "%22").replaceAll("\'","%27").replaceAll("<", "%3C").replaceAll(">", "%3E");
        //param = param.replaceAll("\\(", "& #40;").replaceAll("\\)", "& #41;");
        //param = param.replaceAll("'", "& #39;");
        param = param.replaceAll("eval\\((.*)\\)", "");
        //param = param.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
        //param = param.replaceAll("script", "");
        //param = param.replaceAll("[\r\n]", ""); //CRLF Injection
        
        return param;
    }
    
    /**
     * 소문자를 대문자로 변경한다. 영문 검색 시 활용.
     * 
     * @param upperCase
     * @return
     */
    public static String changeUpper(String upperCase) {
        String str = upperCase;
        char temp[] = str.toCharArray(); //32 차이
          
        for(int i = 0; i < temp.length; i++) {
            //알파벳 문자인지 검사
            int num = (int)temp[i];
            int num2 = 0;
            if(num >= 65 && num <= 122) {
                // 소문자일 경우
                if(num >= 97 && num <= 122) {
                    num2 = num-32;
                    temp[i] = (char)num2;                     
                } 
            }
        }
        
        return String.valueOf(temp);
    }

    /**
     * 문자열 형태의 IP주소를 숫자형(4byte) IP주소로 변환해 줌
     * @param addr 문자열 형태의 IP주소
     * @return 숫자형 IP주소
     */
    public static long ipStringToNumber(String addr) {
        String[] addrArray = addr.split("\\.");
        
        long num = 0;
        for (int i=0;i<addrArray.length;i++)  {
            int power = 3-i;
            
            num += ((Integer.parseInt(addrArray[i])%256 * Math.pow(256,power)));
        }
        return num;
    }
    
    /** 
     *  분할 집합 http://www.programkr.com/blog/MYTMyEDMwYTx.html 
     *  @param <T> 
     *  @param resList 꼭 분할 집합 
     *  @param count 모든 집합 요소 개수 
     *  @return 복귀 분할 후 각 집합 
     **/
    public static <T> List<List<T>> split(List<T> resList, int count) {
        if(resList == null || count <1) {
            return null;
        }
        
        List<List<T>> ret = new ArrayList<List<T>>();
        
        int size = resList.size();
        
        if(size <= count) {
            // 데이터 부족 count 지정 크기
            ret.add(resList);
        } else {
            int pre = size / count;
            int last = size % count;
            // 앞 pre 개 집합, 모든 크기 다 count 가지 요소
            for(int i = 0; i <pre; i++) {
                List<T> itemList = new ArrayList<T>();
                for(int j = 0; j <count; j++) {
                    itemList.add(resList.get(i * count + j));
                }
                ret.add(itemList);
            }
            // last 진행이 처리
            if(last > 0) {
                List<T> itemList = new ArrayList<T>();
                for (int i = 0; i <last; i++) {
                    itemList.add(resList.get(pre * count + i));
                }
                ret.add(itemList);
            }
        }
        return ret;
    }
    
    public static String parseMessage(String msg, String... args) {
		if(msg==null || msg.trim().length()<=0) {
			return "";
		}
		if(args==null || args.length<=0) {
			return msg;
		}
		
		String[] parseMsg = msg.split("%");
		if(parseMsg==null || parseMsg.length==1) {
			return msg;
		}
		
		for(int i=0;i<args.length;i++) {
			String replaceChar = "%"+(i+1);
			msg = msg.replaceFirst(replaceChar, args[i]);
		}
		return msg;
	}
    
    public static String removeSpecialCharacter(String str){
		if(str != null && !"".equals(str)) {
			str = str.replaceAll("/", "");
			str = str.replaceAll("\\\\", "");
			str = str.replaceAll("\\.", "");
			str = str.replaceAll("&", "");
		}
		return str;
	}
    
    /**
	 * String 형으로 printStackTrace message 를 돌려 주는 method
	 * 
	 * @param e
	 * @return
	 */
	public static String getPrintStacTraceString(Exception e) {
		String returnValue = "";

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		PrintStream printStream = new PrintStream(out);
		e.printStackTrace(printStream);
		returnValue = out.toString();
		return returnValue;
	}
	
	 /**
	 * camel표기법을 snake case로 돌려 주는 method
	 * 
	 * @param str
	 * @return
	 */
	public static String camelToSnakeConvert(String str) {
		String returnValue = "";
		String regex = "([a-z])([A-Z]+)";
       String replacement = "$1_$2";
       returnValue = str.replaceAll(regex, replacement).toLowerCase();
       
		return returnValue;
	}
	/**
	 * IP 유효성 체크. (IPv4 주소 정규식 체크) 추가 
	 * 
	 * @param ip
	 * @return
	 */
	public static boolean isValidInet4Address(String ip) {

		String IPV4_REGEX = "^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\."
							+ "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\."
							+ "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\."
							+ "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$";
		Pattern IPv4_PATTERN = Pattern.compile(IPV4_REGEX);

		if (ip == null) {
			return false;
		}

		Matcher matcher = IPv4_PATTERN.matcher(ip);

		return matcher.matches();
	}
	
	/**
	 * 
	 * 서버 또는 내 컴퓨터 IP 가져오기
	 * 
	 */
	/*
	public static String getServerIP() {
		String ip ="";
		InetAddress local = null;
		try {
			local = InetAddress.getLocalHost();
			if(local == null) {
				ip =  "";
			}else {
				ip = local.getHostAddress();				
			}		
		}
		catch ( UnknownHostException e ) {
			e.printStackTrace();
		}
		return ip;
	}*/
	
	public static String getServerIP(HttpServletRequest request) {
		String ip ="";
		
		ip = request.getHeader("X-Forwarded-For");
		//System.out.println("X-FORWARDED-FOR : " + ip);
	   
		if (ip == null) {
	        ip = request.getHeader("Proxy-Client-IP");
	        //System.out.println("Proxy-Client-IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("WL-Proxy-Client-IP");
	        //System.out.println("WL-Proxy-Client-IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_CLIENT_IP");
	        //System.out.println("HTTP_CLIENT_IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_X_FORWARDED_FOR");
	        //System.out.println("HTTP_X_FORWARDED_FOR : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getRemoteAddr();
	        //System.out.println("getRemoteAddr : "+ip);
	    }
		return ip;
	}
	
	/**
	 * 이력 메세지 가져오기
	 */
	public static String getPrssTypeMsg(String prssType) {
		String msg = "";
		
		switch(prssType) {
			case "HS01": msg = "성공"; break;
			case "HS02": msg = "실패"; break;
			case "HS03": msg = "로그인 성공"; break;
			case "HS04": msg = "로그인 실패"; break;
			case "HS05": msg = "잠김"; break;
			case "HS06": msg = "생성"; break;
			case "HS07": msg = "삭제"; break;
			case "HS08": msg = "수정"; break;
			default: msg = ""; break;
		}
		
		return msg;
	}	
}
