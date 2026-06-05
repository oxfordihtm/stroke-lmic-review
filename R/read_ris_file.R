#'
#' Read RIS file
#' 

read_ris_file <- function(ris_file) {
  synthesisr::read_refs(filename = ris_file) |>
    dplyr::mutate(
      uid = dplyr::case_when(
        grepl(pattern = "Embase", x = database) ~ "EB",
        grepl(pattern = "Global Health", x = database) ~ "GH",
        grepl(pattern = "Medline|MEDLINE", x = database) ~ "ML"
      ) |>
        paste0(
          names(database) |>
            stringr::str_pad(width = 6, pad = 0)
        ),
      .before = database
    )
}