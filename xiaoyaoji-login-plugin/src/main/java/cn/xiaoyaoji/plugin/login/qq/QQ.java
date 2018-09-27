package cn.xiaoyaoji.plugin.login.qq;

import cn.xiaoyaoji.service.AppCts;
import com.alibaba.fastjson.JSON;
import jodd.http.HttpRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author zhoujingjie
 * @date 2016-07-28
 */
public class QQ {
    private Logger logger = LoggerFactory.getLogger("thirdly");
    private String appId, appKey;

    private Pattern openIdPattern = Pattern.compile("openid\":\"([\\w|\\d]+)\"");
    private Pattern accessTokenPattern = Pattern.compile("access_token=([\\w|\\d]+)&expires_in=([\\d]+)&refresh_token=([\\w|\\d]+)");

    public QQ(String appId, String appKey) {
        this.appId = appId;
        this.appKey = appKey;
    }

    public UserInfo getUserInfo(String openid, String accessToken) {
        String url = "https://graph.qq.com/user/get_user_info?openid=" + openid + "&oauth_consumer_key=" + appId + "&access_token=" + accessToken + "&format=json";
        String rs = new String(HttpRequest.get(url).send().bodyBytes(), AppCts.UTF8);
        UserInfo userInfo = JSON.parseObject(rs, UserInfo.class);
        if (!userInfo.getRet().equals("0")) {
            throw new QQException(rs);
        }
        return userInfo;
    }

    public AccessToken getAccessToken(String code, String redirectURI) {
        String rs = new String(HttpRequest.get("https://graph.qq.com/oauth2.0/token?grant_type=authorization_code&client_id="
                + appId
                + "&client_secret=" + appKey
                + "&code=" + code
                + "&redirect_uri=" + redirectURI
        ).send().bodyBytes(), AppCts.UTF8);
        logger.debug(rs);
        if (rs.contains("access_token")) {
            Matcher matcher = accessTokenPattern.matcher(rs);
            if (matcher.find()) {
                return new AccessToken(matcher.group(1), matcher.group(3), Long.parseLong(matcher.group(2)));
            }
            throw new QQException(rs);
        }
        throw new QQException(rs);
    }

    public String getOpenid(String accessToken) {
        String rs = new String(HttpRequest.get("https://graph.qq.com/oauth2.0/me?access_token=" + accessToken).send().bodyBytes(), AppCts.UTF8);
        if (rs.contains("openid")) {
            Matcher matcher = openIdPattern.matcher(rs);
            if (matcher.find()) {
                return matcher.group(1);
            }
            throw new QQException(rs);
        }
        throw new QQException(rs);
    }
}
