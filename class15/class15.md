---
title: "class 15: Pathway Analysis from RNA-Seq Results"
author: "Yasmine Kasiri"
date: "11/14/2019"
output: github_document
---

Trapnell C, Hendrickson DG, Sauvageau M, Goff L et al. "Differential analysis of gene regulation at transcript resolution with RNA-seq". Nat Biotechnol 2013 Jan;31(1):46-53. PMID: 23222703

```{r}
library(DESeq2)
```


```{r}
metaFile <- "data/GSE37704_metadata.csv"
countFile <- "data/GSE37704_featurecounts.csv"
```

```{r}
# Import metadata and take a peak
colData = read.csv(metaFile, row.names=1)
head(colData)
```


```{r}
# Import countdata
countData = read.csv(countFile, row.names=1)
head(countData)
```

```{r}
countData <- as.matrix(countData[,-1])
head(countData)
```

```{r}
colnames(countData)
rownames(colData)
```

```{r}
all (colnames(countData) == rownames(colData))
```

## Remove zero count genes
We want to remove genes that have a zero count value in all the experiments ( ie: rows that have zero across all cols)

```{r}
# Filter count data where you have 0 read count across all samples.
countData <- countData[ rowSums(countData) != 0, ]
head(countData)
```

# DESeq analysis

```{r}
library(DESeq2)
```

# Set up the object with our data in the way DESeq wants it
```{r}
dds = DESeqDataSetFromMatrix(countData=countData,
                             colData=colData,
                             design=~condition)

# Run the analysis
dds = DESeq(dds)
```

Get our results

```{r}
res = results(dds)
res
```

```{r}
plot(res$log2FoldChange, -log(res$padj))
```


```{r}
# Make a color vector for all genes
mycols <- rep("gray", length(res$padj) )
mycols [ res$padj > 0.005] <- "gray"
# Color red the genes with absolute fold change above 2
mycols[ abs(res$log2FoldChange) > 2 ] <- "blue"

plot(res$log2FoldChange, -log(res$padj), col = mycols)
```

```{r}
library("AnnotationDbi")
library("org.Hs.eg.db")

columns(org.Hs.eg.db)
```

```{r}
res$symbol = mapIds(org.Hs.eg.db,
                    keys=row.names(countData), # where are my IDS
                    keytype="ENSEMBL", #what format are my IDs
                    column="SYMBOL", #the new format I want
                    multiVals="first")
```

```{r}
res
```


```{r}
res$entrez = mapIds(org.Hs.eg.db,
                    keys=row.names(countData),
                    keytype="ENSEMBL",
                    column="ENTREZID",
                    multiVals="first")

res$name =   mapIds(org.Hs.eg.db,
                    keys=row.names(res),
                    keytype="ENSEMBL",
                    column="NAMES",
                    multiVals="first")
```


## Pathway Analysis
```{r}
library(pathview)
```

```{r}
library(gage)
library(gageData)

data(kegg.sets.hs)
data(sigmet.idx.hs)

# Focus on signaling and metabolic pathways only
kegg.sets.hs = kegg.sets.hs[sigmet.idx.hs]

# Examine the first 3 pathways
head(kegg.sets.hs, 3)
```

```{r}
foldchanges = res$log2FoldChange
names(foldchanges) = res$entrez
head(foldchanges)
```

```{r}
# Get the results
keggres = gage(foldchanges, gsets=kegg.sets.hs)
```

```{r}
attributes(keggres)
```

```{r}
# Look at the first few down (less) pathways for the downregulated pathways
head(keggres$less)
```

```{r}
pathview(gene.data=foldchanges, pathway.id="hsa04114")
```

## Section 3 Gene Ontology

```{r}
data(go.sets.hs)
data(go.subs.hs)

# Focus on Biological Process subset of GO
gobpsets = go.sets.hs[go.subs.hs$BP]

gobpres = gage(foldchanges, gsets=gobpsets, same.dir=TRUE)

lapply(gobpres, head)
```

