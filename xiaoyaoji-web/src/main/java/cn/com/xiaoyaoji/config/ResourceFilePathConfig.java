package cn.com.xiaoyaoji.config;

import cn.com.xiaoyaoji.core.util.ConfigUtils;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@EnableWebMvc
@Configuration
public class ResourceFilePathConfig extends WebMvcConfigurerAdapter {

    /**
     * 将 /fileUploadDir/** 的所有URL映射到本地的路径的文件
     * @param registry
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String fileUploadDir = ConfigUtils.getFileUploadDir();
        String fileAccessURL = ConfigUtils.getFileAccessURL();
        registry.addResourceHandler(fileAccessURL+"**").addResourceLocations("file:"+fileUploadDir);
    }

}