
#' Creates a Local Cache from a Moodle Database
#'
#' @param con a database connection (to a moodle database)
#' @param format output format (mysql, csv)
#' @param tables which tables should be included
#' @param output_dir where does the cache go
#' @param output_filename filename (in the case of sqlite output), or prefilx (in_case of CSV download)
#' @param views should stardard views be created
#'
#' @return
#' @export
mdl_create_cache <- function(con,
                          format=c("sqlite"),
                          views = TRUE,
                          tables = c("base"),
                          output_dir = mdl_get_cache_dir(),
                          output_filename = mdl_get_cache_filename()
                          ) {
 #TODO: Implement
}
