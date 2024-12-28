readr::read_tsv(system.file("multigsea_test_data.tsv", package="multigsea")) -> test_data

test_that("run_multi_gsea", {
  expect_is(run_multi_gsea(test_data, org = org.Mm.eg.db),"tbl")
})
