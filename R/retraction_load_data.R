#'
#' Load retraction data from Retraction Watch
#' 
#' @param path Character value for path to downloaded Retraction Watch data
#'   file
#' 

retraction_load_data <- function(path) {
  read.csv(path)
}
