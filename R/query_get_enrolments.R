#' Raw query for discussion posts
#'
#' @importFrom glue glue
#' @param tbl_prefix for moodle
#' @keywords internal
#' @return character vector with moodle query
mdl_enrolments_query <- function(tbl_prefix) {
  glue("SELECT e.courseid
  ue.userid,
  ra.roleid,
  ue.timestart,
  ue.timeend,
  ue.timecreated,
  ue.timemodified
  FROM {tbl_prefix}user_enrolments ue
  LEFT JOIN {tbl_prefix}enrol e ON ue.enrolid = e.id
  LEFT JOIN {tbl_prefix}context ctx ON ctx.instanceid = e.courseid AND ctx.contextlevel = 50
  LEFT JOIN {tbl_prefix}user u ON ue.userid = u.id
  LEFT JOIN {tbl_prefix}role_assignments ra ON ra.contextid = ctx.id AND ra.userid = ue.userid
  LEFT JOIN {tbl_prefix}role r ON r.id = ra.roleid
  WHERE EXISTS (SELECT c.id FROM {tbl_prefix}course c WHERE e.courseid = c.id AND c.category <> 0)
                                                        AND
                                                        EXISTS (SELECT u.id FROM {tbl_prefix}user u WHERE ue.userid  = u.id AND u.deleted   = 0)")


}
