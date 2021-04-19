# test_that("Make sure path is informed.",{
#   skip("Skipped as they depend on order, or restarting the session")
#   # These tests are commented out as they depend on the order in which tests are executed.
#    expect_message(mdl_get_cache_dir(),"Directory")
#   # expect_silent(mdl_get_cache_dir())
# })

test_that("Check that mdl_get_cache_connection returns a SQLite object", {
  expect_s4_class(
    mdl_get_cache_connection(access = "RWC"),
    "SQLiteConnection"
  )
})
test_that("Check that mdl_get_connection returns a SQLite object by default", {
  expect_s4_class(
    mdl_get_connection(),
    "SQLiteConnection"
  )
})


