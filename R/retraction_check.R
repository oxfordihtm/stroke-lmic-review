#'
#' Check for retracted papers based on Retraction Watch data
#' 
#' @param search_df A data.frame() object of the raw full search output.
#' @param retraction_df A data.frame() object of the Retraction Watch dataset.
#' 

remove_retracted <- function(search_df, retraction_df) {
  retracted_dois <- retraction_df$OriginalPaperDOI |>
    (\(x) x[x != "" & x != "unavailable"])()

  search_df |>
    dplyr::mutate(doi = as.character(doi)) |>
    dplyr::filter(
      !gsub(pattern = "https://dx.doi.org/", replacement = "", x = doi) %in% retracted_dois
    )
}

