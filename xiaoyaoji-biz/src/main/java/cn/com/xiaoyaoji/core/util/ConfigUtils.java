package cn.com.xiaoyaoji.core.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import java.io.IOException;
import java.util.Properties;

/**
 * @author: zhoujingjie
 * @Date: 16/5/2
 */
public class ConfigUtils {
    private static Logger logger = LoggerFactory.getLogger(ConfigUtils.class);
    private static Properties properties;
    private static String basePrefixPath = null;
    // 设置经过请求转发后，图片资源真正的访问路径
    private static String realFileAccessURL = null;

    static {
        properties = new Properties();
        ClassLoader classLoader =Thread.currentThread().getContextClassLoader();
        try {
            properties.load(classLoader.getResourceAsStream("config.properties"));
        } catch (IOException e) {
            logger.error(e.getMessage(),e);
        }
        try {
            properties.load(classLoader.getResourceAsStream("config.dev.properties"));
        } catch (Exception e) {
            logger.info("not found config.dev.properties");
        }
    }

    public static String getRealFileAccessURL() {
        return realFileAccessURL;
    }

    public static void setRealFileAccessURL(String realFileAccessURL) {
        ConfigUtils.realFileAccessURL = realFileAccessURL;
    }

    public static String getBasePrefixPath() {
        return basePrefixPath;
    }

    public static void setBasePrefixPath(String basePrefixPath) {
        ConfigUtils.basePrefixPath = basePrefixPath;
    }

    public static String getProperty(String key){
        return properties.getProperty(key);
    }

    public static String getProperty(String key,String defaultValue){
        String value = getProperty(key);
        if(value == null || value.length()==0)
            return defaultValue;
        return value;
    }

    public static String getFileAccessURL(){
        String fileAccessURL = System.getenv().get("file.access.url");
        return StringUtils.hasText(fileAccessURL)? fileAccessURL:properties.getProperty("file.access.url");
    }

    public static String getFileUploadDir(){
        String fileUploadDir = System.getenv().get("file.upload.dir");
        return StringUtils.hasText(fileUploadDir)? fileUploadDir:properties.getProperty("file.upload.dir");
    }

    public static String getBucketURL(){
        return properties.getProperty("file.qiniu.bucket");
    }

    public static String getUploadServer(){
        return properties.getProperty("file.upload.server","owner");
    }

    public static String getJdbcURL(){
        String jdbcUrl = System.getenv().get("jdbc.url");
        return StringUtils.hasText(jdbcUrl)? jdbcUrl:properties.getProperty("jdbc.url");
    }

    public static String getJdbcUsername(){
        String username = System.getenv().get("jdbc.username");
        return StringUtils.hasText(username)? username:properties.getProperty("jdbc.username");
    }

    public static String getJdbcPassword(){
        String username = System.getenv().get("jdbc.password");
        return StringUtils.hasText(username)? username:properties.getProperty("jdbc.password");
    }

    public static String getJdbcDriverclass(){
        return properties.getProperty("jdbc.driverclass");
    }

    public static String getJdbcInitSize(){
        return properties.getProperty("jdbc.initsize");
    }
    public static String getJdbcMaxWait(){
        return properties.getProperty("jdbc.maxwait");
    }
    public static String getJdbcMinIdle(){
        return properties.getProperty("jdbc.minidle");
    }

    public static String getQiniuAccessKey(){
        return properties.getProperty("file.qiniu.accessKey");
    }

    public static String getQiniuSecretKey(){
        return properties.getProperty("file.qiniu.secretKey");
    }

    public static String getSalt(){
        return properties.getProperty("salt");
    }

    public static int getTokenExpires() {
        return Integer.parseInt(properties.getProperty("token.expires"));
    }
}
