

import java.io.IOException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import java.lang.Float;


import org.xml.sax.Attributes;
import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.DefaultHandler;
import java.io.FileWriter; 










public class AVG_Temp {


    
    public static String WantedID="";  

    class tuple{
        public String StatID="";
        public String Year="";
        public String Month="";
        public float sum=0;
        public int count=0;
        tuple(String a,String b,String c,float d){
            StatID=a;
            Year=b;
            Month=c;
            sum=d;
            count=1;
        }
    }
    
   

    public static float SAX_AVGtemp(String XML_File, String Station_ID){
        try {
                SAXParserFactory factory = SAXParserFactory.newInstance();
                factory.setNamespaceAware(true);
                factory.setValidating(false);
                SAXParser saxParser_1 = factory.newSAXParser();
                
                //SAXParser saxParser_2 = factory.newSAXParser();

                String XML_file_1 = "world_temperatures.xml";
                WantedID=Station_ID;
                XMLReader xmlReader = saxParser_1.getXMLReader();
                MyContentHandler2 content_handler_2 = new MyContentHandler2() ;
                try {
                    saxParser_1.parse(XML_file_1, content_handler_2);
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
               
                //----- error handling in SAX
                
                
                
                return Float.parseFloat(content_handler_2.result);
                
        } 
        catch ( ParserConfigurationException | SAXException e ) {
            System.out.println("Error ===> " + e);
        }
        return 123 ;
    }



    public static void main(String argv[]) throws ParserConfigurationException, SAXException, IOException {


        System.out.print("Maxium Temperature captured by Station 010010 is : \n");
        System.out.println((SAX_AVGtemp("world_temperatures.xml","010010")));

    }




    private static class MyContentHandler2 extends DefaultHandler {
    
        String  temperature = "";
        boolean this_is_temperature = false;
        boolean this_is_a_station = false;
        boolean this_is_the_Year = false;
        boolean this_is_a_month = false;
        boolean this_is_a_day = false;
        //boolean this_is_course = false ;
        String  result = "0" ;
        float sum=0;
        int count=0;
        tuple[] tuplelist;
        String currentStationID="";
        
        @Override
        public void startElement(String uri, String localName,String qName, Attributes attributes) throws SAXException {
            if(qName.equals("stn")){
                this_is_a_station=true;
                currentStationID=attributes.getValue(0);



            }
            
            if(this_is_a_station){
                if(qName.equals("temp")){
                    this_is_temperature=true;
                    


                }
            }


            //this_is_the_station = qName.equalsIgnoreCase("stn");
        }
        
        @Override
        public void endElement(String uri, String localName, String qName) throws SAXException {
            //System.out.println("-- End Element : [" + qName + "]");
            if(qName.equals("stn")){
                this_is_a_station=false;
                //now we should write a file..




            }
            if(qName.equals("temp")){
                this_is_temperature=false;
            }
                        
            /*
            result.concat("<chapitre>") ;
            result.concat(text_of_an_element) ;
            result.concat("</chapitre>") ;
            System.out.println(" \t \t \t [" + result + "]");
            */
            //text_of_an_element = "" ; //--- Remove the content of the tag after displaying it
        }
       
        @Override
        public void characters(char ch[], int start, int length) throws SAXException {
            if(this_is_temperature){
                String text = new String(ch, start, length) ;
                temperature = text ;
                if(Float.parseFloat(temperature)>Float.parseFloat(result)){
                    result=temperature;
                }

            }
        }
}



    
    
}
