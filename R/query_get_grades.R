#' Raw query for grades
#'
#' @importFrom glue glue
#' @param tbl_prefix for moodle
#' @keywords internal
#'
#' @return character vector with moodle query
mdl_grades_query <- function(tbl_prefix) {
    glue("SELECT g.id as grade_id,
    g.id,
    cm.id as activity_id,
    gi.itemname,
    gi.itemname as activity_name,
    CASE WHEN gi.itemtype = \'course\' THEN gi.itemtype
    WHEN gi.itemtype = \'mod\'    THEN gi.itemmodule
    END AS item_type,
    gi.courseid,
    g.userid,
    g.rawgrademax,
    g.rawgrademin,
    g.rawgrade,
    g.timecreated,
    g.timemodified
    FROM {tbl_prefix}grade_grades g
    LEFT JOIN {tbl_prefix}grade_items gi ON g.itemid = gi.id AND gi.itemtype IN('mod', 'course')
    LEFT JOIN {tbl_prefix}modules mo ON mo.name = gi.itemmodule AND gi.itemtype = 'mod'
    LEFT JOIN {tbl_prefix}course_modules cm ON cm.instance = gi.iteminstance AND cm.module   = mo.id
    AND gi.itemtype = 'mod' ")
}
