library(rmarkdown)
library(pagedown)

params_ats <- list(
  pdf_mode = FALSE
)

# ---- HTML ----
render(
  input = "cv_ats_plain.rmd",
  params = params_ats,
  output_file = "cv_ats.html"
)

# ---- PDF ----
chrome_print(
  input = "cv_ats.html",
  output = "cv_ats.pdf"
)
