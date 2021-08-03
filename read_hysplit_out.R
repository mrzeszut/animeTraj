

library(tidyverse)
library(stringr)
library(lubridate)



# Funkcja Wczytywanie danych z pliku ---------------------------------------------------------------

# File = nazwa pliku z ścieżką

hy_read <- function(file){

    kodowanie <- c(rep(6,8), 8, rep(9,6))
  
    nazwy_kol <- c("receptor", "rec2", 
                   "year", "month", "day", "hour", 
                   "bb1", "bb2", "hour.inc", 
                   "lat", "lon", "height", 
                   "pressure", "mixdepth", "terr_msl")
    
    hy_out <- read.fwf(file = file, 
                       widths = kodowanie, 
                       col.names = nazwy_kol,
                       header = F, 
                       skip = 11) %>% 
      as_tibble() %>% 
      select(-rec2, -bb1, -bb2) %>% 
      mutate(date2 = make_datetime(year = 2000 + year, 
                                   month = month, 
                                   day = day, 
                                   hour = hour, tz = "GMT"), 
             date  = date2 - (hour.inc * 3600))
    
    cat(file, "\n")
    
    return(hy_out)
}

# PETLA --------------------------------------------------------------------------------------------

# identyfikujemy nazwy plików danych i dodajemy katalog do nazw

pliki <- dir("2010/")[dir("2010/") %>% str_detect(pattern = ".out")] 

pliki <- paste0("2010/", pliki)

# pętla wczytywania danych instrukcja w załczniku 
# browseURL(url = "http://jenrichmond.rbind.io/post/use-map-to-read-many-csv-files/")

a <- Sys.time()

dane <- pliki %>% 
  purrr::map(hy_read) %>% reduce(rbind)

a - Sys.time()

save(dane, file = "trajektorie_2010_era5.RData")


# identyfikujemy nazwy plików danych i dodajemy katalog do nazw

setwd("Y:/Output_hysplit/")

pliki <- dir("2020/")[dir("2020/") %>% str_detect(pattern = ".out")] 

pliki <- pliki[-length(pliki)]
pliki %>% tail()
pliki <- paste0("2020/", pliki)

# pętla wczytywania danych instrukcja w załczniku 
# browseURL(url = "http://jenrichmond.rbind.io/post/use-map-to-read-many-csv-files/")

a <- Sys.time()

dane <- pliki %>% 
  purrr::map(hy_read) %>% reduce(rbind)

a - Sys.time()

save(dane, file = "D:/read_hy2R/trajektorie_2020_era5.RData")


