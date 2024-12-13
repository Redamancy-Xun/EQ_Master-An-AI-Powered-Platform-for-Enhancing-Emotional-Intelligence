package fun.redamancyxun.eqmaster.backend.util;

import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;

class ConnectionUtil {

    public static Connection getConnection() throws Exception {
        //定义连接工厂
        ConnectionFactory factory = new ConnectionFactory();
        //设置服务地址
        factory.setHost("localhost");
        //端口
        factory.setPort(5672);
        //设置账号信息，用户名、密码、vhost
        factory.setVirtualHost("paperSystem");
        factory.setUsername("admin");
        factory.setPassword("Lishuai0923");
        // 通过工程获取连接
        return factory.newConnection();
    }
}
