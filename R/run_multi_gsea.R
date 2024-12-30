#' Run multiple GSEAs and collate all results
#'
#' @param data - a tibble with a column called Genes containing gene names and all other columns containing quantitative values to use for GSEA
#' @param org - the Bioconductor organism to use for the analysis (eg org.Hs.eg.db for human, org.Mm.eg.db for mouse)
#' @param minGSSize - The smallest gene set size to use
#' @param maxGSSize - The largest gene set size to use
#'
#' @return A tibble of combined results from all conditions
#' @export
#'
#' @examples
run_multi_gsea <- function(data, org=org.Hs.eg.db, minGSSize=10, maxGSSize=50, ontology="BP") {

  colnames(data %>% dplyr::select(-Genes)) -> conditions

  lapply(conditions, function(x) run_single_gsea(data, x, {{ org }}, minGSSize, maxGSSize, ontology)) -> gsea_results


  do.call(dplyr::bind_rows,gsea_results) -> gsea_results

  return(gsea_results)

}



