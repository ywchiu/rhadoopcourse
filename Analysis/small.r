
rmr.options(backend = 'local')
small.ints = to.dfs(1:10)
mapr = mapreduce(input = small.ints, 
        map = function(k,v) cbind(v,v^2)) 
result = from.dfs(mapr)
result
