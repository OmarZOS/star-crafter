/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.emp.gl.core.lookup;
import java.beans.PropertyChangeSupport;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import org.emp.gl.loglistener.LogListener;
import org.emp.gl.strategy.Strategy;
import org.emp.gl.classadapter.ClassAdapter;


// import org.emp.gl.ClassAdapter.ClassAdapter;


/**
 *
 * @author tina
 */
public class Lookup {
    
    Map<Class, ArrayList<ClassAdapter>> services = new HashMap<>() ; 
    
    PropertyChangeSupport pcs = new PropertyChangeSupport(this);

    //Lookup part :

    public <T> void register (Class<? super T> service, ClassAdapter instance){
        // System.out.println("adding");
        if(services.containsKey(service)){
            services.get(service).add(instance);
        }
        else{
            ArrayList<ClassAdapter> serviceImplementationList = new ArrayList<>();
            serviceImplementationList.add(instance);
            services.put((Class)service, serviceImplementationList);
        }
        pcs.firePropertyChange("Registration", service.getName(), instance.getClass().getName());
    }
    
    public <T> T getService (Class<T> service){
        //calling for strategy pattern

        simpleStrategy strategy = ( new LookupContext()).bestStrategy(); 

        T instance = (strategy!=null)?(T)strategy.getBestChoice(services.get(service)):null;

        if(instance==null)
            pcs.firePropertyChange("Unfound", service.getName(), null);
        else
            pcs.firePropertyChange("Demand", service.getName(), instance.getClass().getName());

        return instance;
    }

    public <T> ArrayList<T>  getAllServices (Class<T> service){
        return (services.containsKey(service))?(ArrayList<T>)services.get(service):null;
    }
    
    //Singleton Part :
    
    private Lookup() {}
    
    public static Lookup getInstance() {
        return LookupHolder.INSTANCE;
    }

    //single Responsability part :
    
    private static class LookupHolder {
        
        private static final Lookup INSTANCE = new Lookup();
    }

    private class LookupContext {
        private  
        simpleStrategy bestStrategy(){
            //should have had a better strategy
            return  new simpleStrategy();
        }
    }
    private class simpleStrategy {
        
        public 
        ClassAdapter getBestChoice(ArrayList<ClassAdapter> implementations){
            return (implementations.size()==0)?null:implementations.get(0);
        }
    }

    //Observable part :
    
    void addListener (LogListener listener) {
		pcs.addPropertyChangeListener(listener); ;
	}
	
	void removeListener (LogListener listener) {
		pcs.removePropertyChangeListener(listener) ;
	}
	
}