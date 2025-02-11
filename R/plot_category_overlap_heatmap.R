#' Plot overlap between categories as a heatmap
#'
#' @param gene_list_overlaps Output of create_category_overlap_matrix
#' @param minoverlap Minimum percentage overlap to plot
#'
#' @return A ggplot heatmap of the overlaps between categories
#' @export
#'
#' @examples
plot_category_overlap_heatmap <- function(gene_list_overlaps, minoverlap=0) {


  gene_list_overlaps |>
    dplyr::mutate(overlap = replace(overlap,overlap<minoverlap,0)) |>
    dplyr::group_by(ID1) |>
    dplyr::filter(any(overlap>0)) |>
    dplyr::ungroup() |>
    dplyr::group_by(ID2) |>
    dplyr::filter(any(overlap>0)) |>
    dplyr::ungroup() |>
    tidyheatmaps::tidy_heatmap(
      rows=ID1,
      columns=ID2,
      values=overlap,
      cluster_rows = TRUE,
      cluster_cols=TRUE,
      scale="none",
      show_colnames = FALSE,
      colors = c("white","red2")
    ) -> plot

  return(plot)

}
