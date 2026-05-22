
#'
#' Combine multiple RIS files into a single RIS file
#' 
#' 

output_ris_file <- function(ris, dest) {
  writeLines(text = ris, con = dest)

  dest
}


