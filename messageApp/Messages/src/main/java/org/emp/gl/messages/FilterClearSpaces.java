package org.emp.gl.messages;

public class FilterClearSpaces extends MessageDecorator{

    public FilterClearSpaces(IMessage instance) {
        super(instance);
        //TODO Auto-generated constructor stub
    }
    
    @Override
    public 
    String
    getMessage(){
        return iMessageInstance.getMessage().replaceAll(" ", "");
    }





}
