package org.emp.gl.messages;

public class FilterNoPunctuation extends MessageDecorator{

    public FilterNoPunctuation(IMessage instance) {
        super(instance);
        //TODO Auto-generated constructor stub
    }
    
    @Override
    public 
    String
    getMessage(){
        return iMessageInstance.getMessage().replaceAll("\\p{.+-*/=)à&œ\"'^!:;,?*ùm$%§}", "");
    }

}
