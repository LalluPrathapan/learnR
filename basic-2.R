#GIS in R (adapted from Fundamentals of GIS using R and QGIS by Shammunul Islam)
# Plotting point data
#Location is a point characterized by its coordinates

# In R sp package loads shapefile as Spatial points and if it contains
#attributes, it is saved as SpatialPointsDataframe

# Importing of shapefile into R is using the readOGR() function of sp package
#path is the first parameter and the name of the shapefile is second

library(sf)
#Spatial points
library(sp)
library(rgdal)
library(maptools)
map=readOGR("D:/EAGLE/MB2/learnR/learnR","indicator.csv")
indicator
plot(indicator)
class(indicator)

#Importing point data from excel

bd_val=read.csv("r_val.csv",stringsAsFactors = FALSE)
str(bd_val)

# we see that bd_val is dataframe this can be converted into spatialpointsdataframe
#by using coordinates() and specifying which columns contain the long and lat

#convert into spatialPointDataframe
coordinates(bd_val)=c("lon","lat")
str(bd_val)
# plot using plot()
plot(bd_val,col="blue",pch=19)

#Plotting lines and polygons data in R
# line data in sp package are stored as SpatialLines class
#If it has attribute ir is saved as SpatialLineDataFrames
#similary polygon withour attribute the class is defined as SpatialPolygon
#with attribute the class is defined as SpatialPolygonsDataFrame

#Spatiallines

highway=readOGR("spatialline","dhaka_gazipur")
plot(highway)


#spatialpolygon

map_dhaka=readOGR("spatialpolygon","dhaka")
plot(map_dhaka)
str(map_dhaka,max.level = 2)
#max.level=2 show a reduced or succinct structure

#looking at the structure it can be seen that map_dhaka contains:
#@data: it contains all the attribute information or it contain data
#@polygon: contain information on polygons or coordinates
#@bbox: contain information on the extent of the map or coordinates of 
#2coorners of the bounding box
#totatl of 5slots and each can be accessed using @


#Import another database of shapefile direclty from github using Sf package
# we can use st_read for this
#You can use GDAL Virtual File Systems with sf::st_read(), 
#the one for reading files over HTTP & FTP is /vsicurl/ and 
#apparently it's capable enough to figure out which additional files it should pull to make Shapefiles work:
shp=st_read("/vsicurl/http://wesleysc352.github.io/seg_s3_r3_m10_fix_estat_amost_val.shp")


#however the datafile we need couldn't be downloade so ???
map_bd=readOGR("bd_adm","BGD_adm3_data_re")
head(map_bd)
str(map_bd,max.level = 2)
