package tn.insat.tp21;
import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaDoubleRDD;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;

import org.apache.spark.api.java.function.Function;
import org.apache.spark.util.StatCounter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import scala.Option;
import scala.Tuple2;


import java.io.File;
import java.util.Arrays;
import java.util.Locale;

import static jersey.repackaged.com.google.common.base.Preconditions.checkArgument;
public class WorldPopulations {
    private static final Logger LOGGER = LoggerFactory.getLogger(WorldPopulations.class);

    public static void main(String[] args) {
        checkArgument(args.length > 1, "Please provide the path of input file and output dir as parameters.");

        //delete output directory if it exists
        deleteDirectory(new File(args[1]));

        new WorldPopulations().run(args[0], args[1],args[2],args[3]);
    }

    public void run(String inputFilePath, String outputDir,String joinFilePath,String masterAdress) {
        String master = masterAdress;
        SparkConf conf = new SparkConf()
                .setAppName(WorldPopulations.class.getName())
                .setMaster(master);
        JavaSparkContext sc = new JavaSparkContext(conf);

        JavaRDD<String> textFile = sc.textFile(inputFilePath);

        //Ex:01----------------------------------------
        System.out.println(textFile.getNumPartitions());
        textFile.coalesce(4);
        //---------------------------------------------

        JavaPairRDD<String, Float> populations = textFile
                .flatMap(s -> Arrays.asList(s.split("\n")).iterator())
                .mapToPair(line -> {
                    String[] fields = line.split(",");
                    Float value = (fields[4].equals("")||fields[4].equals("Population")?-1:Float.parseFloat(fields[4]));
                    return new Tuple2<>(fields[0].toLowerCase(),value);
                });

        //Ex:02-----------------------------------------
        populations.reduceByKey((a, b) -> {

                    if(!a.equals(-1))
                        if (!b.equals(-1))
                            return ((a>b)?a:b);
                        else
                            return a;
                    else
                        if (!b.equals((-1)))
                            return b;
                    return ((float) -1);
                });

        JavaPairRDD<String, Float> cleanPopulations = populations.filter(t -> t._2 > 0);
        //---------------------------------------------


        //Ex:03-----------------------------------------
        StatCounter statistics = cleanPopulations.mapToDouble(t -> t._2)
                                            .stats();
        System.out.println(statistics);
        //---------------------------------------------

        //Ex:04-----------------------------------------
        JavaDoubleRDD example = cleanPopulations.mapToDouble(y -> y._2/statistics.count());
        Tuple2<double[], long[]> newResults = example.histogram((int) Math.log10(statistics.max()));

        System.out.println(newResults);
        //---------------------------------------------


        //Ex:05-----------------------------------------
        JavaRDD<String> joinFile = sc.textFile(joinFilePath);
        textFile.coalesce(4);
        JavaPairRDD<String, String> regions = joinFile
                .flatMap(s -> Arrays.asList(s.split("\n")).iterator())
                .mapToPair(line -> {
                    String[] fields = line.split(",");
                    String value =fields[2];
                    return new Tuple2<>(fields[0],value);
                });

        JavaPairRDD<String, String> cleanedRegions = regions.filter(t->(!t._1.equals("")&&!t._2.equals("")));

        JavaPairRDD<String, Tuple2<String, Float>> regionCities = cleanedRegions.join(cleanPopulations);
        //---------------------------------------------

        //cleanPopulations.saveAsTextFile(outputDir);
        regionCities.saveAsTextFile(outputDir);
    }
    public static boolean deleteDirectory(File directoryToBeDeleted) {
        File[] allContents = directoryToBeDeleted.listFiles();
        if (allContents != null) {
            for (File file : allContents) {
                deleteDirectory(file);
            }
        }
        return directoryToBeDeleted.delete();
    }



}