package org.emp.gl.messages;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5HashMessage extends MessageDecorator{

    public MD5HashMessage(IMessage instance) {
        super(instance);
        //TODO Auto-generated constructor stub
    }


    @Override
    public
    String getMessage(){
        MessageDigest md;
        try {
            md = MessageDigest.getInstance("MD5");
            //Add password bytes to digest
            md.update(super.getMessage().getBytes());
            //Get the hash's bytes 
            byte[] bytes = md.digest();
            //This bytes[] has bytes in decimal format;
            //Convert it to hexadecimal format
            StringBuilder sb = new StringBuilder();
            for(int i=0; i< bytes.length ;i++)
            {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            //Get complete hashed password in hex format
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return  null;
        }
    }




    
}
