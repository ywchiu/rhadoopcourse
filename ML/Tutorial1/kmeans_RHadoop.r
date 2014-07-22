library(rmr2)

## kmeans
kmeans.mr =
  function(
    P,
    num.clusters,
    num.iter,
    combine,
    in.memory.combine) {
## distance function
    dist.fun =
      function(C, P) {
        apply(
          C,
          1,
          function(x)
            colSums((t(P) - x)^2))}
## mapper function
    kmeans.map =
      function(., P) {
        nearest = {
          if(is.null(C))
            sample(
              1:num.clusters,
              nrow(P),
              replace = TRUE)
          else {
            D = dist.fun(C, P)
            nearest = max.col(-D)}}
        if(!(combine || in.memory.combine))
          keyval(nearest, P)
        else
          keyval(nearest, cbind(1, P))}
## reducer function
    kmeans.reduce = {
      if (!(combine || in.memory.combine) )
        function(., P)
          t(as.matrix(apply(P, 2, mean)))
      else
        function(k, P)
          keyval(
            k,
            t(as.matrix(apply(P, 2, sum))))}
## kmeans-main-1  
    C = NULL
    for(i in 1:num.iter ) {
      C =
        values(
          from.dfs(
            mapreduce(
              P,
              map = kmeans.map,
              reduce = kmeans.reduce)))
      if(combine || in.memory.combine)
        C = C[, -1]/C[, 1]
## kmeans-main-2
      if(nrow(C) < num.clusters) {
        C =
          rbind(
            C,
            matrix(
              rnorm(
                (num.clusters -
                   nrow(C)) * nrow(C)),
              ncol = nrow(C)) %*% C) }}
        C}
out = list()
rmr.options(backend = "local")
data(iris)
## iris-data
P = as.matrix(iris[,-5])
## @knitr end
#  x11()
#  plot(P)
#  points(P)
  out[['local']] =
## kmeans-run    
    kmeans.mr(
      to.dfs(P),
      num.clusters = 3,
      num.iter = 3,
      combine = FALSE,
      in.memory.combine = FALSE)
out		