package com.yf.exam;

import com.yf.exam.core.api.utils.JsonConverter;
import lombok.extern.log4j.Log4j2;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.env.Environment;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;

/**
 * 云帆在线考试系统
 * @author bool 
 * @date 2020-03-04 19:41
 */
@Log4j2
@SpringBootApplication
public class ExamApplication implements WebMvcConfigurer {

	public static void main(String[] args) throws UnknownHostException {

		ConfigurableApplicationContext application = SpringApplication.run(ExamApplication.class, args);
		Environment env = application.getEnvironment();
		String ip = InetAddress.getLocalHost().getHostAddress();
		String port = env.getProperty("server.port");
		log.info("\n----------------------------------------------------------\n\t" +
				"欢迎使用云帆考试系统！访问地址:\n\t" +
				"本地链接: \t\thttp://localhost:" + port + "/\n\t" +
				"网络链接: \thttp://" + ip + ":" + port + "/\n\t" +
				"----------------------------------------------------------");
	}

	@Override
	public void extendMessageConverters(List<HttpMessageConverter<?>> converters) {
		//保留原有converter,把新增fastConverter插入集合头,保证优先级
		converters.add(0, JsonConverter.fastConverter());
	}

}