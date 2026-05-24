#'
#' RIS tags code lookup table
#' 

code_lookup <- function() {
  tibble::tribble(
    ~code, ~field,
    "TY", "source_type",
    "DB", "database",
    "AN", "accession_number",
    "ID", "reference_identifier",
    "T1", "title",
    "A1", "author",
    "Y1", "year_date",
    "N2", "abstract",
    "KW", "keyword",
    "JF", "journal_name",
    "JA", "journal_abbreviation",
    "LA", "language",
    "VL", "volume",
    "SP", "pages",
    "CY", "place_published",
    "SN", "issn_isbn",
    "M1", "affiliation1",
    "M3", "affiliation2",
    "DO", "doi",
    "PT", "publication_type",
    "L2", "link_full_text",
    "UR", "url",
    "XT", ""
  )
}