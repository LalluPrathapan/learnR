#GIS in R (adapted from Fundamentals of GIS using R and QGIS by Shammunul Islam)
# Plotting point data
#Location is a point characterized by its coordinates

# In R sp package loads shapefile as Spatial points and if it contains
#attributes, it is saved as SpatialPointsDataframe

# Importing of shapefile into R is using the readOGR() function of sp package
#path is the first parameter and the name of the shapefile is second

library(sf)
library(sp)
#Spatial points

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

head(map_bd@data)
str(map_bd@data)
head(map_bd@polygons)
str(map_bd@polygons,max.level = 2)

# we can access the lists' slots using @ and any of the five slots 
# access the 6th element of the map_bd

#6th element in the polygons slot of map_bd
sixth_element=map_bd@polygons[[6]]
sixth_element
#make it succinct with max.level=2 in str() for the 6th element of the bd@Polygons
str(sixth_element,max.level = 2)
# structure of the 2nd polygon inside sixth element
str(sixth_element@Polygons[[2]],max.level = 2)

#acessing the coordinate slot 
#plot() the coords slot of the 2nd element of the sixth polygon slot
plot(sixth_element@Polygons[[2]]@coords)


#acesssing the data elements of SpatialPolygonsdataFrame we can use
# either $ or [[]] as we can do with a dataframe

#acessing the column or attribute Name_3
map_bd$NAME_3
###or
map_bd[["NAME_3"]]


## Add point data on polygon data
#step 1: we plot the SpatialPolygonsDataFrame
#step 2: add the SpatialPointsDataFrame using points()

plot(map_bd)
points(bd_val,pch=19,col="blue")


#Changing projection system
# to change projection we use spTransform() from rgdal package. 
# this can be using the CRS() argument inside spTransform()":
# didn't work map_bd=spTransform(map_bd, CRS("+init=epsg:26978"))
# the sp package is replaced mostly with the sf package now ,but sp is still in use


st_crs(map_bd) # gets the coordinate reference system

proj4string(map_bd) <- CRS("+proj=longlat +datum=WGS84")


#Plotting quantitative and qualitative data on a map
# to show the quantitative values  in a geographical area it is good to use choropleth
#ggplot gives ways to plot a choropleth
#also basic R plot can be used

#basic plot choropleth
plot(map_bd,xlim=c(88.01,93.41) , ylim=c(21.34,26.38),col= as.numeric(map_bd$value2),bg = "#A6CAE0")

#choropleth using ggplot
#as ggplot uses a dataframe as input there is a additional step to follow
#It is possible to make the convertion using the tidy function of the broom package as shown below.

# I need to fortify the data AND keep trace of the commune code! (Takes ~2 minutes)


#Building up a SpatialPolygons from scratch.

# create polyon objects from coordinates.  Each object is a single geometric
# polygon defined by a bounding line.
house1.building <- Polygon(rbind(c(1, 1), c(2, 1), c(2, 0), c(1, 0)))

house1.roof <- Polygon(rbind(c(1, 1), c(1.5, 2), c(2, 1)))

house2.building <- Polygon(rbind(c(3, 1), c(4, 1), c(4, 0), c(3, 0)))

house2.roof <- Polygon(rbind(c(3, 1), c(3.5, 2), c(4, 1)))

house2.door <- Polygon(rbind(c(3.25, 0.75), c(3.75, 0.75), c(3.75, 0), c(3.25, 
                                                                         0)), hole = TRUE)

# create lists of polygon objects from polygon objects and unique ID A
# `Polygons` is like a single observation.
h1 <- Polygons(list(house1.building, house1.roof), "house1")
h2 <- Polygons(list(house2.building, house2.roof, house2.door), "house2")

# create spatial polygons object from lists A SpatialPolygons is like a
# shapefile or layer.
houses <- SpatialPolygons(list(h1, h2))
plot(houses)


