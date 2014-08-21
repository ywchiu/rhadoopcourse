library(rmr2)

##  wordcount
wordcount =
  function(
    input,
    output = NULL,
    pattern = " "){
    ## wordcount-map
    wc.map =
      function(., lines) {
        keyval(
          unlist(
            strsplit(
              x = lines,
              split = pattern)),
          1)}
    ##  wordcount-reduce
    wc.reduce =
      function(word, counts ) {
        keyval(word, sum(counts))}
    ##  wordcount-mapreduce
    mapreduce(
      input = input,
      output = output,
      map = wc.map,
      reduce = wc.reduce,
      combine = TRUE)}

text = capture.output(license())
rmr.options(backend = 'local')
out = from.dfs(wordcount(to.dfs(keyval(NULL, text)), pattern = " +"))
out