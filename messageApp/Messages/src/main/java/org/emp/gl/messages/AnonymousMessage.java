package org.emp.gl.messages;

public class AnonymousMessage extends MessageDecorator{

    public AnonymousMessage(IMessage instance) {
        super(instance);
        //TODO Auto-generated constructor stub
    }

    @Override
    public
    String getSender(){return "Unknown";}

    
}
