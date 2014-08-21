library(rmr2)

##  sumup
wordcount = function(input,output = NULL){
    ## sumup-map
    wc.map = function(., row) {
        k = row$mpg 
        keyval(row$gear, k)}
    ##  sumup-reduce
    wc.reduce =
      function(word, val ) {
        keyval(word, sum(val))}
    ##  sumup-sumup
    mapreduce(
      input = input,
      output = output,
      map = wc.map,
      reduce = wc.reduce
	)}

rmr.options(backend = 'local')
out = from.dfs(wordcount(to.dfs(keyval(NULL, mtcars))))
out