.onLoad <- function(libname, pkgname) {
  ggplot2::theme_set(ggplot2::theme_minimal())
  ggplot2::update_geom_defaults("bar", list(fill = "red"))

  invisible()
}
