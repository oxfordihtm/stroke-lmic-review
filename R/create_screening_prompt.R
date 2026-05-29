#'
#' Create screening prompt
#' 

create_screening_prompt <- function(search_title, search_abstract) {
  paste0(
    "The title of the study is ", search_title, ".\n\n",
    "The abstract of the study is ", search_abstract, "."
  )
} 