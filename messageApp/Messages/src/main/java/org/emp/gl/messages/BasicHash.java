package org.emp.gl.messages;


import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class BasicHash extends MessageDecorator{

    public BasicHash(IMessage instance) {
        super(instance);
        //TODO Auto-generated constructor stub
    }



    @Override
    public String getMessage(){
        return ""+super.getMessage().hashCode();
    }

    
}

