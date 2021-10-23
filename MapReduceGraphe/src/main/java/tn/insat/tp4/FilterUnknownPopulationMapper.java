package tn.insat.tp4;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import java.io.IOException;
import java.util.ArrayList;



public class FilterUnknownPopulationMapper
        extends Mapper<Object, Text, Text, Text>{


    public void map(Object key, Text value, Context context)
            throws IOException, InterruptedException {

        String data = value.toString();
        String[] field = data.split(",", -1);
        String population = field[4];
        context.getCounter(Main.WCP.nb_cities).increment(1);

        if (!population.equals("")) {

            context.getCounter(Main.WCP.nb_pop).increment(1);
            context.getCounter(Main.WCP.total_pop).increment(Integer.parseInt(population));

            context.write(value,new Text(""));
        }

        //context.write(word, one);
    }
}