from pyspark import *
from pyspark.sql import SparkSession
from pyspark.sql.column import Column





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




def top_df_2(df, key_col, K):
    
    num_records = df.count()
    value_at_k_rank = (df
                       .orderBy(functions.col(key_col).desc())
                       .limit(k)
                       .select(functions.min(key_col).alias('min'))
                       .first()['min'])

    return df.filter(df[key_col] >= value_at_k_rank)

sc = SparkContext();

spark = SparkSession \
    .builder \
    .appName("how to read csv file") \
    .getOrCreate()
rddPop = spark.read.csv('worldcitiespop.csv')

cleanRddPops = rddPop.filter(lambda x:(x[4]!=""))

meanRDD = (cleanRddPops
           .mapValues(lambda x: (x, 1))
           .reduceByKey(lambda x, y: (x[0]+y[0], x[1]+y[1]))
           .mapValues(lambda x: x[0]/x[1]))

meanRDD.collect()



varianceRDD = (cleanRddPops\
          .mapValues(lambda x: (1, x, x*x))\
          .reduceByKey(lambda x,y: (x[0]+y[0], x[1]+y[1], x[2]+y[2]))\
          .mapValues(lambda x: (x[2]/x[0] - (x[1]/x[0])**2)))

varianceRDD.collect()




cleanRddPops\
    .select("Population").rdd.map(_.getDouble(0))\
    .histogram(Math.log10(summary.max))


#for the topK
k_value = 10
broadcast_k = sc.broadcast(k_value)
top_k_res = cleanRddPops.takeOrdered(k_value, key=lambda x: -x[1])



# cleanRddPops.topk(10) 

cond = (col(city1.longitude) != col(city2.longitude)) | ((col(city1.latitude) != col(city2.latitude)) )

cleanRddPops.alias("city1").join(cleanRddPops.alias("city2"), \
    cond \
    .select(col("city1.Country"),col("city1.AccentCity"),col("city1.Region"),col("city1.Population"),col("city1.Latitude"),col("city1.Longitude")) )\
   .show(truncate=False)

