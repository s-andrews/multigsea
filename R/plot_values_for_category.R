#' Plot data for single GO category as a heatmap
#'
#' @param gsea_result A full or filtered multi_gsea result
#' @param fold_change_data The original quantitative data from which the gsea result was calculated
#' @param category_id The Category ID name for the GO category to plot
#'
#' @return A ggplot heatmap of the genes in the category using the quantitative data
#' @export
#'
#' @examples
plot_values_for_category <- function(gsea_result, fold_change_data, category_id, min_value=NULL, max_value=NULL) {

  gsea_result |>
    dplyr::filter(ID == category_id) -> filtered_results

  category_description <- filtered_results$Description[1]

  filtered_results |>
    dplyr::pull(Condition) -> conditions_to_keep

  filtered_results |>
    dplyr::select(core_enrichment) |>
    tidyr::separate(
      core_enrichment,
      into=c(paste("Gene",1:100)),
      sep="/"
    ) |>
    tidyr::pivot_longer(
      cols=starts_with("Gene"),
      names_to="Temp",
      values_to="Gene"
    ) |>
    dplyr::filter(!is.na(Gene)) |>
    dplyr::distinct(Gene) |>
    dplyr::pull(Gene) -> genes_to_keep

  fold_change_data |>
    dplyr::select(Genes,one_of(conditions_to_keep)) |>
    dplyr::filter(Genes %in% genes_to_keep) |>
    tidyr::pivot_longer(
      cols=-Genes,
      names_to="Condition",
      values_to="Value"
    ) -> plot_data

  value_limit <- max(abs(plot_data$Value))
  if (is.null(min_value)) {
    min_value=0-value_limit
  }

  if (is.null(max_value)) {
    max_value=value_limit
  }

  plot_data |>
    tidyheatmaps::tidy_heatmap(
      columns=Condition,
      rows=Genes,
      values=Value,
      main = paste(category_id, category_description),
      fontsize = 6,
      cluster_rows = TRUE,
      color_legend_min = min_value,
      color_legend_max = max_value
    ) -> plot


  return(plot)

}
