/**
 * @author David Auber
 * @date 07/10/2016
 * Maître de conférencces HDR
 * LaBRI: Université de Bordeaux
 */
package tn.insat.tp4;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import java.util.Iterator;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.Writable;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

public class ResumeCities extends Configured implements Tool {


    public static class CityResume implements Writable, Cloneable {

        long min, max, count, sum;
        public CityResume() {}

        public CityResume(long pop) {
            sum = max = min = pop;
            count = 1;
        }

        public CityResume clone() {
            try {
                return (CityResume)super.clone();
            }
            catch (Exception e) {
                System.err.println(e.getStackTrace());
                System.exit(-1);
            }
            return null;
        }

        void merge(CityResume city) {
            min = Math.min(min, city.min);
            max = Math.max(max, city.max);
            count += city.count;
            sum += city.sum;
        }

        public void write(DataOutput out) throws IOException {
            out.writeLong(min);
            out.writeLong(max);
            out.writeLong(sum);
            out.writeLong(count);
        }

        public void readFields(DataInput in) throws IOException {
            min   = in.readLong();
            max   = in.readLong();
            sum   = in.readLong();
            count = in.readLong();
        }

        public String toString() {
            StringBuilder tmp = new StringBuilder();
            tmp.append(count);
            tmp.append(",");
            tmp.append(min);
            tmp.append(",");
            tmp.append(max);
            tmp.append(",");
            tmp.append((double)sum/(double)count);
            return tmp.toString();
        }
    }

    public static class ResumeMapper	  extends Mapper<Object, Text, IntWritable, CityResume> {
        public int nb_step = 0;

        public void setup(Context context) {
            Configuration conf = context.getConfiguration();
            nb_step = conf.getInt("steps", 10);
        }

        public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
            String tokens[] = value.toString().split(",");
            if (tokens.length < 7 || tokens[4].length()==0) return;
            int pop = 0;
            try {
                pop = Integer.parseInt(tokens[4]);
            }
            catch(Exception e) {
                return;
            }
            int bin = (int)Math.floor(Math.log10(pop)*(double)nb_step);
            context.write(new IntWritable(bin), new CityResume(pop));
        }
    }

    public static class ResumeCombiner extends Reducer<IntWritable, CityResume, IntWritable, CityResume> {
        public static CityResume merge(Iterable<CityResume> values) {
            CityResume resume = null;
            Iterator<CityResume> it= values.iterator();
            if (it.hasNext())  {
                resume = it.next().clone();
                while(it.hasNext()) resume.merge(it.next());
            }
            return resume;
        }

        public void reduce(IntWritable key, Iterable<CityResume> values,Context context) throws IOException, InterruptedException {
            CityResume resume = merge(values);
            if (resume != null) context.write(key, resume);
        }
    }

    public static class ResumeReducer   extends Reducer<IntWritable, CityResume, Text, Text> {
        public int nb_step = 0;
        public void setup(Context context) {
            Configuration conf = context.getConfiguration();
            nb_step = conf.getInt("steps", 10);
        }
        public void reduce(IntWritable key, Iterable<CityResume> values,Context context) throws IOException, InterruptedException {
            CityResume resume = ResumeCombiner.merge(values);
            int val = (int)Math.pow(10, key.get()/(double)nb_step);
            StringBuffer b = new StringBuffer();
            b.append(val);
            context.write(new Text(b.toString()), new Text(resume.toString()));
        }
    }

    public int run(String args[]) throws IOException, ClassNotFoundException, InterruptedException {
        Configuration conf = getConf();
        Job job = Job.getInstance(conf, "Resume population");
        job.setJarByClass(FilterCities.class);

        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);
        job.setOutputFormatClass(TextOutputFormat.class);
        job.setInputFormatClass(TextInputFormat.class);
        job.setNumReduceTasks(1);

        try {
            FileInputFormat.addInputPath(job, new Path(args[0]));
            FileOutputFormat.setOutputPath(job, new Path(args[1]));
            conf.setInt("steps", Integer.parseInt(args[2]));
        }
        catch (Exception e) {
            System.out.println(" bad arguments, waiting for 3 arguments [inputURI] [outputURI][NB_STEPS");
            return -1;
        }

        job.setMapperClass(ResumeMapper.class);
        job.setMapOutputKeyClass(IntWritable.class);
        job.setMapOutputValueClass(CityResume.class);
        job.setCombinerClass(ResumeCombiner.class);
        job.setReducerClass(ResumeReducer.class);
        return job.waitForCompletion(true) ? 0 : 1;
    }

    public static void main(String args[]) throws Exception {
        System.exit(ToolRunner.run(new ResumeCities(), args));
    }

}
