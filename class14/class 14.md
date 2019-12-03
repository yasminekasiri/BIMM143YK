---
title: "class14"
author: "Yasmine Kasiri"
date: "11/12/2019"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

# read these count data and metadata files. Input Dataset
```{r}
counts <- read.csv("data/airway_scaledcounts.csv", stringsAsFactors = FALSE)
```

```{r}
metadata <-  read.csv("data/airway_metadata.csv", stringsAsFactors = FALSE)
```

```{r}
head(counts)
head(metadata)
```

## look at nrow of counts data to see how many genes
```{r}
nrow(counts)
```

## now look at columns of counts data to see how many experiments there are
```{r}
ncol(counts)
```

```{r}
nrow(metadata)
ncol(metadata)
```

we want to know if there is a difference in expression values for controls (non-drug) vs drug treatments (drug added cell lines)

First step is to find which expts were control and then get the average calues across all control expts. Then we will do the same for drug treated

```{r}
control <- metadata[metadata[,"dex"]=="control",]
control$id
```

Now calculate the mean values across these control columns of **countdata**

```{r}
control.mean <- rowSums(counts[,control$id])/length(control$id)
names(control.mean) <- counts$ensgene
```

Now for the treated
```{r}
treated <- metadata[metadata[,"dex"]=="treated",]
treated$id
```

```{r}
treated.mean <- rowSums(counts[,treated$id])/length(treated$id)
names(treated.mean) <- counts$ensgene
```

We will combine our meancount data for bookkeeping purposes.
```{r}
meancounts <- data.frame(control.mean, treated.mean)
```

PLot control vs treated!
```{r}
plot(meancounts$control.mean, meancounts$treated.mean, log = "xy", xlab = "Control Mean", ylab = "Treated Mean")
```

```{r}
meancounts$log2fc <- log2(meancounts[,"treated.mean"]/meancounts[,"control.mean"])
head(meancounts)
```


```{r}
zero.vals <- which(meancounts[,1:2]==0, arr.ind=TRUE)

to.rm <- unique(zero.vals[,1])
mycounts <- meancounts[-to.rm,]
head(mycounts)
```

see how many genes are up or down-regulated.
```{r}
up.ind <- mycounts$log2fc > 2
down.ind <- mycounts$log2fc < (-2)
```

```{r}
sum(up.ind)
sum(down.ind)
```


```{r}
library(DESeq2)
```

```{r}
dds <- DESeqDataSetFromMatrix(countData=counts, 
                              colData=metadata, 
                              design=~dex, 
                              tidy=TRUE)
dds
```

Run DESeq2
```{r}
dds <- DESeq(dds)
```



Get the results
```{r}
res <- results(dds)
res
```

```{r}
summary(res)
```

```{r}
resOrdered <- res[order(res$pvalue),]
res05 <- results(dds, alpha=0.05)
summary(res05)
```

```{r}
resSig05 <- subset(as.data.frame(res), padj < 0.05)
nrow(resSig05)
```

Volcano plot. Annotation. Save results.

## Summary Plot: aka Volcano PLot

This figure will combine both fold change and the p-value into one overview figure indicating the proportion of genes with large scale significant differences in their expression

```{r}
mycols <- rep("gray", nrow(res))

# make points below p value cutoff red
mycols[ abs(res$log2FoldChange) > 2 ]  <- "red" 

# make points within -2 to 2 fold change blue
inds <- (res$padj < 0.01) & (abs(res$log2FoldChange) > 2 )
mycols[ inds ] <- "blue"

plot(res$log2FoldChange, -log(res$padj), col=mycols)
abline(v = c(-2, 2), col = "black", lty = 2)
abline(h = -log(0.05), col = "black", lty = 2)
```


Save our results
```{r}
write.csv(res, file="expression_results.csv")
```




