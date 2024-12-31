#' Filter a multi GSEA result
#'
#'This function filters the output of a previous run of run_multi_gsea.
#'You set a cutoff on both the (absolute) NES value, and the corrected
#'pvalue.  Only Gene Ontology IDs which pass both of those filters
#'in any of the experimental Categories are retained in the returned
#'results
#'
#' @param gsea_result The output of run_multi_gsea
#' @param nes_cutoff The absolute cutoff value for the NES value
#' @param fdr_cutoff The cutoff for the corrected pvalue
#'
#' @return
#' @export
#'
#' @examples
filter_multi_gsea <- function(gsea_result, nes_cutoff = 1, fdr_cutoff=0.05) {
  gsea_result |>
    dplyr::group_by(ID) |>
    dplyr::filter(any(abs(NES) > nes_cutoff & p.adjust < fdr_cutoff)) |>
    ungroup() -> filtered_gsea_results
    return(filtered_gsea_results)
}
