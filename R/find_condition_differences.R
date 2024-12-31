#' Filter a GSEA result to get differences between conditions
#'
#' @param gsea_result A gsea result from run_multi_gsea or filter_multi_gsea
#' @param condition1 The name of the first condition
#' @param condition2 The name of the second condition
#' @param cutoff The absolute value above which GO results will be retained
#' @param metric The metric column to use (NES or Directional_Phred)
#'
#' @return A filtered GSEA result containing only the GO categories which pass the filter.
#' @export
#'
#' @examples
find_condition_differences <- function(gsea_result, condition1, condition2, cutoff, metric="Directional_Phred") {

  gsea_result |>
    dplyr::select(all_of(metric),Condition,ID,Description) |>
    dplyr::filter(Condition %in% c(condition1,condition2)) |>
    tidyr::pivot_wider(
      names_from=Condition,
      values_from={{ metric }}
    ) |>
    dplyr::mutate(Difference = .data[[condition2]] - .data[[condition1]]) |>
    dplyr::filter(abs(Difference)>=cutoff) |>
    pull(ID) -> ids_to_keep

    gsea_result |>
      dplyr::filter(Condition %in% c(condition1,condition2)) |>
      dplyr::filter(ID %in% ids_to_keep) -> filtered_data


  return(filtered_data)

}
