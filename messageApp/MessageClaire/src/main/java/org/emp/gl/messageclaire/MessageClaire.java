/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.emp.gl.messageclaire;

import java.io.Serializable;

/**
 *
 * @author billal
 */
public class MessageClaire implements Serializable {
    
    String message ; 
    
    String userId ; 
    
    String titre ;      

    @Override
    public String toString() {
        return new StringBuilder()
                .append("emmitteur --> ")
                .append(getUserId())
                .append("\ntitre --> ")
                .append(getTitre())
                .append("\nmessage -->")
                .append(getMessage())
                .toString() ;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }       
}
