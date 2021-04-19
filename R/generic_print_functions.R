#' Print Moodle Forum Post Summary
#'
#' Overrides generic print function to pretty-print a summary of the Moodle posts.
#' @inheritParams base::print
#' @return invisible(x). Typically called for its side effect which is a pretty-print of the relevant information.
#' @export
print.mdl_post_summary <- function(x, ...) {

  cat("----------\n")
  for (my_name in names(x)) {
    cat(str_pad(paste0(my_name, ":"), 10, "right"),
        "\t", my_format(x[[my_name]]), "\n")
  }
  invisible(x)
}

#' Print Moodle Grades Summary
#'
#' Overrides generic print function to pretty-print a summary of the grades from the gradebook.
#' @inheritParams base::print
#' @return invisible(x). Typically called for its side effect which is a pretty-print of the relevant information.
#' @export
print.mdl_grades_summary <- function(x, ...) {
  # pretty-print
  cat("----------\n")
  for (my_name in names(x)) {
    cat(str_pad(paste0(my_name, ":"), 10, "right"), "\t",
        my_format(x[[my_name]]), "\n")
  }
  invisible(x)
}

#' Print Moodle Courses Summary
#'
#' Overrides generic print function to pretty-print a summary of the course information.
#' @inheritParams base::print
#' @return invisible(x). Typically called for its side effect which is a pretty-print of the relevant information.
#'
#' @export
print.mdl_courses_summary <- function(x, ...) {
  # pretty-print
  cat("----------\n")
  for (my_name in names(x)) {
    cat(str_pad(paste0(my_name, ":"), 10, "right"), "\t",
        my_format(x[[my_name]]), "\n")
  }
  invisible(x)
}

#' Print Moodle Users Summary
#'
#' Overrides generic print function to pretty-print a summary of the users.
#' @inheritParams base::print
#' @return invisible(x). Typically called for its side effect which is a pretty-print of the relevant information.
#'
#' @export
print.mdl_users_summary <- function(x, ...) {
  # pretty-print
  cat("----------\n")
  for (my_name in names(x)) {
    cat(str_pad(paste0(my_name, ":"), 10, "right"), "\t",
        my_format(x[[my_name]]), "\n")
  }
  invisible(x)
}
