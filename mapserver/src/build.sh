#!/bin/bash
cd `dirname $0`


let CURRENT_YEAR=`date +"%Y"`
let CURRENT_YEAR=2016
let FIRST_YEAR=1963
let year=CURRENT_YEAR
outFile=../kml/BCGov_Airphoto_Viewer_WMS.kml
let currentDecade=(CURRENT_YEAR/10)*10
let currentDecadeTo=CURRENT_YEAR

cat airphotos_by_year_header.kml > ../kml/airphotos_by_year.kml

cat airphoto_header.kml > $outFile

for file in $outFile ../kml/airphotos_by_year.kml; do
  sed \
    -e "s/##DECADE_FROM##/$currentDecade/" \
    -e "s/##DECADE_TO##/$currentDecadeTo/" \
    -e "s/##DECADE_VISIBLE##/1/" \
    airphoto_decade_header.kml >> $file
done

while ((year>=FIRST_YEAR)); do
  let yearVisible=0
  if [ $year -eq $CURRENT_YEAR ]; then
    yearVisible=1
  fi
  let decade=(year/10)*10
  let decadeTo=decade+9
  echo $year
  for file in $outFile ../kml/airphotos_by_year.kml; do
  
    if [ $year -eq $decadeTo ]; then
      let decadeVisible=0
      if [ $decade -eq $currentDecade ]; then
        decadeVisible=1
      fi
      sed \
        -e "s/##DECADE_FROM##/$decade/" \
        -e "s/##DECADE_TO##/$decadeTo/" \
        -e "s/##DECADE_VISIBLE##/$decadeVisible/" \
        airphoto_decade_header.kml >> $file
    fi
    sed \
      -e "s|##WMS_SERVICE_URL##|http://test.openmaps.gov.bc.ca/geo/pub/wms|" \
      -e "s/##PHOTO_YEAR##/$year/" \
      -e "s/##YEAR_VISIBLE##/$yearVisible/" \
      airphoto_year.kml >> $file
    if [ $year -eq $decade ]; then
      cat airphoto_decade_footer.kml >> $file
    fi
  done
  let year--
done

for file in $outFile ../kml/airphotos_by_year.kml; do
  cat airphoto_decade_footer.kml >> $file
  
done

cat airphoto_decades_footer.kml >> $outFile

cat airphoto_roll_frame.kml >> $outFile

cat search_tools.kml >> $outFile

cat bc_logo.kml >> $outFile

cat airphoto_footer.kml >> $outFile

cp $outFile ../kml/BCGov_Airphoto_Viewer.kml

cat airphotos_by_year_footer.kml >> ../kml/airphotos_by_year.kml
