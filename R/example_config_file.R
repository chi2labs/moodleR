#' Example Config yml File
#'
#' Opens an example config file in the active editor.
#' If you already have a config.yml file cut-and-paste the "moodleR" section,
#' and update the respective fields.
#' Alternatively use "save as" to save this file as config.yml
#' It is recommended that you check the config with config::get()
#' @return invisible(TRUE) on success
#' @export
#'
#' @examples
#' \dontrun{
#' example_config_yml()
#' }
example_config_yml <- function(){
  usethis::use_template("config_example.yml", package = "moodleR", open = TRUE)
}
