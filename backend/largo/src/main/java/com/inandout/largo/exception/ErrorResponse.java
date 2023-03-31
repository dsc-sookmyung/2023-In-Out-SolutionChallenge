package com.inandout.largo.exception;

import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@Builder
@RequiredArgsConstructor
public class ErrorResponse {
    private final int status;
    private final String error;
    private final String name;
    private final String message;

}
