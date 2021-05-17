package org.emp.gl.messages;

public class FilterCapsOn extends MessageDecorator{

    public FilterCapsOn(IMessage instance) {
        super(instance);
        //TODO Auto-generated constructor stub
    }

    @Override
    public 
    String
    getMessage(){
        return iMessageInstance.getMessage().toUpperCase();
    }


    
}
