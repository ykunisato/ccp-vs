# install R packages from CRAN
install.packages(c("memisc",
"tidyverse",
"devtools"), error = TRUE, dependencies = TRUE)

# install CMDSTAN_HOME
remotes::install_github("stan-dev/posterior")
install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
