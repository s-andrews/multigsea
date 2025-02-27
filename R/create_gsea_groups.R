#' Add grouping information to filtered GSEA results
#'
#' @param gsea_matrix Overlap matrix from create_category_overlap_matrix
#' @param minoverlap Minimum percentage overlap to use
#'
#' @return A tibble containing the Cateory IDs and the group to which they were assigned
#' @export
#'
#' @examples
create_gsea_groups <- function(gsea_matrix, minoverlap=30) {
  gsea_matrix |>
    dplyr::mutate(adjacency=dplyr::if_else(overlap>minoverlap,1,0)) %>%
    dplyr::select(-overlap) %>%
    tidyr::pivot_wider(
      names_from=ID2,
      values_from=adjacency
    ) %>%
    tibble::column_to_rownames(var="ID1") %>%
    as.matrix() %>%
    igraph::graph_from_adjacency_matrix() %>%
    igraph::as.undirected() %>%
    igraph::cluster_fast_greedy() -> temp

  lapply(1:length(temp),function(x)tibble::tibble(Group=paste0("Group",x), ID=temp[[x]])) -> temp

  do.call(dplyr::bind_rows,temp) -> temp

  return(temp)

}
