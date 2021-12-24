





if __name__=="__main__":
    from pyspark import *
    from math import *
    import org.apache.spark.mllib.linalg.Vectors
    import org.apache.spark.mllib.stat.{MultivariateStatisticalSummary, Statistics}

    sc = SparkContext();
    val rddPop = sc.textFile("reduced.csv")
                    // .mapPartitionsWithIndex {//skip the header
                    //         (idx, iter) =>  if (idx == 0) iter.drop(1) 
                    //                         else iter }
                    // })
                    .map(f=>{
                        f.split(",")//split field
                    })

    val cleanRddPops = rddPop.filter($"Population".isNotNull)

    val summary: MultivariateStatisticalSummary = Statistics.colStats(cleanRddPops)
    println(summary.max)
    println(summary.min)
    println(summary.sum)  // column-wise variance
    println(summary.mean)  // a dense vector containing the mean value for each column
    

















