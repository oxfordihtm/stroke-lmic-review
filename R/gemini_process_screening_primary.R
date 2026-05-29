#'
#' Process Gemini primary screening of title and abstract
#' 
#' @param search_df A `data.frame()` object of the search output.
#' @param screen_results A `data.frame()` of search screening results.
#' 
#' @returns A `data.frame()` of combined search and screening results with
#'   new variables for calculated screening results.
#' 
#' @examples
#' gemini_process_screening_primary(search_full_processed, gemini_screen_primary)
#' 
#' @export
#' 

gemini_process_screening_primary <- function(search_df,
                                             screen_results) {
  tibble::tibble(
    search_df, 
    screen_results |>
      dplyr::mutate(
        dplyr::across(
          .cols = dplyr::everything(), .fns = function(x) unlist(x)
        )
      ) |>
      dplyr::rename(
        type = publication_type
      )
  ) |>
    dplyr::mutate(
      include_primary = dplyr::case_when(
        population & geography & type & topic ~ TRUE,
        .default = FALSE
      )
    )
}