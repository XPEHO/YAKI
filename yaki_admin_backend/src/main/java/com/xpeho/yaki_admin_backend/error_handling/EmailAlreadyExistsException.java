package com.xpeho.yaki_admin_backend.error_handling;

import jakarta.persistence.EntityNotFoundException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;


@ResponseStatus(HttpStatus.EXPECTATION_FAILED)
public class EmailAlreadyExistsException extends DuplicateKeyException {
    public EmailAlreadyExistsException(String msg) {
        super(msg);
    }
}
