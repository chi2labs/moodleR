.onLoad <- function(libname, pkgname) {
  ggplot2::theme_set(ggplot2::theme_minimal())
  ggplot2::update_geom_defaults("bar", list(fill = "red"))

  invisible()
}

## Declaring globals
utils::globalVariables(c("ïd", "category", "category_name", "courseid", "created", "gender", "hist", "maxtime",
                         "mintime",
                         "name", "normalized_grade", "rawgrade", "rawgrademax", "thread_name", "userid", "word"))
