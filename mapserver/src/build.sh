#!/bin/bash
cd `dirname $0`

cat airphotos_by_year_header.kml > ../kml/airphotos_by_year.kml

let CURRENT_YEAR=`date +"%Y"`
let CURRENT_YEAR=2016
let FIRST_YEAR=1992
let year=CURRENT_YEAR

let currentDecade=(CURRENT_YEAR/10)*10
let currentDecadeTo=CURRENT_YEAR
sed \
  -e "s/##DECADE_FROM##/$currentDecade/" \
  -e "s/##DECADE_TO##/$currentDecadeTo/" \
  -e "s/##DECADE_VISIBLE##/1/" \
  airphotos_by_year_decade_header.kml >> ../kml/airphotos_by_year.kml
 
while ((year>=FIRST_YEAR)); do
  let yearVisible=0
  if [ $year -eq $CURRENT_YEAR ]; then
    yearVisible=1
  fi
  let decade=(year/10)*10
  let decadeTo=decade+9
  echo $year $decade $decadeTo
  if [ $year -eq $decadeTo ]; then
    let decadeVisible=0
    if [ $decade -eq $currentDecade ]; then
      decadeVisible=1
    fi
    sed \
      -e "s/##DECADE_FROM##/$decade/" \
      -e "s/##DECADE_TO##/$decadeTo/" \
      -e "s/##DECADE_VISIBLE##/$decadeVisible/" \
      airphotos_by_year_decade_header.kml >> ../kml/airphotos_by_year.kml
  fi
  sed \
    -e "s|##WMS_SERVICE_URL##|https://test.openmaps.gov.bc.ca/geo/pub/wms|" \
    -e "s/##PHOTO_YEAR##/$year/" \
    -e "s/##YEAR_VISIBLE##/$yearVisible/" \
    airphotos_by_year_year.kml >> ../kml/airphotos_by_year.kml
  if [ $year -eq $decade ]; then
    cat airphotos_by_year_decade_footer.kml >> ../kml/airphotos_by_year.kml
  fi
  
  let year--
done

cat airphotos_by_year_decade_footer.kml >> ../kml/airphotos_by_year.kml

cat airphotos_by_year_footer.kml >> ../kml/airphotos_by_year.kml
