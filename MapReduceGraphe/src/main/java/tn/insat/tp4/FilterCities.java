package tn.insat.tp4;
/**
 * @author David Auber
 * @date 07/10/2016
 * Maître de conférencces HDR
 * LaBRI: Université de Bordeaux
 */

import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

public class FilterCities extends Configured implements Tool {

    public static class CitiesWithPopMapper	extends Mapper<LongWritable, Text, Text, IntWritable> {
        public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
            if (key.get() == 0 ) return;
            String tokens[] = value.toString().split(",");
            context.getCounter("Pop analysis", "number of lines").increment(1);
            if (tokens.length < 7 || tokens[4].length()==0) return;
            context.getCounter("Pop analysis", "number of given values").increment(1);
            int pop = 0;
            try {
                pop = Integer.parseInt(tokens[4]);
            }
            catch(Exception e) {
                return;
            }
            context.getCounter("Pop analysis", "sum of values").increment(pop);
            Text word = new Text();
            word.set(tokens[1] + "," + tokens[5] + "," + tokens[6]);
            context.write(word, new IntWritable(pop));
        }
    }

    public static class MaxReduce extends Reducer<Text,IntWritable,Text,IntWritable> {
        public void reduce(Text key, Iterable<IntWritable> values,Context context) throws IOException, InterruptedException {
            int max = 0;
            for (IntWritable val : values) {
                if (val.get() > max) {
                    max = val.get();
                }
            }
            context.write(key, new IntWritable(max));
        }
    }

    public int run(String args[]) throws IOException, ClassNotFoundException, InterruptedException {
        Configuration conf = getConf();
        Job job = Job.getInstance(conf, "Clean population");
        job.setJarByClass(FilterCities.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);
        job.setOutputFormatClass(TextOutputFormat.class);
        job.setInputFormatClass(TextInputFormat.class);
        try {
            FileInputFormat.addInputPath(job, new Path(args[0]));
            FileOutputFormat.setOutputPath(job, new Path(args[1]));
        }
        catch (Exception e) {
            System.out.println(" bad arguments, waiting for 2 arguments [inputURI] [outputURI]");
            return -1;
        }
        job.setMapperClass(CitiesWithPopMapper.class);
        job.setReducerClass(MaxReduce.class);
        return job.waitForCompletion(true) ? 0 : 1;
    }

    public static void main(String args[]) throws Exception {
        System.exit(ToolRunner.run(new FilterCities(), args));
    }

}
