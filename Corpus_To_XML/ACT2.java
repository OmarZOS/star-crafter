
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








public class ACT2 {
    
    public static String WantedID="";  

    public static float SAX_highTemp(String XML_File, String Station_ID){
        try {
                SAXParserFactory factory = SAXParserFactory.newInstance();
                factory.setNamespaceAware(true);
                factory.setValidating(false);
                SAXParser saxParser_1 = factory.newSAXParser();
                
                //SAXParser saxParser_2 = factory.newSAXParser();

                String XML_file_1 = "world_temperatures.xml";
                WantedID=Station_ID;
                XMLReader xmlReader = saxParser_1.getXMLReader();
                MyContentHandler1 content_handler_1 = new MyContentHandler1() ;
                try {
                    saxParser_1.parse(XML_file_1, content_handler_1);
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
               
                //----- error handling in SAX
                
                
                
                return Float.parseFloat(content_handler_1.result);
                
        } 
        catch ( ParserConfigurationException | SAXException e ) {
            System.out.println("Error ===> " + e);
        }
        return 123 ;
    }


    public static void main(String argv[]) throws ParserConfigurationException, SAXException, IOException {


        System.out.print("Maxium Temperature captured by Station 010010 is : \n");
        System.out.println((SAX_highTemp("world_temperatures.xml","008415")));

    }




    private static class MyContentHandler1 extends DefaultHandler {
    
        String  temperature = "";
        boolean this_is_temperature = false;
        boolean this_is_the_station = false;
        //boolean this_is_course = false ;
        String  result = "0" ;
        
        @Override
        public void startElement(String uri, String localName,String qName, Attributes attributes) throws SAXException {
            if(qName.equals("stn")){
                if(attributes.getValue(0).equals(WantedID)){
                    this_is_the_station=true;
                }
                else
                    this_is_the_station=false;
            }
            
            if(this_is_the_station){
                if(qName.equals("temp")){
                    this_is_temperature=true;
                    


                }
            }


            //this_is_the_station = qName.equalsIgnoreCase("stn");
        }
        
        @Override
        public void endElement(String uri, String localName, String qName) throws SAXException {
            //System.out.println("-- End Element : [" + qName + "]");
            if(qName.equals("stn"))
                this_is_the_station=false;
            if(qName.equals("temp"))
                this_is_temperature=false;

                        
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



    private static class MyErrorHandler  implements ErrorHandler {
        
    int error_number = 0 ;

    public void warning(SAXParseException e) throws SAXException {
        error_number++ ;
        System.out.println(error_number + " --> Warning: " ); 
        printInfo(e);
    }
        
    public void error(SAXParseException e) throws SAXException {
        error_number++ ;
        System.out.println(error_number + " --> Error: " ); 
        printInfo(e);
    }
        
    public void fatalError(SAXParseException e) throws SAXException {
        error_number++ ;
        System.out.println(error_number + " --> Fattal error: "); 
        printInfo(e);
    }
        
    private void printInfo(SAXParseException e) {
        //System.out.println("   Public ID       : " + e.getPublicId());
        //System.out.println("   System ID       : " + e.getSystemId());
        System.out.println("   Line number     : " + e.getLineNumber());
        System.out.println("   Column number   : " + e.getColumnNumber());
        System.out.println("   Message         : " + e.getMessage());
    }
    }  

}
