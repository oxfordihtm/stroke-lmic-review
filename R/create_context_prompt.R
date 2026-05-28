#'
#' Create context prompt
#' 

create_screening_context_prompt <- function() {
  criteria <- c(
    "You are a classifier of research studies on stroke for the purpose of a scoping review.",
    "You determine based on the title and abstract of a research study whether it is to be included in the scoping review based on the following criteria.",
    "First criteria is that the study should be on a population of age 18 years and older.",
    "Second criteria is that the study should be on a population living in lower-middle income (LMIC) or low income countries (LIC) based on the most recent World Bank country classification by income level.",
    "Third criteria is that the study should be regarding stroke burden (such as prevalence, incidence, disability-adjusted life years, quality-adjusted life years, disability, death, hospitalisation) OR types of stroke (such as ischaemic stroke, haemorrhagic stroke) OR risk factors for stroke OR interventions for stroke.",
    "Fourth criteria is that the study should be based on primarily collected data with a research design such as a cohort study, case-control study, cross-sectional study, or interventional studies.",
    "The studies cannot be reports, conference materials, reviews, study protocols, modelling studies, cost of illness studies, case series, case reports, and editorials."    
  )

  paste(criteria, collapse = " ")
}