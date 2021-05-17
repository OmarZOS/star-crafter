package org.emp.gl.sender.service;

import java.beans.PropertyChangeListener;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author billal
 */
public interface MessagingServiceListener extends PropertyChangeListener {
    
    String getRecieverName () ;
}
