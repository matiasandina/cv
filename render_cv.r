library(rmarkdown)
library(pagedown)
library(fs)

# --------------------------
# PARAM DEFINITIONS
# --------------------------

long_section_entries <- paste0(unique(read.csv("data/entries.csv", skip = 1)$section))
# this still doesn't guarantee that ALL of these sections will be included since we have a second say
# for true sections to be included you have to be matching the .Rmd location
long_section_entries <- stringr::str_subset(long_section_entries, "_short", negate = TRUE)

params_academic <- list(
  pdf_mode = FALSE,
  show_aside = TRUE,
  include_sections = long_section_entries
)

# short version of the CV
params_short <- list(
  pdf_mode = FALSE,
  show_aside = FALSE,
  include_sections = c(
    "education",
    "skills",
    "academic_articles",
    "teaching_positions",
    "software",
    "awards",
    "mentoring"
  )
)

# Short PDF uses same params except pdf_mode
params_short_pdf <- params_short
params_short_pdf$pdf_mode <- TRUE

# Academic PDF uses same params except pdf_mode
params_academic_pdf <- params_academic
params_academic_pdf$pdf_mode <- TRUE


# --------------------------
# 1. BUILD ACADEMIC HTML
# --------------------------

render(
  input = "cv.rmd",
  params = params_academic,
  output_file = "cv_academic.html"
)

# Also publish as index.html if desired:
file_copy("cv_academic.html", "index.html", overwrite = TRUE)


# --------------------------
# 2. BUILD ACADEMIC PDF
# --------------------------

tmp_html_academic <- file_temp(ext = ".html")
render(
  "cv.rmd",
  params = params_academic_pdf,
  output_file = tmp_html_academic
)

chrome_print(
  input = tmp_html_academic,
  output = "cv_academic.pdf"
)


# --------------------------
# 3. BUILD SHORT HTML
# --------------------------

render(
  input = "cv.rmd",
  params = params_short,
  output_file = "cv_short.html"
)

# If you want the SHORT version to be the main website:
# file_copy("cv_short.html", "index.html", overwrite = TRUE)


# --------------------------
# 4. BUILD SHORT PDF
# --------------------------

tmp_html_short <- file_temp(ext = ".html")
render(
  "cv.rmd",
  params = params_short_pdf,
  output_file = tmp_html_short
)

chrome_print(
  input = tmp_html_short,
  output = "cv_short.pdf"
)

