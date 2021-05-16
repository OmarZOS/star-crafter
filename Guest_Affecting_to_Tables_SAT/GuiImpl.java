import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;

import org.sat4j.specs.ContradictionException;
import org.sat4j.specs.TimeoutException;


import java.awt.event.*;

import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.StringTokenizer;


public class GuiImpl{
    
    private javax.swing.JButton activateButton;
    
    private static javax.swing.JTextArea board,couples;
    JTextField table,persons,chairs,men;  
    private JFrame frame;
    private JLabel coupleLabel;

    public GuiImpl(){
        //currentState=WorkState.INACTIVE;
        //focus=ZoomState.NORMAL;        
        initComponents();
        
    }

    private void initComponents() {
    
        frame=new JFrame("Guest Handler");//creating instance of JFrame  
        
        board = new javax.swing.JTextArea();
        couples = new javax.swing.JTextArea();
        activateButton = new javax.swing.JButton();
        coupleLabel = new JLabel("Couples : man1,woman1;man2,woman2");



        table=new JTextField("table count : 3");  
        table.setBounds(50,10, 200,30);  
        frame.add(table);
        persons=new JTextField("persons count : 12");  
        persons.setBounds(50,60, 200,30);  
        frame.add(persons);
        chairs=new JTextField("chairs count : 4");  
        chairs.setBounds(50,110, 200,30);  
        frame.add(chairs);

        men=new JTextField("men, ex : 1,3,5,8,9,11");  
        men.setBounds(50,160, 200,30);
        frame.add(men);


        
        board.setBounds(720/2-150, 720/2, 300, 300);
        board.setBackground(new java.awt.Color(1, 1, 1));
        board.setFont(new java.awt.Font("Serif", 0, 14)); // NOI18N
        board.setForeground(new java.awt.Color(14, 200, 168));
        // board.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        board.setText("Successful results are displayed here..");
        frame.add(board);

        couples.setBounds(720/2-50, 210, 300, 60);
        // couples.setBackground(new java.awt.Color(1, 1, 1));
        // couples.setFont(new java.awt.Font("Serif", 0, 14)); // NOI18N
        // couples.setForeground(new java.awt.Color(14, 200, 168));
        // board.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        couples.setText("1,4 ; 3,2");
        frame.add(couples);

        coupleLabel.setBounds(10,210,300,30);
        frame.add(coupleLabel);

        activateButton.setText("Resolve");
        activateButton.setBounds( 275 , 60 , 100,28);
        activateButton.setForeground(new java.awt.Color(247,247,247));
        activateButton.setBackground(new java.awt.Color(53,53,53));

        activateButton.addActionListener(new ActionListener(){
            @Override
            public void actionPerformed(ActionEvent e){
                //currentState=WorkState.ACTIVE;
                try {
                    Guest_Affecting_to_Tables_SAT.INVITES=Integer.parseInt((new StringTokenizer(persons.getText(),", azertyuiopqsdfghjklmwxcvbn:").nextToken()));
                    Guest_Affecting_to_Tables_SAT.TABLES=Integer.parseInt((new StringTokenizer(table.getText(),", azertyuiopqsdfghjklmwxcvbn:").nextToken()));
                    Guest_Affecting_to_Tables_SAT.CHAISES=Integer.parseInt((new StringTokenizer(chairs.getText(),", azertyuiopqsdfghjklmwxcvbn:").nextToken()));
                    // Guest_Affecting_to_Tables_SAT.
                    
                    ArrayList<Integer> menArray=new ArrayList<>();
                    StringTokenizer st = new StringTokenizer(men.getText(),", azertyuiopqsdfghjklmwxcvbn:");
                    while(st.hasMoreTokens()){
                        menArray.add(Integer.parseInt(st.nextToken().toString()));
                    }
                    Guest_Affecting_to_Tables_SAT.HOMME=menArray.stream().mapToInt(i->i).toArray();
                    ArrayList<Integer> womenArray=new ArrayList<>();
                    for (int i=1;i<=Guest_Affecting_to_Tables_SAT.INVITES;i++) {
                        if(!menArray.contains(i))
                        womenArray.add(i);
                    }
                    Guest_Affecting_to_Tables_SAT.FEMME=womenArray.stream().mapToInt(i->i).toArray();
                    
                    
                    //now couples : 
                    ArrayList<int[]> couplesbigArray = new ArrayList<>();
                    st = new StringTokenizer(couples.getText(),";azertyuiopqsdfghjklmwxcvbn:");
                    while (st.hasMoreTokens()) {
                        StringTokenizer st2 = new StringTokenizer(st.nextToken(),", ");
                        ArrayList<Integer> coupleArray=new ArrayList<>();
                        coupleArray.add(Integer.parseInt(st2.nextToken()));
                        coupleArray.add(Integer.parseInt(st2.nextToken()));
                        couplesbigArray.add(coupleArray.stream().mapToInt(i->i).toArray());
                        
                        // System.out.println(couplesbigArray+"heeeey");
                    }
                    int[][] jsx = new int[couplesbigArray.size()][2];
                    for(int j=0;j<couplesbigArray.size();j++)
                    jsx[j]=couplesbigArray.get(j);
                    Guest_Affecting_to_Tables_SAT.COUPLES=jsx;
                    
                    Guest_Affecting_to_Tables_SAT.InSoftware();
                } catch (ContradictionException | TimeoutException e1) {
                    // TODO Auto-generated catch block
                    e1.printStackTrace();
                }

            }
        });
        frame.add(activateButton);
        
        



        frame.setLayout(null);//using no layout managers  
        frame.setForeground(new java.awt.Color(53,53,53));
        frame.setSize(720,720);//400 width and 500 height  
        frame.setVisible(true);//making the frame visible  


    }

    public static void displayResult(String text){
        board.setText(text);
    }

}