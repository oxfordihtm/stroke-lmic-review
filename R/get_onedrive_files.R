#'
#' Get files from Microsoft One Drive
#' 
#' @param src Directory or files to search for in One Drive
#' @param path Destination directory to download One Drive files into
#' 
#' @returns NULL
#' 
#' @examples
#' get_onedrive_file(src = "stroke-lmic-review", dest = "data-raw")
#' 
#' @export
#' 

get_onedrive_files <- function(src, path) {
  onedrive <- Microsoft365R::get_business_onedrive()
  onedrive_shared_files <- onedrive$list_shared_files()    ## List shared files
  onedrive_files <- onedrive$list_items()

  ## Download contents of One Drive stroke-lmic-review folder ----
  onedrive$download_folder(src = src, dest = path)
}
