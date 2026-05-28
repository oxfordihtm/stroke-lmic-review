#'
#' Get abstract of articles
#' 
#' @param processed_df A `data.frame()`` object of the processed search output.
#' 
#' @returns A character vector of abstracts of articles from processed search
#'   data
#' 
#' @examples
#' get_abstract(search_full_processed)
#' 
#' @export
#' 

get_abstract <- function(processed_df) {
  processed_df |>
    (\(x) x$abstract)()
}
