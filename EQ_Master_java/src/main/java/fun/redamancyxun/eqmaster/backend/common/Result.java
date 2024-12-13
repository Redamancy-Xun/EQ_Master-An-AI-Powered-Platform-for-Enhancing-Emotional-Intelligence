package fun.redamancyxun.eqmaster.backend.common;

import fun.redamancyxun.eqmaster.backend.exception.EnumExceptionType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Result {

    private int code;
    private String message;
    private Object result;

    public static Result success(Object data) {
        return success("操作成功", data);
    }

    public static Result success(String mess, Object data) {
        Result m = new Result();
        m.setCode(0);
        m.setResult(data);
        m.setMessage(mess);
        return m;
    }

    public static Result fail(String mess) {
        return fail(mess, null);
    }

    public static Result fail(String mess, Object data) {
        Result m = new Result();
        m.setCode(-1);
        m.setResult(data);
        m.setMessage(mess);

        return m;
    }

    public static Result result(EnumExceptionType enumExceptionType, Object data) {
        Result m = new Result();
        m.setCode(enumExceptionType.getErrorCode());
        m.setResult(data);
        m.setMessage(enumExceptionType.getCodeMessage());

        return m;
    }

    public static Result result(EnumExceptionType enumExceptionType) {
        return result(enumExceptionType,null);
    }
}
