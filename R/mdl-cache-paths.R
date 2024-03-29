#' Get the Cache Directory
#'
#' The cache directory can be set in the config-file (moodleR:->cache_dir:), which is recommended.
#' If it is not present, or no config is found, a tempdir() will be returned.
#'
#' @import rlang
#' @importFrom  glue glue
#' @return Character vector with path
#' @export
mdl_get_cache_dir <- function(){
  ret <- tryCatch(
    config::get("moodleR")$cache_dir,
    error = function(e){NULL}
  )
  if (is.null(ret)) {
    ret <- tempdir()
    if (!file.exists(ret)) {
      dir.create(ret)
      rlang::inform(glue::glue("Directory created: {ret}"))
    }
    rlang::inform(message =
                    glue::glue("Directory '{ret}' used by default. Set config variable in moodleR:mdl_cache_dir to override.") ,
                  .frequency = "once",
                  .frequency_id = "mdl_get_cache_dir"
    )
  }
  ret
}


#' Get the Cache Filename
#'
#' The cache filename ("mdl_cache.sqlite" by default), can be set in the config-file((moodleR:->cache_dir:).
#' @import rlang
#' @importFrom glue glue
#' @return Character vector with path
#' @export
mdl_get_cache_filename <- function() {
  ret <- tryCatch(
    config::get("moodleR")$cache_filename,
    error = function(e){NULL}
  )
  if (is.null(ret)) {
    ret <- "mdl_cache.sqlite"
    rlang::inform(
      message =
        glue::glue("Filename '{ret}' used by default. Set config variable in moodleR:mdl_cache_dir to override."),
      .frequency = "once",
      .frequency_id = "mdl_get_cache_filename"
    )
  }
  ret
}
