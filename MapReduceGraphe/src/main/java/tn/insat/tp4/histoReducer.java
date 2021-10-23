package tn.insat.tp4;

import com.google.common.collect.Iterables;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;
import java.io.IOException;

public class histoReducer extends Reducer<Text,IntWritable,Text,IntWritable> {
    public void reduce(Text key, Iterable<IntWritable> values, Context context
    ) throws IOException, InterruptedException {

        int x=0;

        for (IntWritable val:values) {
            x+=val.get();
        }
        context.write(key, new IntWritable(x));

    }
}
