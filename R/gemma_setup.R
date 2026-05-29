#'
#' Setup Ollama Gemma4 model
#' 
#' 

gemma_setup_model <- function(model) {
  if (!ollamar::model_avail(model)) {
    ollamar::pull(model)
  }

  model
}