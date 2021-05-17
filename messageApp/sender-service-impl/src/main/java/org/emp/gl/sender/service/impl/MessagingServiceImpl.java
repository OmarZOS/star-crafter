/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.emp.gl.sender.service.impl;

import java.beans.PropertyChangeSupport;
import org.emp.gl.sender.service.MessagingService;
import org.emp.gl.sender.service.MessagingServiceListener;

/**
 *
 * @author billal
 */
public class MessagingServiceImpl implements MessagingService {

    PropertyChangeSupport pcs = new PropertyChangeSupport(this);
    
    @Override
    public void sendMessage(String destination, Object message) {
        
        pcs.firePropertyChange(destination, null, message);
    }

    @Override
    public void subscribe(MessagingServiceListener listener) {
        pcs.addPropertyChangeListener(listener.getRecieverName(), listener);        
    }

    @Override
    public void unsubscribe(MessagingServiceListener listener) {
        pcs.removePropertyChangeListener(listener);
    }
    
    
}
