#' Check Cached Data
#'
#' Checks that the cached data is available.
#' @return invisible(NULL)
#' @export
#' @examples
#'\dontrun{
#' check_mdl_cache()
#' }
check_mdl_cache <- function(){
  my_filename <- file.path(mdl_get_cache_dir(), mdl_get_cache_filename())
  if(!file.exists(my_filename)){
    cli::cli_alert_danger("Cached data not found or not readable: {my_filename}")
    return(invisible(NULL))
  }

  suppressMessages(
    test_conn <- tryCatch(
      mdl_get_cache_connection(access="RO"),
      error = function(e){
        e

      })
  )
  if("error" %in% class(test_conn)){
    cli::cli_alert_danger(stringr::str_replace(test_conn$message,"\n"," "))
    return(invisible())
  }
  if("SQLiteConnection" %in% class(test_conn)){
    cli::cli_alert_success("Cache database accessible and readable.")
  }
  ## Check available tables
  n_tables <- length(DBI::dbListTables(test_conn) )
  cli::cli_alert_info("{n_tables} tables cached.")
}
