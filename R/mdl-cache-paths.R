#' Get the Cache Directory
#'
#' @import rlang
#' @importFrom  glue glue
#' @return Character vector with path
#' @export
mdl_get_cache_dir <- function(){
  ret <- config::get("moodleR")$cache_dir
  if (is.null(ret)) {
    ret <- here::here("mdl_cache")
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
#' @import rlang
#' @importFrom glue glue
#' @return Character vector with path
#' @export
mdl_get_cache_filename <- function() {
  ret <- config::get("moodleR")$cache_filename
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
