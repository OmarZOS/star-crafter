



def select_top_k (it) :
    k = broadcast_k.value
    sorted_res = sorted(it, key=lambda x: x[1], reverse=True)
    top_k_res = [0] * k
    i = 0
    for t in sorted_res:
        top_k_res[i] = t
        i += 1
        if i >= k:
            break
    return top_k_res


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
    
    rdd = sc.mapPartitions(select_top_k)
















