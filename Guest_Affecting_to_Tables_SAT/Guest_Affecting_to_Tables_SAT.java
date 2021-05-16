/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
// package TP_SAT;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;

import org.sat4j.core.VecInt;
import org.sat4j.maxsat.SolverFactory;
import org.sat4j.reader.DimacsReader;
import org.sat4j.reader.ParseFormatException;
import org.sat4j.reader.Reader;
import org.sat4j.specs.ContradictionException;
import org.sat4j.specs.IProblem;
import org.sat4j.specs.ISolver;
import org.sat4j.specs.TimeoutException;



/**
 *
 * @author omar
 */
public class Guest_Affecting_to_Tables_SAT {

    /**
     * @param args the command line arguments
     * @throws org.sat4j.specs.ContradictionException
     * @throws org.sat4j.specs.TimeoutException
     * @throws org.sat4j.reader.ParseFormatException
     */
    public static void main(String[] args) throws ContradictionException, TimeoutException, ParseFormatException, IOException {
        
        GuiImpl gui = new GuiImpl();
        // InSoftware();
        // FromFile();
    }


    public  static int 
    INVITES =12,
    TABLES= 3,
    CHAISES = 4;//par table

    public  static int []
    HOMME={1,3,5,8,9,11},//,11,15},//,17,13},   //put the men numbers
    FEMME={2,4,6,7,10,12};//,12,14,16,18};//,19,20};   //should have been deduced, but it's alright

    public  static int [][]
    COUPLES={    //by invited number , man 0 then woman 1
        {1,4},
        {3,2}
        //{8,14},
         //{13,16},
         //{3,18}
    };

    
    public static void InSoftware() throws ContradictionException, TimeoutException
    {
        final int MAXVAR = CHAISES*INVITES*TABLES; // Number of variables
        int nbClauses = 0; // expected number of clauses
        
        ISolver solver = SolverFactory.newDefault(); // SAT solver
        solver.setTimeout(3600); // 1 hour timeout

        // prepare the solver to accept MAXVAR variables and the expected clauses 
        solver.newVar(MAXVAR);
        
        
        // Feed the solver with clauses using arrays of int
        // Example sum of three variables equals 1
        //int[][] clause = {{-1, -2}, {-1, -3}, {-2, -3}, {1, 2, 3}};
        //solver.addClause(new VecInt(clause[i]));


        // 1 & 2 : one person by chaise de table
        //at least an invited person..
        for (int table=1;table<=TABLES;table++) {
            for (int chaise = 1; chaise<= CHAISES; chaise++) {
            // ArrayList<Integer> atLeastClause=new ArrayList<>();
                for(int invite =1;invite<=INVITES;invite++){
                    //atLeastClause = new ArrayList<>();
                    for(int invite2 =1;invite2<=INVITES;invite2++){
                        if(invite==invite2)
                            continue;
                        int[] clause = {-mapper(table,chaise,invite),-mapper(table,chaise,invite2)};
                        // System.out.println(table + "  " + chaise + "  " +invite+" not with "+table+ "  " + chaise+ "  " + invite2);
                        solver.addClause(new VecInt(clause));
                        nbClauses++;
                    }
                    // atLeastClause.add(mapper(table, chaise, invite));   //at least there's a table..
                }
                // System.out.println(atLeastClause);
                // solver.addClause(new VecInt(atLeastClause.stream().mapToInt(i->i).toArray()));
                // nbClauses++;
            }

        }

        for(int invite =1;invite<=INVITES;invite++){ //a guest has a chair in a table at least
            ArrayList<Integer> atLeastClause=new ArrayList<>();
            for (int chaise = 1; chaise<= CHAISES; chaise++) {
                for (int table=1;table<=TABLES;table++) {
                    atLeastClause.add(mapper(table, chaise, invite));
                }
            }
            // System.out.println(atLeastClause);
            solver.addClause(new VecInt(atLeastClause.stream().mapToInt(i->i).toArray()));
            nbClauses++;
        }

        for (int table=1;table<=TABLES;table++) {//a table has an invited in its chair
            ArrayList<Integer> atLeastClause=new ArrayList<>();
            for (int chaise = 1; chaise<= CHAISES; chaise++) {
                for(int invite =1;invite<=INVITES;invite++){ //one chair;
                    atLeastClause.add(mapper(table, chaise, invite));
                }
            }
            // System.out.println(atLeastClause);
            solver.addClause(new VecInt(atLeastClause.stream().mapToInt(i->i).toArray()));
            nbClauses++;
        }
        
        //table unicity
        
        for (int[] couple : COUPLES) {  //pour la contrainte des couples..
            
            for (int femme : FEMME) {//on va exclure les femmes du voisinage de les hommes mariés 
                if(femme==couple[1])//sa femme
                continue;
                for (int table=1;table<=TABLES;table++) {
                    for (int chaise = 1; chaise<= CHAISES; chaise++) {
                        for (int chaise2 = 1; chaise2 <= CHAISES; chaise2++) {
                            if(chaise==chaise2||!(Math.abs(chaise2-chaise)==1||Math.abs(chaise2-chaise)==CHAISES-1))
                                continue;
                            int[] clause = {-mapper(table,chaise,couple[0]),-mapper(table,chaise2,femme)};
                            //System.out.println(table + "  " + chaise2 + "  " +femme+" not with "+table+ "  " + chaise+ "  " + couple[0]);
                            solver.addClause(new VecInt(clause));
                            nbClauses++;
                        }
                        
                    }
                }
            }

            for (int homme : HOMME) {//on va exclure les hommes du voisinage de les hommes mariés
                if(homme==couple[0])//son mari
                    continue;
                for (int table=1;table<=TABLES;table++) {
                    for (int chaise = 1; chaise<= CHAISES; chaise++) {
                        for (int chaise2 = 1; chaise2 <= CHAISES; chaise2++) {
                            if(chaise==chaise2||!(Math.abs(chaise2-chaise)==1||Math.abs(chaise2-chaise)==CHAISES-1))
                                continue;
                            int[] clause = {-mapper(table,chaise,couple[1]),-mapper(table,chaise,homme)};
                            solver.addClause(new VecInt(clause));
                            nbClauses++;
                        }    
                    }
                }
            }
        }

        for (int homme : HOMME) {   //for the man and his surroundings
            boolean isLonely=true;
            int saFemme=-1;
            for(int[] couple : COUPLES){
                if(couple[0]==homme){
                    isLonely=false;
                    saFemme=couple[1];
                    break;
                }
            }

            if(isLonely){
                for (int table = 1 ;table<=TABLES;table++ ) {
                    for (int chaise = 1;chaise <= CHAISES; chaise++) {
                        for (int chaise2 = 1; chaise2 <= CHAISES; chaise2++) {
                            if(!(Math.abs(chaise2-chaise)==1||Math.abs(chaise2-chaise)==CHAISES-1))
                                continue;
                            
                            for(int femme : FEMME){
                                int[] clause = {-mapper(table,chaise,homme),-mapper(table,chaise2,femme)};
                                solver.addClause(new VecInt(clause));
                                nbClauses++;
                                // System.out.println(new VecInt(clause)+" means "+homme+" "+femme+" in "+chaise+" and "+chaise2);
                            }
                        }
                    }
                }
            }
            else{
                for (int table = 1 ;table<=TABLES;table++ ) {
                    for (int chaise = 1;chaise <= CHAISES; chaise++) {
                        for (int chaise2 = 1; chaise2 <= CHAISES; chaise2++) {
                            if(!(Math.abs(chaise2-chaise)==1||Math.abs(chaise2-chaise)==CHAISES-1))
                                continue;
                            
                                for(int femme : FEMME){
                                    if(saFemme!=femme ){
                                        for (int chaise3 = 1; chaise3 <= CHAISES; chaise3++) {
                                            if(!(Math.abs(chaise3-chaise)==1||Math.abs(chaise2-chaise)==CHAISES-1)||(chaise3==chaise2))
                                            continue;
                                            
                                            int[] clause = {-mapper(table, chaise, homme),mapper(table, chaise2, saFemme),-mapper(table, chaise3, femme)};
                                            solver.addClause(new VecInt(clause));
                                            
                                            nbClauses++;
                                        }
                                    }
                                }
                                
                                        }
                                    }
                                }
                                
                            }
                        }
                        
        for (int femme : FEMME) {   //for the woman and her surroundings
            
            boolean isLonely=true;
            int sonMari=-1;
            for(int[] couple : COUPLES){
                if(couple[1]==femme){
                    isLonely=false;
                    sonMari=couple[0];
                    break;
                }
            }
            
            if(isLonely){
                for (int table = 1;table<=TABLES;table++ ) {
                    for (int chaise = 1;chaise <= CHAISES; chaise++) {
                        for (int chaise2 = 1; chaise2 <= CHAISES; chaise2++) {
                            if(!(Math.abs(chaise2-chaise)==1||Math.abs(chaise2-chaise)==CHAISES-1))
                            continue;
                            
                            for(int homme : HOMME){
                                int[] clause = {-mapper(table, chaise, femme),-mapper(table, chaise2, homme)};
                                solver.addClause(new VecInt(clause));
                                nbClauses++;
                                // System.out.println(new VecInt(clause)+" means "+homme+" "+femme+" in "+ chaise +" and "+chaise2);
                            }
                        }
                    }
                }
            }
            else{
                for (int table = 1;table<=TABLES;table++ ) {
                    for (int chaise = 1;chaise <= CHAISES; chaise++) {
                        for (int chaise2 = 1; chaise2 <= CHAISES; chaise2++) {

                            for (int table2=1 ;table2<=TABLES;table2++) {   //A WOMAN MUST STAY WITH HER HUSBAND..   
                                if(table2==table)
                                    continue;
                                // if(Math.abs(chaise2-chaise)!=CHAISES-1)
                                //     continue;
                                int[] clause2 = {-mapper(table, chaise, femme),-mapper(table2, chaise2, sonMari)};
                                solver.addClause(new VecInt(clause2));
                                // System.out.println(new VecInt(clause) + " means " + femme+ " " + sonMari + " " +homme);
                                nbClauses++;
                            }

                            if(!(Math.abs(chaise2-chaise)==1||Math.abs(chaise2-chaise)==CHAISES-1))
                            continue;
                            
                                for(int homme : HOMME){
                                    if(sonMari!=homme ){
                                        for (int chaise3 = 1; chaise3 <= CHAISES; chaise3++) {
                                            if(!(Math.abs(chaise3-chaise)==1||Math.abs(chaise2-chaise)==CHAISES-1)||(chaise3==chaise2))
                                            continue;
                                            
                                            int[] clause = {-mapper(table, chaise, femme),mapper(table, chaise2, sonMari),-mapper(table, chaise3, homme)};
                                            solver.addClause(new VecInt(clause));
                                            // System.out.println(new VecInt(clause) + " means " + femme+ " " + sonMari + " " +homme);
                                            nbClauses++;

                                        }
                                    }
                                }
                                
                                ArrayList<Integer> atLeastClause=new ArrayList<>();
                                atLeastClause.add(-mapper(table, chaise, femme));
                                atLeastClause.add(-mapper(table, chaise2, sonMari));
                                for(int femme2 : FEMME){    //couples stick together..
                                    if(femme!=femme2 ){
                                        for (int chaise3 = 1; chaise3 <= CHAISES; chaise3++) {
                                            if(!(Math.abs(chaise3-chaise)==1||Math.abs(chaise2-chaise)==CHAISES-1)||(chaise3==chaise2))
                                            continue;
                                            atLeastClause.add(mapper(table, chaise3,femme2));
                                        }
                                    }
                                }
                                solver.addClause(new VecInt(atLeastClause.stream().mapToInt(i->i).toArray()));
                                nbClauses++;


                                

                            }
                        }
                    }
                    
                }


            }
            

        //System.out.println(nbClauses);

        solver.setExpectedNumberOfClauses(nbClauses);
        // we are done. Working now on the IProblem interface
        IProblem problem = solver;
        
        Reader reader = new DimacsReader(solver); // needed to decode the obtained result
        
        try {
            if (problem.isSatisfiable()) {
                System.out.println("Satisfiable !");
                String output=reader.decode(problem.model());
                
                // System.out.println(output);
                

                StringTokenizer headerTokens=new StringTokenizer(output," ");
                output="";
                int value = Integer.parseInt(headerTokens.nextToken());
                while(value!=0){
                    if(value>0){
                        int table = (value-1)/(CHAISES*INVITES);
                        // System.out.println(value);
                        int chaise= ((value-1)%(CHAISES*INVITES))/INVITES;
                        int invite= (value-table*CHAISES*INVITES-chaise*INVITES);
                        output+="Table "+(table+1)+" Chaise "+(chaise+1) +" Invité "+ invite+"\n";
                        System.out.println("Table "+(table+1)+" Chaise "+(chaise+1) +" Invité "+ invite );
                    }
                    value = Integer.parseInt(headerTokens.nextToken());
                }
                GuiImpl.displayResult(output+"\n");
                
                // System.out.println(reader.decode(problem.model())); // Print a model satisfiying the problem
                
            } else {
                System.out.println("Unsatisfiable !");
                GuiImpl.displayResult("Unsatisfiable !");
            }
        } catch (TimeoutException e) {
            System.out.println("Timeout, sorry!");
            GuiImpl.displayResult("Timeout, sorry!");
        }    
        
    }

    public static int mapper(int table, int chaise, int invi ){
        return (table-1)*CHAISES*INVITES+(chaise-1)*INVITES+invi;
    }



    
    public static void FromFile() throws ParseFormatException, IOException
    {
        
        ISolver solver = org.sat4j.minisat.SolverFactory.newDefault();
        solver.setTimeout(3600); // 1 hour timeout
        Reader reader = new DimacsReader(solver);
        
        try {
            IProblem problem = reader.parseInstance(
                Guest_Affecting_to_Tables_SAT.class.getClassLoader().getResourceAsStream("resources/test.cnf")
            ) ;
            if (problem.isSatisfiable()) {
                System.out.println("Satisfiable !");
                System.out.println(reader.decode(problem.model()));
            } else {
                System.out.println("Unsatisfiable !");
            }
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            System.out.println("FileNotFoundException ");
        } catch (ParseFormatException | IOException e) {
            // TODO Auto-generated catch block
            System.out.println("ParseFormatException or IOException");
        } // TODO Auto-generated catch block
        catch (ContradictionException e) {
            System.out.println("Unsatisfiable (trivial)!");
        } catch (TimeoutException e) {
            System.out.println("Timeout, sorry!");
        }
    }

    
    
    
    
}
