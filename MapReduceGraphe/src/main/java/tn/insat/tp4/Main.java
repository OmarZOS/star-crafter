package tn.insat.tp4;

import org.apache.commons.io.FileUtils;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Counter;
import org.apache.hadoop.mapreduce.Counters;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

import java.io.File;
import java.io.IOException;


public class Main {


    public enum WCP {
        nb_cities,
        nb_pop,
        total_pop;
    };


    public static void main(String[] args) throws Exception {
        //Main.histoTask(args);
        // Main.FilteringTask(args);
        Main.bigHisto(args);

    }

    public static void bigHisto(String[] args) throws IOException, ClassNotFoundException, InterruptedException {

        FileUtils.deleteDirectory(new File(("src/main/resources/output")));
        Configuration conf = new Configuration();
        if(args.length>2)
            conf.setInt("LogParameter",Integer.parseInt(args[2]));
        else
            conf.setInt("LogParameter",10);
        //int iterations = 2;
        Path inPath = new Path(args[0]);
        Path outPath = null;

        //for (int i = 0; i<4 ; ++i) {
        //System.out.println("this is the "+i+" iterati_________________________");
        outPath = new Path(args[1]);
        System.out.println(args[0]);
        Job job = Job.getInstance(conf, "histo");
        job.setJarByClass(Main.class);
        job.setMapperClass(BigHistogramMapper.class);
        job.setCombinerClass(BigHistogramReducer.class);
        job.setReducerClass(BigHistogramReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);
        FileInputFormat.addInputPath(job, inPath);
        FileOutputFormat.setOutputPath(job, outPath);
        job.waitForCompletion(true);

        Counters counters = job.getCounters();
        for (WCP groupName : WCP.values()) {
            Counter counter = counters.findCounter(groupName);
            System.out.println(counter.getDisplayName() + ":\t" + counter.getValue());
        }
    }


    public static void histoTask(String[] args) throws IOException, ClassNotFoundException, InterruptedException {

        FileUtils.deleteDirectory(new File(("src/main/resources/output")));
        Configuration conf = new Configuration();
        if(args.length>2)
            conf.setInt("LogParameter",Integer.parseInt(args[2]));
        else
            conf.setInt("LogParameter",10);
        //int iterations = 2;
        Path inPath = new Path(args[0]);
        Path outPath = null;

        //for (int i = 0; i<4 ; ++i) {
        //System.out.println("this is the "+i+" iterati_________________________");
        outPath = new Path(args[1]);
        System.out.println(args[0]);
        Job job = Job.getInstance(conf, "histo");
        job.setJarByClass(Main.class);
        job.setMapperClass(histMapper.class);
        job.setCombinerClass(histoReducer.class);
        job.setReducerClass(histoReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);
        FileInputFormat.addInputPath(job, inPath);
        FileOutputFormat.setOutputPath(job, outPath);
        job.waitForCompletion(true);

        Counters counters = job.getCounters();
        for (WCP groupName : WCP.values()) {
            Counter counter = counters.findCounter(groupName);
            System.out.println(counter.getDisplayName() + ":\t" + counter.getValue());
        }
    }

    public static void FilteringTask(String[] args) throws IOException, ClassNotFoundException, InterruptedException {
        FileUtils.deleteDirectory(new File(("src/main/resources/output")));
        Configuration conf = new Configuration();
        //int iterations = 2;
        Path inPath = new Path(args[0]);
        Path outPath = null;

        //for (int i = 0; i<4 ; ++i) {
        //System.out.println("this is the "+i+" iterati_________________________");
        outPath = new Path(args[1]);
        //System.out.println(args[1]);
        Job job = Job.getInstance(conf, "filterAndCount");
        job.setJarByClass(Main.class);
        job.setMapperClass(FilterUnknownPopulationMapper.class);
        job.setCombinerClass(Reduce.class);
        job.setReducerClass(Reduce.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);
        FileInputFormat.addInputPath(job, inPath);
        FileOutputFormat.setOutputPath(job, outPath);
        job.waitForCompletion(true);

        Counters counters = job.getCounters();
        for (WCP groupName : WCP.values()) {
            Counter counter = counters.findCounter(groupName);
            System.out.println(counter.getDisplayName() + ":\t" + counter.getValue());
        }


    }
        //System.out.println("Group: " + group.getDisplayName());
        //for (Counter counter : group) {
        //}

    //inPath = outPath;

    //}
    //System.exit(job.waitForCompletion(true) ? 0 : 1);

}
