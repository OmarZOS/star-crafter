package org.emp.gl.messages;

public class CryptingCaesar extends MessageDecorator{

    public CryptingCaesar(IMessage instance) {
        super(instance);
        //TODO Auto-generated constructor stub
    }

    @Override
    public String getMessage(){
        return encrypt(iMessageInstance.getMessage(),3).toString();
    }





    public static StringBuffer encrypt(String text, int s)
    {
        StringBuffer result= new StringBuffer();
 
        for (int i=0; i<text.length(); i++)
        {
            if (Character.isUpperCase(text.charAt(i)))
            {
                char ch = (char)(((int)text.charAt(i) +
                                  s - 65) % 26 + 65);
                result.append(ch);
            }
            else
            {
                char ch = (char)(((int)text.charAt(i) +
                                  s - 97) % 26 + 97);
                result.append(ch);
            }
        }
        return result;
    }


    
}
