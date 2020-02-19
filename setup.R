
# Run this script first to check required packages installed and to download data from OSF
# Repeating the download occasionally is highly recommended, since the data are regularly updated

# Check recent version of R installed
if(getRversion() < "3.3.2") {
  stop("##########\nOld version of R\nPlease install latest version\n##########")
}

# Check recent version of Rstudio installed
if(RStudio.Version()$version < "1.0.0"){
  stop("##########\nOld version of Rstudio\nPlease install latest version\n##########")
}

#Check git is installed
if(Sys.which("git") == ""){
  warning("##########\ngit not installed\n##########", immediate. = TRUE)
}


# Check CRAN packages installed
CRAN_needed <- read.table(header = TRUE, stringsAsFactors = FALSE, text = 
                            "package
                          tidyverse #this includes dplyr, ggplot, tidyr etc
                          vegan
                          RSQLite
                          assertthat
                          plyr
                          devtools
                          cowplot
                          gridExtra
                          rmarkdown
                          assertr
                          GGally
                          ggfortify
                          entropy
                          cocorresp
                          ggrepel
                          rdrop2
                          raster
                          ")$package

# check against currently installed packages
installed_packages <- .packages(all.available = TRUE)
CRAN_needed2 <- CRAN_needed[!CRAN_needed %in% installed_packages]

# download missing CRAN packages
if(length(CRAN_needed2) > 0){
  install.packages(CRAN_needed2)
}

# check github packages
github_needed <- read.table(header = TRUE, stringsAsFactors = FALSE, text =
   "package repo ref
   ggbiplot richardjtelford experimental
   ggvegan gavinsimpson master
   tpldata gustavobio master
   tpl gustavobio master
   osfr enterforopenscience master
   dataDownloader Between-the-Fjords master")

# check all packages downloaded 
# if this line doesn't work - assert that didn't install

assertthat::assert_that(all(c(CRAN_needed, github_needed$package) %in% .packages(all.available = TRUE)))

# clean-up
rm(CRAN_needed, CRAN_needed2, github_needed, installed_packages)