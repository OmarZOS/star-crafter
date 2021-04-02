/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileFilter;
import java.io.IOException;
import java.util.StringTokenizer;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

//import org.graalvm.compiler.graph.NodeList;
import org.w3c.dom.*;
import org.w3c.dom.NodeList;
import org.xml.sax.Attributes;


/**
 *
 * @author T470
 */
public class CORPUS_to_XML_with_DOM {
    
    



    public static void main(String argv[]) throws ParserConfigurationException, DOMException, IOException, TransformerException {
        DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder domBuilder = domFactory.newDocumentBuilder();
        String XML_path = "";   
        Document newDoc = domBuilder.newDocument();
       
        
        Element rootElement = newDoc.createElement("Observations");
        newDoc.appendChild(rootElement);
        BufferedReader dataFile;
        String testDir="data2020/";



        File testDirectory = new File(testDir);
        File[] files = testDirectory.listFiles(new FileFilter() {
            @Override
            public boolean accept(File pathname) {
                String name = pathname.getName();//.toLowerCase();
                return name.endsWith(".op")&&pathname.isFile(); // maybe, the user has decided to put something odd..
            }
        });

        String curLine  ;
        StringTokenizer st = null;
        String DTDcontent= "";
        //DTDcontent.. I had to handle manually.. (to avoid more complexity..)
        boolean AlreadyHavingStation=false;
        String LastID="";
        Element station=newDoc.createElement("sorry");//sorry, created in vain
        // the last three declarations are for more efficiency

        for(File file : files ){ 
            
            dataFile = new BufferedReader(new FileReader(testDir+file.getName()));
            
            curLine=dataFile.readLine();
            if(curLine!=DTDcontent){    //comparing if there's another definition
                if(DTDcontent!=""){
                    //System.out.println("Incoherence warning!! odd file definition found: "+file.getName());
                    //continue;//now, we pass to another 
                }
                DTDcontent=curLine;
            }

            
            
            //curLine = dataFile.readLine();
            next:
            while((curLine=dataFile.readLine())!= null) {

                st= new StringTokenizer(curLine);
                
                Element observation = newDoc.createElement("Observation");
                //Element value1 = newDoc.createElement("station_id") ;
                Node id_station = newDoc.createTextNode(st.nextToken()) ;
                if(id_station.getNodeValue().toString()!=LastID)
                    AlreadyHavingStation=false;
                // no worries, this will be later used to place the observation

                Node fulldate = newDoc.createTextNode(st.nextToken()) ;
                fulldate = newDoc.createTextNode(st.nextToken()) ;

                Element year = newDoc.createElement("year");
                Node annee = newDoc.createTextNode(fulldate.getNodeValue().toString().substring(0,4));
                year.appendChild(annee);

                Element month = newDoc.createElement("month") ;
                Node mois = newDoc.createTextNode(fulldate.getNodeValue().toString().substring(4,6));
                month.appendChild(mois);

                Element day = newDoc.createElement("day") ;
                Node jour = newDoc.createTextNode(fulldate.getNodeValue().toString().substring(6,8));
                day.appendChild(jour);


                Element temp = newDoc.createElement("temp") ;
                Node tem = newDoc.createTextNode(st.nextToken()) ;
                temp.appendChild(tem);
                
                
                
                observation.appendChild(year) ;
                observation.appendChild(month) ;
                observation.appendChild(day) ;
                observation.appendChild(temp) ;
                //our observation is now ready..
                if(AlreadyHavingStation)    //the most happy case..
                    station.appendChild(observation);
                else{

                    
                    NodeList veterans = newDoc.getElementsByTagName("stn");
                    for(int i=0;i< veterans.getLength();i++){
                        Node lost = veterans.item(i);
                        // System.out.println(lost.getAttributes().item(0).getNodeValue().toString());
                        // System.out.println(id_station.getNodeValue().toString()+"\n");
                        if(Integer.parseInt(lost.getAttributes().item(0).getNodeValue().toString())==Integer.parseInt(id_station.getNodeValue().toString())){
                            //System.out.println("waaaaaaay");//it's 1:43AM.. It finally worked using integers..
                            AlreadyHavingStation=true;
                            lost.appendChild(observation);
                            LastID=id_station.getNodeValue().toString();
                            station.setNodeValue(lost.getNodeValue());
                            continue next;
                        }

                    }


                    station = newDoc.createElement("stn");
                    station.setAttribute("station_id",id_station.getNodeValue());
                    rootElement.appendChild(station);
                    station.appendChild(observation);
                    AlreadyHavingStation=true;
                    LastID=id_station.getNodeValue().toString();
                
                } 
            }  
            
            //---- Save Modification in a new XML file
            Transformer transformer = TransformerFactory.newInstance().newTransformer();
            Result output = new StreamResult(new File( "world_temperatures.xml"));
            Source input = new DOMSource(newDoc);
            transformer.transform(input, output);
        
        }
        
    }    
    }
