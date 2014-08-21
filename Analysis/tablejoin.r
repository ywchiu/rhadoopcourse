library(rmr2)

##  tablejoin
tablejoin = function(input,output = NULL){
  ## tablejoin-map
  wc.map = function(., row) {
    keyval(row[1], row)
  }
  ##  tablejoin-reduce
  wc.reduce =
    function(word, val ) {
      keyval(word,data.frame(left = val[1,], right = val[2,]))
      }
  ##  tablejoin-mapreduce
  mapreduce(
    input = input,
    output = output,
    map = wc.map,
    reduce = wc.reduce,
    combine = TRUE)}

rmr.options(backend = 'local')
rv = to.dfs(keyval(NULL, cbind(reviews[1:3,], "rv")))
sl = to.dfs(keyval(NULL, cbind(solutions[1:3,], "sl")))
out = from.dfs(tablejoin(c(rv,sl)))
out