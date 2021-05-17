/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.emp.gl.sender.service;

/**
 *
 * @author billal
 */
public interface MessagingService   {
    
    void sendMessage (String destination, Object message) ;
    
    void subscribe (MessagingServiceListener listener) ;
    
    void unsubscribe (MessagingServiceListener listener) ; 
}
