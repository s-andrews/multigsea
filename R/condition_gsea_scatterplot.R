#' Plot a pairwise scatterplot from GSEA data
#'
#' @param gsea_result A gsea result from run_multi_gsea or filter_multi_gsea
#' @param condition1 The name of the first condition
#' @param condition2 The name of the second condition
#' @param metric The metric column to use (NES or Directional_Phred)
#'
#' @return A ggplot object of the pairwise scatterplot between the conditions
#' @export
#'
#' @examples
condition_gsea_scatterplot <- function(gsea_result, condition1, condition2, metric="Directional_Phred") {

  gsea_result |>
    dplyr::select(all_of(metric),Condition,ID,Description) |>
    dplyr::filter(Condition %in% c(condition1,condition2)) -> filtered_data

  limit <- max(abs(filtered_data[[metric]]))

  filtered_data |>
    tidyr::pivot_wider(
      names_from=Condition,
      values_from={{ metric }}
    ) |>
    ggplot2::ggplot(aes(x=.data[[condition1]], y= .data[[condition2]])) +
    ggplot2::geom_vline(xintercept = 0) +
    ggplot2::geom_hline(yintercept = 0) +
    ggplot2::geom_point() +
    ggplot2::coord_cartesian(xlim=c(0-limit,limit), ylim=c(0-limit,limit)) -> scatterplot

  return(scatterplot)

}
