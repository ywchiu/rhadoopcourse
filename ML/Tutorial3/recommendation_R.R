# Quote plyr package
library (plyr)

# Read data set
train <-read.csv (file = "small.csv", header = FALSE)
names (train) <-c ("user", "item", "pref") 

# Calculated User Lists
usersUnique <-function () {
  users <-unique (train $ user)
  users [order (users)]
}

# Calculation Method Product List
itemsUnique <-function () {
  items <-unique (train $ item)
  items [order (items)]
}

# User Lists
users <-usersUnique () 

# Product List
items <-itemsUnique () 


# Establish Product List Index
index <-function (x) which (items %in% x)
data<-ddply(train,.(user,item,pref),summarize,idx=index(item)) 

# Co-occurrence matrix
cooccurrence <-function (data) {
  n <-length (items)
  co <-matrix (rep (0, n * n), nrow = n)
  for (u in users) {
    idx <-index (data $ item [which(data$user == u)])
    m <-merge (idx, idx)
    for (i in 1: nrow (m)) {
      co [m$x[i], m$y[i]] = co[m$x[i], m$y[i]]+1
    }
  }
  return (co)
}

# Generate co-occurrence matrix
co <-cooccurrence (data) 


# Recommendation algorithm
recommend <-function (udata = udata, co = coMatrix, num = 0) {
  n <- length(items)
  
  # All of pref
  pref <- rep (0, n)
  pref[udata$idx] <-udata$pref
  
  # User Rating Matrix
  userx <- matrix(pref, nrow = n)
  
  # Scoring matrix co-occurrence matrix *
  r <- co %*% userx
  
  # Recommended Sort
  r[udata$idx] <-0
  idx <-order(r, decreasing = TRUE)
  topn <-data.frame (user = rep(udata$user[1], length(idx)), item = items[idx], val = r[idx])

  # Recommended results take months before the num
  if (num> 0) {
    topn <-head (topn, num)
  }

  # Recommended results take months before the num
  if (num> 0) {
    topn <-head (topn, num)
  }

  # Back to results 
  return (topn)
}

# initializing dataframe for recommendations storage
recommendation<-data.frame()

# Generating recommendations for all of the users
for(i in 1:length(users)){
  udata<-data[which(data$user==users[i]),]
  recommendation<-rbind(recommendation,recommend(udata,co,0)) 
}
