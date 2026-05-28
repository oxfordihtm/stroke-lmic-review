#'
#' Get title of articles
#' 
#' @param processed_df A `data.frame()`` object of the processed search output.
#' 
#' @returns A character vector of titles of articles from processed search
#'   data
#' 
#' @examples
#' get_title(search_full_processed)
#' 
#' @export
#' 

get_title <- function(processed_df) {
  processed_df |>
    (\(x) x$title)()
}
