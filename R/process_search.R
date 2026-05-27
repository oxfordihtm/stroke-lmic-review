#'
#' Process search results
#' 
#' @param search_df A `data.frame()`` object of the raw full search output.
#' 
#' @returns A `tibble::tibble()`/`data.frame()` object of the processed full
#'   search.
#' 
#' @examples
#' process_search(search_full_no_retractions)
#' 
#' @export
#'

process_search <- function(search_df) {
  df <- search_df |>
    dplyr::mutate(
      language = simplify_list(language),
      journal = simplify_list(journal),
      volume = simplify_list(volume) |> suppressWarnings(as.integer()),
      issue = simplify_list(issue),
      start_page = simplify_list(start_page) |> suppressWarnings(as.integer()),
      doi = simplify_list(doi),
      accession_zr = simplify_list(accession_zr),
      url = simplify_list(url),
      publisher = simplify_list(publisher),
      L2 = simplify_list(L2),
      N2 = simplify_list(N2),
      ID = simplify_list(ID),
      end_page = simplify_list(end_page),
      XT = simplify_list(XT),
      C5 = simplify_list(C5),
      pubmed_id = simplify_list(pubmed_id),
      C1 = simplify_list(C1),
      proceedings_title = simplify_list(proceedings_title),
      C4 = simplify_list(C4),
      source = simplify_list(source),
      chemicals = simplify_list(chemicals),
      notes = simplify_list(notes),
      A3 = simplify_list(A3),
      conference_date = simplify_list(conference_date) |>
        gsub(pattern = "//", replacement = "", x = _),
      Y1 = gsub(pattern = "//", replacement = "", x = Y1)
    ) |>
    dplyr::rename(
      abstract = N2,
      reference_identifier = ID,
      link_to_full_text = L2,
      year = Y1,
      author_1 = A1,
      author_2 = author,
      author_3 = A3,
      author_affiliation_1 = M1,
      author_affiliation_2 = M2,
      author_affiliation_3 = M3,
      funding_number = C5,
      software_tools = C1,
      company = C4
    ) |>
    dplyr::mutate(
      publication_type = stringr::str_split(
        string = publication_type, pattern = ", "
      ),
      language = stringr::str_split(
        string = language, pattern = ", "
      ),
      conference_date = as.Date(x = conference_date, format = "%Y%m%d")
    ) |>
    dplyr::select(-n_duplicates) |>
    dplyr::select(
      database, source_type, publication_type, reference_identifier, pubmed_id,
      accession_zr, issn, language, journal, publisher, title, abstract,
      keywords, author_1, author_2, author_3, address, author_affiliation_1,
      author_affiliation_2, author_affiliation_3, year, volume, issue,
      start_page, end_page, doi, url, link_to_full_text, proceedings_title,
      conference_date, company, source, chemicals, software_tools,
      funding_number, notes, XT
    )
  
  df
}

