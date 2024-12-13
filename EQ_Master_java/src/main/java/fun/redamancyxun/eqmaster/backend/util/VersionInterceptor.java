package fun.redamancyxun.eqmaster.backend.util;

import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.LongValue;
import net.sf.jsqlparser.expression.operators.arithmetic.Addition;
import net.sf.jsqlparser.expression.operators.conditional.AndExpression;
import net.sf.jsqlparser.expression.operators.relational.EqualsTo;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.schema.Column;
import net.sf.jsqlparser.statement.Statement;
import net.sf.jsqlparser.statement.update.Update;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.SystemMetaObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Proxy;
import java.sql.Connection;
import java.util.List;
import java.util.Properties;

/**
 * 乐观锁：数据版本插件
 *
 */
@Intercepts(
        @Signature(
                type = StatementHandler.class,
                method = "prepare",
                args = {Connection.class, Integer.class}
        )
)
public class VersionInterceptor implements Interceptor {

    private static final String VERSION_COLUMN_NAME = "version";

    private static final Logger logger = LoggerFactory.getLogger(VersionInterceptor.class);


    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        // 获取 StatementHandler，实际是 RoutingStatementHandler
        StatementHandler handler = (StatementHandler) processTarget(invocation.getTarget());
        // 包装原始对象，便于获取和设置属性
        MetaObject metaObject = SystemMetaObject.forObject(handler);
        // MappedStatement 是对SQL更高层次的一个封装，这个对象包含了执行SQL所需的各种配置信息
        MappedStatement ms = (MappedStatement) metaObject.getValue("delegate.mappedStatement");
        // SQL类型
        SqlCommandType sqlType = ms.getSqlCommandType();
        if(sqlType != SqlCommandType.UPDATE) {
            return invocation.proceed();
        }
        // 获取版本号
        Object originalVersion = metaObject.getValue("delegate.boundSql.parameterObject." + VERSION_COLUMN_NAME);
        if(originalVersion == null || Long.parseLong(originalVersion.toString()) <= 0){
            return invocation.proceed();
        }
        // 获取绑定的SQL
        BoundSql boundSql = (BoundSql) metaObject.getValue("delegate.boundSql");
        // 原始SQL
        String originalSql = boundSql.getSql();
        // 加入version的SQL
        originalSql = addVersionToSql(originalSql, originalVersion);
        // 修改 BoundSql
        metaObject.setValue("delegate.boundSql.sql", originalSql);

        // proceed() 可以执行被拦截对象真正的方法，该方法实际上执行了method.invoke(target, args)方法
        return invocation.proceed();
    }

    /**
     * Plugin.wrap 方法会自动判断拦截器的签名和被拦截对象的接口是否匹配，只有匹配的情况下才会使用动态代理拦截目标对象.
     *
     * @param target 被拦截的对象
     * @return 代理对象
     */
    @Override
    public Object plugin(Object target) {
        return Plugin.wrap(target, this);
    }


    /**
     * 设置参数
     */
    @Override
    public void setProperties(Properties properties) {

    }

    /**
     * 获取代理的原始对象
     *
     * @param target
     * @return
     */
    private static Object processTarget(Object target) {
        if(Proxy.isProxyClass(target.getClass())) {
            MetaObject mo = SystemMetaObject.forObject(target);
            return processTarget(mo.getValue("h.target"));
        }
        return target;
    }

    /**
     * 为原SQL添加version
     *
     * @param originalSql 原SQL
     * @param originalVersion 原版本号
     * @return 加入version的SQL
     */
    private String addVersionToSql(String originalSql, Object originalVersion){
        try{
            Statement stmt = CCJSqlParserUtil.parse(originalSql);
            if(!(stmt instanceof Update)){
                return originalSql;
            }
            Update update = (Update)stmt;
            if(contains(update)){
                buildVersionExpression(update);
            }
            Expression where = update.getWhere();
            if(where != null){
                AndExpression and = new AndExpression(where, buildVersionEquals(originalVersion));
                update.setWhere(and);
            }else{
                update.setWhere(buildVersionEquals(originalVersion));
            }
            return stmt.toString();
        }catch(Exception e){
            logger.error(e.getMessage(), e);
            return originalSql;
        }
    }

    private boolean contains(Update update){
        List<Column> columns = update.getColumns();
        for(Column column : columns){
            if(column.getColumnName().equalsIgnoreCase(VERSION_COLUMN_NAME)){
                return true;
            }
        }
        return false;
    }

    private void buildVersionExpression(Update update){
        // 列 version
        Column versionColumn = new Column();
        versionColumn.setColumnName(VERSION_COLUMN_NAME);
        update.getColumns().add(versionColumn);

        // 值 version+1
        Addition add = new Addition();
        add.setLeftExpression(versionColumn);
        add.setRightExpression(new LongValue(1));
        update.getExpressions().add(add);
    }

    private Expression buildVersionEquals(Object originalVersion){
        Column column = new Column();
        column.setColumnName(VERSION_COLUMN_NAME);

        // 条件 version = originalVersion
        EqualsTo equal = new EqualsTo();
        equal.setLeftExpression(column);
        equal.setRightExpression(new LongValue(originalVersion.toString()));
        return equal;
    }

}
