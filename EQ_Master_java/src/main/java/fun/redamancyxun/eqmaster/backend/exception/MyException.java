package fun.redamancyxun.eqmaster.backend.exception;

import lombok.Getter;

@Getter
public class MyException extends RuntimeException {

    private EnumExceptionType enumExceptionType;

    private Object errorMsg;

    public MyException(){
        this.enumExceptionType = EnumExceptionType.UNKNOWN_ERROR;
    }

    public MyException(EnumExceptionType enumExceptionType) {
        this.enumExceptionType = enumExceptionType;
    }

    public MyException(EnumExceptionType commonErrorCode, Object errorMsg) {
        this.enumExceptionType = commonErrorCode;
        this.errorMsg = errorMsg;
    }
}
