package cn.com.xiaoyaoji.test;

import cn.com.xiaoyaoji.data.DataFactory;
import cn.com.xiaoyaoji.service.ServiceFactory;
import org.junit.Test;

/**
 * ...
 *
 * @author : liangfen.zhou@huolala.cn
 * Date : 2019-04-17 17:33
 */
public class DeleteDoc {

    @Test
    public void test(){
        DataFactory.instance().deleteDocHistory();
    }
}
