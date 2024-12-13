package fun.redamancyxun.eqmaster.backend.util;

import fun.redamancyxun.eqmaster.backend.exception.EnumExceptionType;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import org.springframework.util.CollectionUtils;

import java.util.Collection;
import java.util.Map;

/**
 * @author yannis
 * @version 2020/7/23 0:51
 */
public class AssertUtil {

    public AssertUtil() {
    }

    public static void isTrue(boolean expValue, EnumExceptionType resultCode, Object obj) {
        if (!expValue) {
            throw new MyException(resultCode,obj);
        }
    }

    public static void isTrue(boolean expValue, EnumExceptionType resultCode) {
        if (!expValue) {
            throw new MyException(resultCode);
        }
    }

    public static void isFalse(boolean expValue, EnumExceptionType resultCode, Object obj) {
        isTrue(!expValue, resultCode, obj);
    }

    public static void isFalse(boolean expValue, EnumExceptionType resultCode) {
        isTrue(!expValue, resultCode);
    }

    public static void equals(Object obj1, Object obj2, EnumExceptionType resultCode, Object obj) {
        isTrue(obj1 == null ? obj2 == null : obj1.equals(obj2), resultCode, obj);
    }

    public static void notEquals(Object obj1, Object obj2, EnumExceptionType resultCode, Object obj) {
        isTrue(obj1 == null ? obj2 != null : !obj1.equals(obj2), resultCode, obj);
    }

    public static void contains(Object base, Collection<?> collection, EnumExceptionType resultCode, Object obj) {
        notEmpty(collection, resultCode, obj);
        isTrue(collection.contains(base), resultCode, obj);
    }

    public static void contains(Object base, Collection<?> collection, EnumExceptionType resultCode) {
        notEmpty(collection, resultCode);
        isTrue(collection.contains(base), resultCode);
    }

    public static void in(Object base, Object[] collection, EnumExceptionType resultCode, Object obj) {
        notNull(collection, resultCode, obj);
        boolean hasEqual = false;
        Object[] var5 = collection;
        int var6 = collection.length;

        for(int var7 = 0; var7 < var6; ++var7) {
            Object obj2 = var5[var7];
            if (base == obj2) {
                hasEqual = true;
                break;
            }
        }

        isTrue(hasEqual, resultCode, obj);
    }

    public static void notIn(Object base, Object[] collection, EnumExceptionType resultCode, Object obj) {
        if (null != collection) {
            Object[] var4 = collection;
            int var5 = collection.length;

            for(int var6 = 0; var6 < var5; ++var6) {
                Object obj2 = var4[var6];
                isTrue(base != obj2, resultCode, obj);
            }

        }
    }

    public static void blank(String str, EnumExceptionType resultCode, Object obj) {
        isTrue(isBlank(str), resultCode, obj);
    }

    public static void notBlank(String str, EnumExceptionType resultCode, Object obj) {
        isTrue(!isBlank(str), resultCode, obj);
    }

    public static void isNull(Object object, EnumExceptionType resultCode, Object obj) {
        isTrue(object == null, resultCode, obj);
    }

    public static void notNull(Object object, EnumExceptionType resultCode, Object obj) {
        isTrue(object != null, resultCode, obj);
    }

    public static void notNull(Object object, EnumExceptionType resultCode) {
        isTrue(object != null, resultCode, null);
    }

    public static void isNull(Object object, EnumExceptionType resultCode) {
        isTrue(object == null, resultCode, null);
    }

    public static void notEmpty(Collection collection, EnumExceptionType resultCode, Object obj) {
        isTrue(!CollectionUtils.isEmpty(collection), resultCode, obj);
    }

    public static void notEmpty(Collection collection, EnumExceptionType resultCode) {
        isTrue(!CollectionUtils.isEmpty(collection), resultCode);
    }

    public static void empty(Collection collection, EnumExceptionType resultCode, Object obj) {
        isTrue(CollectionUtils.isEmpty(collection), resultCode, obj);
    }

    public static void notEmpty(Map map, EnumExceptionType resultCode, Object obj) {
        isTrue(!CollectionUtils.isEmpty(map), resultCode, obj);
    }

    public static void empty(Map map, EnumExceptionType resultCode, Object obj) {
        isTrue(CollectionUtils.isEmpty(map), resultCode, obj);
    }

    private static boolean isBlank(String str) {
        int strLen;
        if(str != null && (strLen = str.length()) != 0) {
            for(int i=0; i<strLen; ++i) {
                if(!Character.isWhitespace(str.charAt(i))) {
                    return false;
                }
            }

            return true;
        } else {
            return true;
        }
    }

}
