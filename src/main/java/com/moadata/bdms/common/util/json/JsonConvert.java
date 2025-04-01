package com.moadata.bdms.common.util.json;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.nio.charset.Charset;


/**
 *
 * @author smoke
 */
public class JsonConvert {
	public static JsonNode toJsonNode(Object obj){
		JsonNode res = null;
		try{
			ObjectMapper om = new ObjectMapper();
			byte[] bytes = om.writeValueAsBytes(obj);
			String str = new String(bytes, Charset.forName("utf-8"));
			res = om.readTree(str);
		}catch(JsonProcessingException e){
			e.printStackTrace();
		}finally{
			return res;
		}
	}
	
	public static String toJsonSting(Object obj){
		String res = null;
		try{
			ObjectMapper om = new ObjectMapper();
//			byte[] bytes = om.writeValueAsBytes(obj);
//			String str = new String(bytes, Charset.forName("utf-8"));
			
			res = om.writeValueAsString(obj);
		}catch(JsonProcessingException e){
			e.printStackTrace();
		}finally{
			return res;
		}
	}
}
