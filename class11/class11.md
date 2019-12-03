---
title: "Class 11"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## The PDB database for biomolecular structure data

> Q1: Download a CSV file from the PDB site (accessible from “Analyze” -> “PDB Statistics” >
“by Experimental Method and Molecular Type”. Move this CSV file into your RStudio project
and determine the percentage of structures solved by X-Ray and Electron Microscopy. Also can
you determine what proportion of structures are protein? Aim to have a rendered GitHub
document with working code that yields your answers.

```{r}
data <- read.csv("Data Export Summary.csv")
```

Total entries
```{r}
sum(data$Total)
```

Proprtion of entries from each method
```{r}
(data$Total/sum(data$Total)) * 100
```

Proportion that are protein
```{r}
round(sum(data$Proteins)/sum(data$Total) *100, 2)
```

```{r}
library(bio3d)
pdb <- read.pdb("1hsg.pdb")

```

```{r}
atom.select(pdb)
```

```{r}
write.pdb(pdb)
```

```{r}
protein <- atom.select(pdb, "protein", value=TRUE)
write.pdb(protein, file="1hsg_protein.pdb")
ligand <- atom.select(pdb, "ligand", value=TRUE)
write.pdb(ligand, file="1hsg_ligand.pdb")
```

