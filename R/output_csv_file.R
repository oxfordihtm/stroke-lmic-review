#'
#' Output CSV file
#' 
#' @param df A `data.frame()` object to output to CSV
#' @param path A file path to the output CSV.
#' @param overwrite Logical. Should existing file in path be overwritten?
#'   Default to FALSE.
#' 
#' @returns A file path to the created CSV file
#' 
#' @examples
#' output_csv_file(df = search_full_processed_flattended)
#' 
#' @export
#' 

output_csv_file <- function(df, path, overwrite = FALSE) {
  if (!file.exists(path) | overwrite) {
    write.csv(x = df, file = path, row.names = FALSE)
  }

  path
}
