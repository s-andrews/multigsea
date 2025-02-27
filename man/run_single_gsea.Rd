% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_single_gsea.R
\name{run_single_gsea}
\alias{run_single_gsea}
\title{\link{Internal} Helper function to run a single GSEA search}
\usage{
run_single_gsea(data, column, org, minGSSize, maxGSSize, ontology)
}
\arguments{
\item{data}{Tibble with Genes and columns of quantitative GSEA values}

\item{column}{The column of quantitative values to use}

\item{org}{The species to use for the analysis}

\item{minGSSize}{Minimum gene set size}

\item{maxGSSize}{Maximum gene set size}
}
\value{
A tibble of GSEA results
}
\description{
\link{Internal} Helper function to run a single GSEA search
}
