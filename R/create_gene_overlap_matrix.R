#' Calculate the percentage overlap between GO categories
#'
#' @param gsea_result A filtered GSEA result
#' @param max_categories Limit to the number of categories to cluster
#'
#' @return A tibble of category pairs with their percentage overlap
#' @export
#'
#' @examples
create_gene_overlap_matrix <- function(gsea_result, max_categories=250) {
  extract_gsea_genes(gsea_result) -> extracted_genes

  extracted_genes |>
    dplyr::group_by(ID) %>%
    dplyr::count() |>
    dplyr::ungroup() |>
    dplyr::arrange(desc(n)) |>
    dplyr::select(-n) |>
    head(n=max_categories) |>
    dplyr::rename(ID1=ID) |>
    dplyr::mutate(ID2=ID1) |>
    tidyr::complete(ID1,ID2) |>
    dplyr::filter(ID2>ID1) |>
    dplyr::rowwise() |>
    dplyr::mutate(
      overlap=get_overlap(extracted_genes,ID1,ID2)
    ) -> overlaps

  overlaps |>
    dplyr::rename(ID=ID1, ID1=ID2) |>
    dplyr::rename(ID2=ID) |>
    dplyr::bind_rows(overlaps) -> overlaps

  return(overlaps)
}
