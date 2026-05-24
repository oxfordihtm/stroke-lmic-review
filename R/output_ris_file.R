
#'
#' Combine multiple RIS files into a single RIS file
#' 
#' @param ris A character vector of RIS-formatted bibliographic data for full
#'   search results.
#' @param dest File path to output RIS file of full search results.
#' 
#' @examples
#' output_ris_file(ris = ris_all, dest = "data/search_all.ris")
#' 
#' @export
#' 

output_ris_file <- function(ris, dest) {
  writeLines(text = ris, con = dest)

  dest
}


