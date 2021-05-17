package org.emp.gl.messages;

import org.emp.gl.messageclaire.MessageClaire;

public abstract class MessageDecorator extends MessageClaire implements IMessage{
    IMessage iMessageInstance ;

    MessageDecorator(IMessage instance){
        iMessageInstance=instance;
    }

    @Override
    public
    String getTitle(){return iMessageInstance.getTitle();}

    @Override
    public
    String getSender(){return iMessageInstance.getSender();}

    @Override
    public
    String getMessage(){return iMessageInstance.getMessage();}

    @Override
    public    
    void setTitle(String title){iMessageInstance.setTitle(title);}

    @Override
    public
    void setSender(String sender){iMessageInstance.setSender(sender);}

    @Override
    public
    void setMessage(String message){iMessageInstance.setMessage(message);}

    @Override
    public String toString() {
        return new StringBuilder()
                .append("sender : ")
                .append(getSender())
                .append("\n")
                .append("title : ")
                .append(getTitle())
                .append("\n")
                .append("message : ")
                .append(getMessage())
                .toString() ;
    }

}
