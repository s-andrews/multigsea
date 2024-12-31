#' [Internal] Helper function to run a single GSEA search
#'
#' @param data Tibble with Genes and columns of quantitative GSEA values
#' @param column The column of quantitative values to use
#' @param org The species to use for the analysis
#' @param minGSSize Minimum gene set size
#' @param maxGSSize Maximum gene set size
#'
#' @return

run_single_gsea <- function(data,column, org, minGSSize, maxGSSize, ontology) {
  data |>
    dplyr::select(Genes,{{ column }})  -> sorted_data

  sorted_data |>
    dplyr::pull( {{ column }}) -> gsea_values

  names(gsea_values) <- sorted_data$Genes

  sort(gsea_values, decreasing = TRUE) -> gsea_values

  clusterProfiler::gseGO(
    geneList = gsea_values,
    ont = ontology,
    OrgDb = {{ org }},
    minGSSize = minGSSize,
    maxGSSize = maxGSSize,
    keyType = "SYMBOL",
    pvalueCutoff = 1,
    pAdjustMethod = "none"
  ) -> gsea_result

  return (
    gsea_result@result |>
      dplyr::as_tibble() |>
      tibble::add_column(Condition=column) |>
      dplyr::mutate(Directional_Phred=(-10*log10(p.adjust)*if_else(NES<0,-1,1))) |>
      dplyr::select(ID,Condition,everything())
  )

}
