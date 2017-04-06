# dbc-kml-apps
DataBC KML Applications and Templates

Creating a custom output type in GeoServer using XSLT
-----------------------------------------------------

 To create a custom output type in GeoServer using XSLT, you need to define two files:

     a. A custom output type declaration file

     b. A custom output transformation file

 Each pair of custom output files should specify the transformation of one and only one feature class 

 A custom output type declaration file should be named <formatName><featureClass>.xml (e.g., kayml-geodetic-control.xml)
    where <formatName> is "kayml-"
      and <featureClass> is a meaningful contraction of the featureClass name in the BC Geographical Wherehouse
    
 A custom output transformation file should be named <formatName><featureClass>.xslt (e.g., kayml-geodetic-control.xslt)
 
 Here is an example request for a custom output type called kayml-geodetic-control.xml:
 
    http://delivery.openmaps.gov.bc.ca/geo/pub/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=pub:WHSE_REFERENCE.MASCOT_GEODETIC_CONTROL&maxFeatures=50&outputFormat=kayml-geodetic-control&srsname=EPSG:4326
 
 Given a feature class called WHSE_REFERENCE.MASCOT_GEODETIC_CONTROL, the custom output type declaration file is named [kayml-geodetic-control.xml](https://github.com/mraross/dbc-kml-apps/blob/master/xslt/kayml-geodetic-control.xml) and has the following contents:

 ```html
 <transform>
     <sourceFormat>text/xml; subtype=gml/2.1.2</sourceFormat>
     <outputFormat>kayml-geodetic-control</outputFormat>
     <outputMimeType>application/vnd.google-earth.kml+xml</outputMimeType>
     <fileExtension>kml</fileExtension>
     <xslt>kayml-geodetic-control.xslt</xslt>
     <featureType>
       <id>pub:WHSE_REFERENCE.MASCOT_GEODETIC_CONTROL</id>
     </featureType>
   </transform>     
 ```   
  
 For an example of a custom output type transformation file, see [kayml-geodetic-control.xslt](https://github.com/mraross/dbc-kml-apps/blob/master/xslt/kayml-geodetic-control.xslt)
 
