#' Extract the leading edge genes from GSEA to a tibble
#'
#' @param gsea_result A full multi_gsea result tibble
#'
#' @return A tibble containing the extracted genes
#' @export
#'
#' @examples
extract_gsea_genes <- function(gsea_result, max_genes=100) {
  gsea_result |>
    dplyr::arrange(desc(length(core_enrichment))) |>
    dplyr::select(ID,Description,core_enrichment) |>
    dplyr::distinct(ID, .keep_all = TRUE) |>
    tidyr::separate(
      core_enrichment,
      into=c(paste("Gene",1:max_genes)),
      sep="/"
    ) |>
    tidyr::pivot_longer(
      cols=starts_with("Gene"),
      names_to="Temp",
      values_to="Gene"
    ) %>%
    dplyr::filter(!is.na(Gene)) %>%
    dplyr::select(-Temp) -> extracted_genes
    return(extracted_genes)
}
