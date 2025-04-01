package com.moadata.bdms.common.util.encrypt;

import java.security.MessageDigest;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import com.moadata.bdms.common.exception.ProcessException;

/**
 * 암호화, 복호화 처리 클래스
 * 
 */
public final class EncryptUtil {
    public static final String ENCRYPT_ALGORITHM = "AES";
    
    public static final String ENCRYPT_KEY = "Mediwalk";
    
    private EncryptUtil() {
        throw new AssertionError();
    }
    
    /**
     * 대칭키 암호화
     * 
     * @param text
     * @return
     * @throws ProcessException 
     */
    public static String encryptText(String text) throws ProcessException {
        String encrypted = null;
        
        try {
            SecretKeySpec ks = new SecretKeySpec(generateKey(ENCRYPT_KEY), ENCRYPT_ALGORITHM);
            Cipher cipher = Cipher.getInstance(ENCRYPT_ALGORITHM);
            cipher.init(Cipher.ENCRYPT_MODE, ks);
            byte[] encryptedBytes = cipher.doFinal(text.getBytes());
            encrypted = new String(Base64Coder.encode(encryptedBytes));
        } catch (Exception e) {
            throw new ProcessException("", e);
        }
        
        return encrypted;
    }
    
    /**
     * 대칭키 복호화
     * 
     * @param text
     * @return
     * @throws ProcessException 
     */
    public static String decryptText(String text) throws ProcessException {
        String decrypted = null;
        
        try {
            SecretKeySpec ks = new SecretKeySpec(generateKey(ENCRYPT_KEY),
                    ENCRYPT_ALGORITHM);
            Cipher cipher = Cipher.getInstance(ENCRYPT_ALGORITHM);
            cipher.init(Cipher.DECRYPT_MODE, ks);
            byte[] decryptedBytes = cipher.doFinal(Base64Coder.decode(text));
            decrypted = new String(decryptedBytes);
        } catch (Exception e) {
           // throw new ProcessException("", e);
        	return "";
        }
        
        return decrypted;
    }
    
    /**
     * 대칭키 생성
     * 
     * @param key
     * @return
     * @throws Exception
     */
    private static byte[] generateKey(String key) {
        byte[] desKey = new byte[16];
        byte[] bkey = key.getBytes();
        
        if (bkey.length < desKey.length) {
            System.arraycopy(bkey, 0, desKey, 0, bkey.length);
            
            for (int i = bkey.length; i < desKey.length; i++)
            {
                desKey[i] = 0;
            }
        } else {
            System.arraycopy(bkey, 0, desKey, 0, desKey.length);
        }
        
        return desKey;
    }
    
    /**
     * 비대칭키 SHA 암호화 (복호화 되지 않음)
     * 
     * @param text
     * @return
     * @throws ProcessException 
     */
    public static String encryptSha(String text) throws ProcessException {
        String encrypted = null;
        
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            md.update(text.getBytes("UTF-8"));
            
            byte[] digested = md.digest();
            encrypted = new String(Base64Coder.encode(digested));
        } catch (Exception e) {
            throw new ProcessException("", e);
        }
        
        return encrypted;
    }

    public static void main(String[] args) throws ProcessException {
        System.out.println(decryptText("u9fWgIVcQWU5etRl9wC5lA=="));
    }
}
