% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/find_condition_differences.R
\name{find_condition_differences}
\alias{find_condition_differences}
\title{Filter a GSEA result to get differences between conditions}
\usage{
find_condition_differences(
  gsea_result,
  condition1,
  condition2,
  cutoff,
  metric = "Directional_Phred"
)
}
\arguments{
\item{gsea_result}{A gsea result from run_multi_gsea or filter_multi_gsea}

\item{condition1}{The name of the first condition}

\item{condition2}{The name of the second condition}

\item{cutoff}{The absolute value above which GO results will be retained}

\item{metric}{The metric column to use (NES or Directional_Phred)}
}
\value{
A filtered GSEA result containing only the GO categories which pass the filter.
}
\description{
Filter a GSEA result to get differences between conditions
}
