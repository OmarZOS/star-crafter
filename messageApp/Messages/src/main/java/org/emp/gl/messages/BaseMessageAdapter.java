/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.emp.gl.messages;

import org.emp.gl.messageclaire.MessageClaire;

/**
 *
 * @author tina
 */
public class BaseMessageAdapter extends MessageClaire implements IMessage {

    @Override
    public String getTitle() {
        return getTitre() ; 
    }

    @Override
    public String getSender() {
        return getUserId() ;
    }

    @Override
    public void setTitle(String title) {
        setTitre(title);
    }

    @Override
    public void setSender(String sender) {
        setUserId(sender);
    }
    
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
