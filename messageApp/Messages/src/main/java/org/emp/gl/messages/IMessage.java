/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.emp.gl.messages;

/**
 *
 * @author tina
 */
public interface IMessage {

    String getTitle();

    String getSender();

    String getMessage();
    
    void setTitle(String title);

    void setSender(String sender);

    void setMessage(String message);
    

}
