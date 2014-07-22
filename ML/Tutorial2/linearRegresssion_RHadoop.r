library(rmr2)
rmr.options(backend = 'local')
## Load Matrix Data
X = matrix(rnorm(200), ncol = 5)
X.index = to.dfs(cbind(1:nrow(X), X))
y = as.matrix(rnorm(40))

## Function defined to be used as reducers 
Sum =
  function(., YY)
    keyval(1, list(Reduce('+', YY)))

## Calculating the Xtx value with MapReduce job1
XtX =
  values(
    from.dfs(
      mapreduce(
        input = X.index,
        map =
          function(., Xi) {
            Xi = Xi[,-1]
            keyval(1, list(t(Xi) %*% Xi))},
        reduce = Sum,
        combine = TRUE)))[[1]]

## Calculating the Xtx value with MapReduce job2
Xty =
  values(
    from.dfs(
      mapreduce(
        input = X.index,
        map = function(., Xi) {
          yi = y[Xi[,1],]
          Xi = Xi[,-1]
          keyval(1, list(t(Xi) %*% yi))},
        reduce = Sum,
        combine = TRUE)))[[1]]
## Deriving the coefficient values with Solve (Xtx, Xty).
solve(XtX, Xty)