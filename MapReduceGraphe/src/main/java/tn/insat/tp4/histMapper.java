package tn.insat.tp4;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import java.io.IOException;

public class histMapper extends Mapper<Object, Text, Text, IntWritable> {

    static int logBase = 10;
    @Override
    protected void setup(Context context) throws IOException, InterruptedException {
        Configuration conf = context.getConfiguration();
        logBase=conf.getInt("LogParameter",10);
    }

    public void map(Object key, Text value, Context context)
            throws IOException, InterruptedException {

        String data = value.toString();
        String[] field = data.split(",", -1);
        String population = field[4];


        if (!population.equals("") && !population.equals("Population") ) {

            context.getCounter(Main.WCP.nb_cities).increment(1);
            context.getCounter(Main.WCP.nb_pop).increment(1);
            context.getCounter(Main.WCP.total_pop).increment(Integer.parseInt(population));

            //I think this should be better than multiplications..
            int x = (int)(Math.log(Integer.parseInt(population))/Math.log(logBase));
            String keey= "1";
            for (int i = 0; i <x ; i++) {
                keey+="0";
            }
            context.write(new Text(keey),new IntWritable(1) );

        }

        //context.write(word, one);
    }

}
