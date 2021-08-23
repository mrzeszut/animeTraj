


if(!require("tidyverse")) install.packages("tidyverse")
if(!require("lubridate")) install.packages("lubridate")
if(!require("stringr")) install.packages("stringr")



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

pliki <- dir("data/")[dir("data/") %>% str_detect(pattern = ".out")] 

pliki <- paste0("data/", pliki)

# pętla wczytywania danych instrukcja w załczniku 
# browseURL(url = "http://jenrichmond.rbind.io/post/use-map-to-read-many-csv-files/")

a <- Sys.time()

hy_data <- pliki %>% 
  purrr::map(hy_read) %>% reduce(rbind)

a - Sys.time()


hy_data <- dane
save(hy_data, file = "traj_data_krk.RData")


