#'
#' Screen the search articles using Google Gemini
#' 
#' 

gemini_screen_articles <- function(context, query) {
  #gargle::credentials_service_account(path = auth_key_path)

  screen <- ellmer::chat_google_gemini(system_prompt = context)

  type_classification <- ellmer::type_object(
    "A classification of journal articles on stroke",
    population = ellmer::type_boolean(
      description = "Is the study about a population 18 years and older?"
    ),
    geography = ellmer::type_boolean(
      description = "Is the study conducted in a country classified as low-middle income or low income based on World Bank income classification?"
    ),
    publication_type = ellmer::type_boolean(
      description = "Is the study a primary study with a research design such as a cohort study, case-control study, cross-sectional study, or interventional studies"
    ),
    topic = ellmer::type_boolean(
      description = "Is the study regarding stroke burden (such as prevalence, incidence, disability-adjusted life years, quality-adjusted life years, disability, death, hospitalisation) OR types of stroke (such as ischaemic stroke, haemorrhagic stroke) OR risk factors for stroke OR interventions for stroke."
    )
  )

  out <- screen$chat_structured(query, type = type_classification)

  col_names <- names(out)

  matrix(data = out, nrow = 1, ncol = 4, byrow = TRUE) |>
    data.frame() |>
    stats::setNames(nm = col_names)
}