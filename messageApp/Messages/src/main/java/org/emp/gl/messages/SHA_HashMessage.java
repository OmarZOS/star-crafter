package org.emp.gl.messages;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class SHA_HashMessage extends MessageDecorator{

    public SHA_HashMessage(IMessage instance) {
        super(instance);
        //TODO Auto-generated constructor stub
    }


    @Override
    public String getMessage(){
        MessageDigest md;
        try {
            md = MessageDigest.getInstance("SHA-256");
            
            // digest() method called 
            // to calculate message digest of an input 
            // and return array of byte
            return md.digest(super.getMessage().getBytes(StandardCharsets.UTF_8)).toString(); 
            
            
        } catch (NoSuchAlgorithmException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } 
        return null;
    }

    
}
