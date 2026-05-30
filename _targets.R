# General Targets Workflow Template --------------------------------------------


## Load libraries and custom functions ----
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


## Build options ----

### Set Google credentials ----

gargle::credentials_service_account(path = Sys.getenv("GOOGLE_AUTH_FILE"))


## Data targets ----
data_targets <- tar_plan(
  tar_target(
    name = ris_file_paths,
    command = list.files(path = "data-raw", pattern = ".ris", full.names = TRUE)
  ),
  tar_target(
    name = ris_all,
    command = readLines(ris_file_paths),
    pattern = map(ris_file_paths)
  ),
  tar_target(
    name = search_full_ris,
    command = synthesisr::read_refs(filename = ris_file_paths),
    pattern = map(ris_file_paths),
    iteration = "list"
  ),
  tar_target(
    name = search_full_raw,
    command = synthesisr::read_refs(filename = ris_all_file)
  ),
  retraction_watch_data_url = "https://gitlab.com/crossref/retraction-watch-data/-/raw/main/retraction_watch.csv",
  tar_target(
    name = retraction_watch_data_download_csv_file,
    command = retraction_download_data(
      .url = retraction_watch_data_url, path = "data/retraction_watch.csv"
    )
  ),
  tar_target(
    name = retraction_watch_data,
    command = retraction_load_data(
      path = retraction_watch_data_download_csv_file
    )
  )
)


## Processing targets ----
processing_targets <- tar_plan(
  tar_target(
    name = search_full_deduplicated,
    command = synthesisr::deduplicate(
      data = search_full_raw, match_by = "title", method = "string_osa"
    )
  ),
  tar_target(
    name = search_full_no_retractions,
    command = remove_retracted(
      search_df = search_full_deduplicated, 
      retraction_df = retraction_watch_data
    )
  ),
  tar_target(
    name = search_full_processed,
    command = process_search(search_full_no_retractions)
  ),
  tar_target(
    name = search_full_processed_flattened,
    command = flatten_search(search_full_processed)
  ),
  tar_target(
    name = search_title,
    command = get_title(search_full_processed)
  ),
  tar_target(
    name = search_abstract,
    command = get_abstract(search_full_processed)
  )
)


prompt_targets <- tar_plan(
  tar_target(
    name = screening_context_prompt,
    command = create_screening_context_prompt()
  ),
  tar_target(
    name = screening_prompt,
    command = create_screening_prompt(
      search_title = search_title, search_abstract = search_abstract
    )
  )
)

## Gemini LLM targets ----
gemini_targets <- tar_plan(
  tar_target(
    name = gemini_screen_primary,
    command = gemini_screen_articles(
      context = screening_context_prompt, query = screening_prompt
    ),
    pattern = map(screening_prompt)
  ),
  tar_target(
    name = gemini_screen_primary_processed,
    command = process_screening_primary(
      search_df = search_full_processed, screen_results = gemini_screen_primary
    )
  ),
  tar_target(
    name = gemini_screen_primary_processed_flattened,
    command = process_screening_primary(
      search_df = search_full_processed_flattened, 
      screen_results = gemini_screen_primary
    )
  )
)


## Claude LLM targets ----
claude_targets <- tar_plan(
  claude_model = "claude-opus-4-5-20251101",
  tar_target(
    name = claude_reviewer,
    command = ellmer::chat_claude(
      system_prompt = screening_context_prompt, model = claude_model
    )
  ),
  tar_target(
    name = claude_screen_primary,
    command = claude_screen_articles(
      claude_reviewer = claude_reviewer, query = screening_prompt
    ),
    pattern = map(screening_prompt)
  ),
  tar_target(
    name = claude_screen_primary_processed,
    command = process_screening_primary(
      search_df = search_full_processed, screen_results = claude_screen_primary
    )
  ),
  tar_target(
    name = claude_screen_primary_processed_flattened,
    command = process_screening_primary(
      search_df = search_full_processed_flattened, 
      screen_results = claude_screen_primary
    )
  )
)


## Ollama Gemma targets ----
gemma_ollama_targets <- tar_plan(
  gemma_model = "gemma4:31b",
  tar_target(
    name = gemma_reviewer,
    command = ellmer::chat_ollama(
      system_prompt = screening_context_prompt, model = gemma_model
    )
  ),
  tar_target(
    name = gemma_screen_primary,
    command = gemma_screen_articles(
      model = gemma_model,
      context = screening_context_prompt, 
      query = screening_prompt
    ),
    pattern = map(screening_prompt)
  )
)


## Analysis targets ----
analysis_targets <- tar_plan(
  
)


## Output targets ----
output_targets <- tar_plan(
  tar_target(
    name = ris_all_file,
    command = output_ris_file(ris = ris_all, dest = "data/search_all.ris")
  ),
  tar_target(
    name = search_full_processed_flattened_csv,
    command = output_csv_file(
      df = search_full_processed_flattened,
      path = "data/search_full_processed_flattened.csv"
    )
  ),
  tar_target(
    name = gemini_screen_primary_processed_flattened_csv,
    command = output_csv_file(
      df = gemini_screen_primary_processed_flattened,
      path = "data/gemini_screen_primary_processed_flattened.csv"
    )
  ),
  tar_target(
    name = claude_screen_primary_processed_flattened_csv,
    command = output_csv_file(
      df = claude_screen_primary_processed_flattened,
      path = "data/claude_screen_primary_processed_flattened.csv"
    )
  )
)


## Reporting targets ----
report_targets <- tar_plan(
  tar_quarto(
    name = preliminary_report,
    path = "reports/preliminary_report.qmd"
  )
)


## Deploy targets ----
deploy_targets <- tar_plan(
  
)


## List targets ----
all_targets()
