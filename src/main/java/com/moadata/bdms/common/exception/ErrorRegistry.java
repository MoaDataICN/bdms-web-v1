package com.moadata.bdms.common.exception;

public interface ErrorRegistry {
	public String getErrorCode();
	public String getErrorMessage(String... args);
}
