# General Targets Workflow Template --------------------------------------------


## Load libraries and custom functions ----
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


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
  )
)


## Reporting targets ----
report_targets <- tar_plan(
  
)


## Deploy targets ----
deploy_targets <- tar_plan(
  
)


## List targets ----
all_targets()
