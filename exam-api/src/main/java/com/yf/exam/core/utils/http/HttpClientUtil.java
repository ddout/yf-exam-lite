package com.yf.exam.core.utils.http;


import com.yf.exam.core.utils.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.BasicHttpEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.ByteArrayInputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


/**
 * HTTP请求工具类
 * @author bool 
 * @date 2016-07-20 15:31
 */
public class HttpClientUtil {

	/**
	 * 常规URL的连接符号
	 */
	private static final String PARAM_STARTER = "?";
	private static final String PARAM_CONCAT = "&";
	private static final String ENCODING = "UTF-8";


	/**
	 * 使用POST方式提交数据并获得JSON
	 * @param url
	 * @param params
	 * @return
	 */
	public static String postRestJson(String url, Map<String,String> params) {

		CloseableHttpClient client = HttpClients.createDefault();
		try {

			HttpPost httpPost = new HttpPost(url);

			// 构造参数
			List<NameValuePair> list = new ArrayList<>();
			for (String key : params.keySet()) {
				BasicNameValuePair vp = new BasicNameValuePair(key, params.get(key));
				list.add(vp);
			}

			// 转换并传入参数
			UrlEncodedFormEntity formEntity = new UrlEncodedFormEntity(list);
			httpPost.setEntity(formEntity);

			CloseableHttpResponse response = client.execute(httpPost);
			HttpEntity entity = response.getEntity();
			String str = EntityUtils.toString(entity, "UTF-8");
			// 关闭
			response.close();
			return str;

		}catch (Exception e){
			e.printStackTrace();
		}

		return null;
	}


	/**
	 * GET方法返回JSON数据
	 * 
	 * @param url
	 * @return
	 */
	public static String getJson(String url, Map<String, String> headers, Map<String, String> params) {
		CloseableHttpClient client = HttpClients.createDefault();
		try {
			
			String fullUrl = buildParamsUrl(url, params);
			HttpGet httpGet = new HttpGet(fullUrl);

			// 循环加入文件头
			if (headers != null && !headers.isEmpty()) {
				for (String key : headers.keySet()) {
					httpGet.addHeader(key, headers.get(key));
				}
			}

			CloseableHttpResponse response = client.execute(httpGet);
			HttpEntity entity = response.getEntity();
			String body = EntityUtils.toString(entity, ENCODING);
			return body;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	
	/**
	 * 构造一个带参数的GET形式URL
	 * @param url
	 * @param params
	 * @return
	 */
	public static String buildParamsUrl(String url, Map<String, String> params) {

		// 拼接参数
		if (params != null && !params.isEmpty()) {
			
			StringBuffer sb = new StringBuffer(url);

			//判断URL是否已经有问题号了
			if (url.indexOf(PARAM_STARTER) == -1) {
				sb.append(PARAM_STARTER);
			}
			
			for (String key : params.keySet()) {

				if(!sb.toString().endsWith(PARAM_STARTER)) {
					sb.append(PARAM_CONCAT);
				}
				
				String value = params.get(key);
				if (StringUtils.isBlank(value)) {
					value = "";
				} else {
					// 值做一下URL转码
					try {
						value = URLEncoder.encode(value, ENCODING);
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
						continue;
					}
				}
				sb.append(key).append("=").append(value);
			}
			
			return sb.toString();
		}
		
		return url;
	}



	/**
	 * 参数通过xml格式post到某个URL上
	 *
	 * @param params
	 * @param url
	 * @return
	 * @throws Exception
	 */
	public static String postAsXML(Map<String, String> params, String url) throws Exception {

		// 将Map转换成字符串
		String xmlString = StringUtils.mapToXml(params);

		CloseableHttpClient client = HttpClients.createDefault();
		HttpPost post = new HttpPost(url);

		BasicHttpEntity requestBody = new BasicHttpEntity();
		requestBody.setContent(new ByteArrayInputStream(xmlString.getBytes("UTF-8")));
		requestBody.setContentType("text/xml");
		post.setEntity(requestBody);

		CloseableHttpResponse response = client.execute(post);
		HttpEntity entity = response.getEntity();
		String body = EntityUtils.toString(entity, "UTF-8");

		return body;
	}

}