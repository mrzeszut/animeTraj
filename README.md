***
***

# animeTraj

Project of creating trajectory animation. Trajectories are generated using the hysplit model.

***
***

## Wprowadzenie

Poniższy projekt pozwala na wykonanie animacji trajektori wstecznych wygenerowanych przez model hysplit. Zawiera on przykładowe dane dla epizodu występowania wyskich stężeń pyłów zawieszonych w krakawie w okresie od 14 do 21 marca 2020 r. Trajektorie zostały wygenerowane za pomocą model [HYSPLIT](https://www.ready.noaa.gov/HYSPLIT.php). W celu obliczenia trajektorii wstecznych napływu zanieczyszczeń skorzystano z reanaliz meteorologicznych [ERA5 hourly data on pressure levels from 1979 to present ](https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-era5-pressure-levels?tab=overview)
and [ERA5 hourly data on single levels from 1979 to present](https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-era5-single-levels?tab=overview)
udostępnianych przez [CDS](https://cds.climate.copernicus.eu/#!/home). Dane pozyskanao za pomocą skryptu [hysplit_metdata](https://github.com/amcz/hysplit_metdata). Konwersję danych do formatu ARL wykonano za pomocą programu `era52arl`.

***

W ramach tego projektu będziemy korzystać z nastepujacych pakietów:

-   [devtools](https://github.com/r-lib/devtools)
-   [tidyverse](https://www.tidyverse.org/)
-   [gganimate](https://gganimate.com/articles/gganimate.html)
-   [ggmap](https://github.com/dkahle/ggmap)
-   [gapminder](https://github.com/jennybc/gapminder)
-   [gifski](https://github.com/r-rust/gifski)
-   [magic](https://github.com/ropensci/magick)


```{r}
if(!require("devtools")) install.packages("devtools")
if(!require("tidyverse")) install.packages("tidyverse")
if(!require("ggmap")) devtools::install_github("dkahle/ggmap")
if(!require("gganimate")) install.packages("gganimate")
if(!require("gapminder")) install.packages("gapminder")
if(!require("gganimate")) install.packages("gganimate")
if(!require("gapminder")) install.packages("gapminder")
if(!require("gifski")) install.packages("gifski")
```

**Uwaga!!!** - pakiet ggmap wymagama: złożenia konta w google, wygenerowania klucza api, uruchomienie odpowiednich usług. Szczegółowe informacje i odwołania znajdziecie na stronie [ggmap](https://github.com/dkahle/ggmap).

***







