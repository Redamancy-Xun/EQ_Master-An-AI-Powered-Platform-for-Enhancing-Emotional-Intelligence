package fun.redamancyxun.eqmaster.backend.util;


import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import java.util.Locale;

/**
 * 项目名称: 
 * 类名: SpringContextUtil
 * 描述： 获取bean的工具类，可用于在线程里面获取bean
 * 创建人: -.-- .- -. --.    --.. ..   .- -.
 * 修改备注：
 * 版本：1.0
 */

public class SpringContextUtil implements ApplicationContextAware {
 
    private static ApplicationContext context = null;
 
    /* (non Javadoc)
     * @Title: setApplicationContext
     * @Description: spring获取bean工具类
     * @param applicationContext
     * @throws BeansException
     * @see org.springframework.context.ApplicationContextAware#setApplicationContext(org.springframework.context.ApplicationContext)
     */
    @Override
    public void setApplicationContext(ApplicationContext applicationContext)
            throws BeansException {
        context = applicationContext;
    }
 
    public static <T> T getBean(String beanName){
        return (T) context.getBean(beanName);
    }
 
    public static String getMessage(String key){
        return context.getMessage(key, null, Locale.getDefault());
    }

}