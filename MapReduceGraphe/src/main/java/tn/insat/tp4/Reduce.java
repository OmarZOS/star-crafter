package tn.insat.tp4;


import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

import java.io.IOException;

public class Reduce
        extends Reducer<Text,Text,Text,Text> {

    public void reduce(Text key, Iterable<Text> values, Context context
    ) throws IOException, InterruptedException {

        context.write(new Text(key.toString()), new Text(""));
    }

    int colorWeight(String color) {
        if (color.equals("BLANC")) {
            return 0;
        } else {
            if (color.equals("GRIS")) {
                return 1;
            } else {
                return 2;
            }
        }
    }
}