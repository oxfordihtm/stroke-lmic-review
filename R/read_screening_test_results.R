#'
#' Read and process screening test results
#' 

read_screening_primary_results <- function(file_path) {
  read.csv(file = file_path) |>
    dplyr::mutate(
      model = basename(file_path) |>
        stringr::str_extract(pattern = "^[^_]+"),
      .before = uid
    ) |>
    tibble::as_tibble()
}
