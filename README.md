***
***

# animeTraj

Project of creating trajectory animation. Trajectories are generated using the hysplit model.

***
***

## Wprowadzenie

Poniższy projekt dotyczy tworzenia animacji trajektorii wstecznych. Zawiera on
przykładowe dane dla epizodu występowania wysokich stężeń pyłów zawieszonych w
Krakowie. W okresie od 14 do 21 marca 2020 r. Pokaże wam jak utworzyć animacje
wyświetlające określoną liczbę trajektorii. W tym celu przejdziemy krok po kroku
w celu poznania odpowiednich funkcji i pakietów. Następnie napiszemy funkcję,
która pozwoli nam w łatwy sposób generować animację. Na końcu napiszemy pętle,
która będzie tworzyć wiele animacji na raz.

Trajektorie zostały wygenerowane za pomocą modelu
[HYSPLIT](https://www.ready.noaa.gov/HYSPLIT.php). W celu obliczenia trajektorii
wstecznych skorzystano z re-analiz meteorologicznych [ERA5 hourly data on
pressure levels from 1979 to
present](https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-era5-pressure-levels?tab=overview)
and [ERA5 hourly data on single levels from 1979 to
present](https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-era5-single-levels?tab=overview)
udostępnianych przez [CDS](https://cds.climate.copernicus.eu/#!/home).

Dane **ERA5** pozyskano za pomocą skryptu
[hysplit_metdata](https://github.com/amcz/hysplit_metdata). Konwersję danych do
formatu ARL wykonano za pomocą programu **era52arl**. Program ten udostępniany
jest wraz z modelem hysplit (w dystrybucji na systemy operacyjne linux).

Oprócz danych z modelu hysplit [traj_data_krk.RData](...) znajdziecie również
dane o jakości powietrza na stacji
[bujaka](http://powietrze.gios.gov.pl/pjp/current/station_details/info/401) i
wybrane parametry meteorologiczne pozyskane z stacji [ZFS, WFiIS, AGH w
Krakowie](http://meteo.ftj.agh.edu.pl/).

***

**Zalecam w pierwszej kolejności pobranie całego repozytorium**

***
***

## Przewodnik

W repozytorium znajduje się plik o nazwie **animeTraj_guide_pl.html**. Zawiera szczegółową instrukcje jak stworzyć poniższą animację trajektorii wstecznych. Miłej zabawy. Pozdrawiam

![](traj.gif)<!-- -->

***
***








