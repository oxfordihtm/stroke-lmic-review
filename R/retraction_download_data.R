#'
#' Download retraction data from Retraction Watch
#' 
#' @param .url URL to Retraction Watch data.
#' @param path Character value for file path for downloaded retraction watch
#'   data. 
#' 

retraction_download_data <- function(.url, 
                                     path,
                                     overwrite = FALSE) {
  if (!file.exists(path) | overwrite) {
    download.file(url = .url, destfile = path, mode = "wb")
  }

  path
}