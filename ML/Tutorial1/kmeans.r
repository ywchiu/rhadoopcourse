# Loading iris flower dataset
data("iris")
# generating clusters for iris dataset
kmeans <- kmeans(iris[, -5], 3, iter.max = 1000)
# comparing iris Species with generated cluster points
Comp <- table(iris[, 5], kmeans$cluster)
Comp