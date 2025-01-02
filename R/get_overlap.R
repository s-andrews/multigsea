#' Find the overlap between the genes in two GO cateogories
#'
#' @param gsea_genes a gene set from extract_gsea_genes
#' @param ID1 The first GO category ID
#' @param ID2 The second GO category ID
#'
#' @return The average percentage overlap between the two categories
#'
#' @examples
get_overlap <- function(gsea_genes, ID1, ID2) {

  id1_genes = gsea_genes |> dplyr::filter(ID==ID1) |> dplyr::pull(Gene)
  id2_genes = gsea_genes |> dplyr::filter(ID==ID2) |> dplyr::pull(Gene)

  overlap = sum(id1_genes %in% id2_genes)

  avg_len = (length(id1_genes)+length(id2_genes))/2

  return(100*overlap/avg_len)

}
