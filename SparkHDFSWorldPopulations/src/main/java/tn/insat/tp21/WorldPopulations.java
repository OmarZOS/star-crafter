package tn.insat.tp21;
import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import scala.Tuple2;

import java.util.Arrays;

import static jersey.repackaged.com.google.common.base.Preconditions.checkArgument;
public class WorldPopulations {
    private static final Logger LOGGER = LoggerFactory.getLogger(WorldPopulations.class);

    public static void main(String[] args) {
        checkArgument(args.length > 1, "Please provide the path of input file and output dir as parameters.");
        new WorldPopulations().run(args[0], args[1]);
    }

    public void run(String inputFilePath, String outputDir) {
        String master = "local[*]";
        SparkConf conf = new SparkConf()
                .setAppName(WorldPopulations.class.getName())
                .setMaster(master);
        JavaSparkContext sc = new JavaSparkContext(conf);

        JavaRDD<String> textFile = sc.textFile(inputFilePath);

        //Ex:01
        System.out.println(textFile.getNumPartitions());
        textFile.coalesce(4);

        JavaPairRDD<String, String> populations = textFile
                .flatMap(s -> Arrays.asList(s.split("\n")).iterator())
                .mapToPair(line -> {
                    String[] fields = line.split(",");
                    String value = (fields[4].equals("")?"-1":fields[4]);
                    return new Tuple2<>(fields[1],value);
                });

        //Ex:02
        populations.reduceByKey((a, b) -> {
                    if(!a.equals(""))
                        if (!b.equals(""))
                            return ((Float.parseFloat(a)>Float.parseFloat(b))?a:b);
                        else
                            return a;
                    else
                        if (!b.equals(""))
                            return b;
                    return "-1";
                });

        populations.filter(t -> (  Float.parseFloat(t._2)>0   ));



        populations.saveAsTextFile(outputDir);
    }
}