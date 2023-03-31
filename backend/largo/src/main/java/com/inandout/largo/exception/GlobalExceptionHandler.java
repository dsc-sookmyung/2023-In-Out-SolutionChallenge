package com.inandout.largo.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {
    @ExceptionHandler(CustomException.class)
    public ResponseEntity<Object> handleCustomException(CustomException e){
        log.warn("handleCustomException");
        log.warn("status: {}, error: {}, name: {}", e.getErrorCode().getHttpStatus().value(), e.getErrorCode().getHttpStatus().name(), e.getErrorCode().name());
        return handleExceptionInternal(e.getErrorCode());
    }

    protected ResponseEntity<Object> handleExceptionInternal(ErrorCode errorCode){
        return ResponseEntity.status(errorCode.getHttpStatus())
                .body(ErrorResponse.builder()
                        .status(errorCode.getHttpStatus().value())
                        .error(errorCode.getHttpStatus().name())
                        .name(errorCode.name())
                        .message(errorCode.getMessage())
                        .build()
                );
    }
}
