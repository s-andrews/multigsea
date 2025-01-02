# multigsea - Gene Set Analysis across multiple datasets

This repository contains an R package which aids in the interpretation of complex experimental designs where a large cohort of genes have been measured across multiple samples.

The package runs a Gene Set Enrichment Analysis (GSEA) across each dataset and then provides tools for filtering and visualising the results.

## Installation

### BioConductor Dependencies
The main package installation will handle the automatic installation of all CRAN R package dependencies, but it can't handle the required BioConductor packages.  You should install these before proceeding with the main package install.

```
install.packages("BiocManager")
BiocManager::install("clusterProfiler")
```

You will also need to install the appropriate [Genome Annotation Package](https://bioconductor.org/packages/release/BiocViews.html#___OrgDb) for the species you want to use.

```
BiocManager::install("org.Mm.eg.db") # Mouse
BiocManager::install("org.Hs.eg.db") # Human
```


You will then need to install the package itself using the `devtools` or `remotes` packages.

### Remotes
```
install.packages("remotes")
remotes::install_github("s-andrews/multigsea")
```

### Devtools
```
install.packages("devtools")
devtools::install_github("s-andrews/multigsea")
```

## Using the package
See the [MultiGSEA Vignette](https://html-preview.github.io/?url=https://github.com/s-andrews/multigsea/raw/refs/heads/main/inst/doc/multi_gsea.html) for details of how to use the package.


