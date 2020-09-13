package cn.com.xiaoyaoji.util;

import cn.com.xiaoyaoji.core.util.ConfigUtils;
import org.springframework.util.StringUtils;

/**
 * @author zhoujingjie
 *         created on 2017/8/14
 */
public class AvatarUtils {

    public static String getAvatar(String avatar){
        if(StringUtils.isEmpty(avatar) || avatar.startsWith("http")) {
            return avatar;
        }
        if (avatar.startsWith(ConfigUtils.getRealFileAccessURL())) return avatar;
        return ConfigUtils.getRealFileAccessURL()+avatar;
    }

}
