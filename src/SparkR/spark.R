
# Set the system environment variables
Sys.setenv(SPARK_HOME = "C:\\spark-1.5.2-bin-hadoop2.6")
.libPaths(c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib"), .libPaths()))

#load the Sparkr library
require(SparkR)

# Create a spark context and a SQL context
sc <- sparkR.init(master = "local")
sqlContext <- sparkRSQL.init(sc)

#### Create a sparkR DataFrame from a R DataFrame ####
exercise.df <- data.frame(name=c("John", "Smith", "Sarah"), age=c(19, 23, 18)) # a R_dataFrame
exercise.df
spark.df <- createDataFrame(sqlContext, exercise.df) # convert R_dataFrame to spark_sql_dataFrame
head(spark.df)
printSchema(spark.df) # print out the spark_sql_dataFrame's schema
class(spark.df)

# transform Spark DataFrame back to R DataFrame 
r.df <- collect(spark.df)
class(r.df)

# Running SQL Queries from SparkR
registerTempTable(spark.df, "test")
sql_result <- sql(sqlContext, "SELECT name FROM test WHERE age > 19 AND age < 24")
head(sql_result)

#### DataFrame Operations ####
head(faithful)
spark.df <- createDataFrame(sqlContext, faithful)

# Select only the "eruptions" column
head(select(spark.df, "eruptions"))
# Filter the DataFrame to only retain rows with wait times shorter than 50 mins
head(filter(spark.df, spark.df$waiting < 50))
# Convert waiting time from hours to seconds.
spark.df$waiting_secs <- spark.df$waiting * 60
head(spark.df)
# aggregation
waiting_freq <- summarize(groupBy(spark.df, spark.df$waiting), count = n(spark.df$waiting))
head(waiting_freq) 
# sort
sort_waiting_freq <- arrange(waiting_freq, desc(waiting_freq$count))
head(sort_waiting_freq)


#### Modeling ####

# Create the DataFrame
df <- createDataFrame(sqlContext, iris)

# Fit a linear model over the dataset.
model <- glm(Sepal_Length ~ Sepal_Width + Species, data = df, family = "gaussian")

# Model coefficients are returned in a similar format to R's native glm().
summary(model)

# Make predictions based on the model.
predictions <- predict(model, newData = df)
head(select(predictions, "Sepal_Length", "prediction"))


#### Stop the SparkContext ####
sparkR.stop()

