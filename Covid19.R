library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")

filePath <- "https://biotechmagazineandnews.com/covid-19-cientificos-confirman-que-su-origen-es-natural/"

text <- readLines(filePath)

docs <- Corpus(VectorSource(text))

inspect(docs)

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x
))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")



docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)

docs <- tm_map(docs, removeWords, stopwords("english"))

docs <- tm_map(docs, stripWhitespace)

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35,
          colors=brewer.pal(8, "Dark2"))

