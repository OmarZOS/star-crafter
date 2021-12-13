


//sed -i 's/oldText/newText/g' filename

public class Dictionary{
    public static void main(String[] args){// wordLength, predefs
        if(args.length!=2){
            System.out.println("provide two args please..");
            System.exit(0);
        }

        writer(Integer.parseInt(args[0]), args[1],"");

    }

    public static void writer(int k,String fixed,String built){
        
        if(k==0){
            System.out.println(built);
            // System.exit(0);
            return;
        }

        int length=fixed.length();

        for (int i = 0; i < length; i++) {
            
            // System.out.print(fixed.charAt(i));
            String subString = fixed.substring(0,i)+fixed.substring(i+1);
            writer(k-1, subString,built+fixed.charAt(i));

        }

        if(k>length){
            for (char c = 'a';c<='z';c++ ) {
                // System.out.print(c);
                writer(k-1, fixed,built+c);
            }
            for (char c = '0';c<='9';c++ ) {
                System.out.print(c);
                writer(k-1, fixed,built+c);
            }
            for (char c = 'A';c<='Z';c++ ) {
                System.out.print(c);
                writer(k-1, fixed,built+c);
            }

        }

    }

}