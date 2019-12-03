---
title: "Class12: Structural Bioinformatics II"
author: "Yasmine Kasiri"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Prep for docking

We want to produce a protein-only PDB file and a drug-only PDB file

```{r}
library(bio3d)

# download the PDB file
get.pdb("1hsg")

pdb <- read.pdb("1hsg.pdb")
```

```{r}
protein <- atom.select(pdb, "protein", value = TRUE)
write.pdb(protein, file="1hsg_protein.pdb")
ligand <- atom.select(pdb, "ligand", value = TRUE)
write.pdb(ligand, file="1hsg_ligand.pdb")
```

```{r}
library(bio3d)
res <- read.pdb("all.pdbqt", multi=TRUE)
write.pdb(res, "results.pdb")
```

