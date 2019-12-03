---
title: "Class 09 Unsupevised Mini Project"
author: "Yasmine Kasiri"
date: "10/29/2019"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

```{r}
wisc.df <- read.csv("WisconsinCancer.csv")
```

```{r}
table(wisc.df$diagnosis)
```

```{r}
wisc.df
```

```{r}
wisc.data <- as.matrix(wisc.df[,3:32])

row.names(wisc.data) <- wisc.df$id
```

```{r}
diagnosis <- wisc.df$diagnosis
```

## Questions
# How many observations?
```{r}
nrow(wisc.df)
```

# How many observations are malignant diagnoses?
```{r}
table(wisc.df$diagnosis)
```

# How many variables/features in the data are suffixed with  _mean?
```{r}
grep("_mean", colnames(wisc.df))
```

```{r}
length(grep("_mean", colnames(wisc.df)))
```

```{r}
round( colMeans(wisc.data), 3)
```

```{r}
round( apply(wisc.data,2,sd), 3)
```

```{r}
wisc.pr <- prcomp((wisc.data), scale = TRUE)
summary(wisc.pr)
```


Color by cancer/non-cancer
```{r}
plot(wisc.pr$x[,1], wisc.pr$x[,2], col = diagnosis, pch=)
```

# Q1 is 44, Q2 is PC3, Q3 is PC7

```{r}
# Scale the wisc.data data: data.scaled
data.scaled <- scale(wisc.data)
data.dist <- dist(data.scaled)
```

```{r}
wisc.hclust <- hclust(data.dist)
```

```{r}
wisc.hclust
```

```{r}
plot(wisc.hclust)
abline(h = 18, col="red", lty=2)
```

```{r}
wisc.hclust.clusters <- cutree(wisc.hclust, k = 4)
```

```{r}
table(wisc.hclust.clusters, diagnosis)
```


## Section 4: Kmeans
```{r}
wisc.km <- kmeans(wisc.data, centers= 2, nstart= 20)
```

```{r}
table(wisc.km$cluster, diagnosis)
```

```{r}
table(wisc.km$cluster, wisc.hclust.clusters)
```

```{r}
data2.dist <- dist(wisc.pr$x[,1:7])
```


```{r}
wisc.pr.hclust <- hclust(data2.dist, method="ward.D2")
```


```{r}
grps <- cutree(wisc.pr.hclust, k=2)
table(grps)
```

```{r}
plot(wisc.pr$x[,1:7], col=diagnosis)
```

```{r}
plot(wisc.pr.hclust)
abline(h = 25, col="red", lty=2)
```

```{r}
grps <- cutree(wisc.pr.hclust, k=2)
table(grps)
```

```{r}
table(grps, diagnosis)
```

## Predictions Section

```{r}
#url <- "new_samples.csv"
url <- "https://tinyurl.com/new-samples-CSV"
new <- read.csv(url)
npc <- predict(wisc.pr, newdata=new)
npc
```

```{r}
plot(wisc.pr$x[,1:2], col=diagnosis)
points(npc[,1], npc[,2], col="blue", pch=16, cex=3)
text(npc[,1], npc[,2], c(1,2), col="white")
```

```{r}
nrow(new)
```

