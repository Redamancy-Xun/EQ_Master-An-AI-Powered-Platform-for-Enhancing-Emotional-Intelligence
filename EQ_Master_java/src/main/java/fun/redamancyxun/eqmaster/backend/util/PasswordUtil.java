package fun.redamancyxun.eqmaster.backend.util;

import cn.hutool.crypto.SecureUtil;

public class PasswordUtil {

    public static String convert(String origin){
        return SecureUtil
                .md5(origin)
                .substring(3,13);
    }


    public static void main(String[] args) {
        String password = "123456";
        System.out.println(SecureUtil.md5(password));
        System.out.println(convert(password));
    }

}
