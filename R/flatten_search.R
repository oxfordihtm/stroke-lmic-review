#'
#' Unlist and flatten processed search results to be compatible with CSV
#' output
#' 
#' @param processed_df A `data.frame()` object of the processed search output.
#' 
#' @returns A `tibble::tibble()`/`data.frame()` object of the flattened
#'   processed search output.
#' 
#' @examples
#' flatten_search(search_full_processed)
#' 
#' @export
#' 

flatten_search <- function(processed_df) {
  df <- processed_df |>
    dplyr::mutate(
      dplyr::across(
        .cols = dplyr::where(fn = function(x) is(x, "list")),
        .fns = function(x) {
          lapply(X = x, FUN = paste, collapse = "; ") |>
            unlist()
        }
      )
    )
  
  df
}