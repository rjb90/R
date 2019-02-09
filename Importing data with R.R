# http://stat-computing.org/dataexpo/2009/the-data.html
# Download flights data
# The flights data is a well known data source representing 123 million flights over 22 years. 
# It consumes roughly 12 GiB of storage in uncompressed CSV format in yearly files.


list.of.packages <- c("R.utils", "rvest", "stringr", "foreach", "doParallel")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)


# Downloading data with R -------------------------------------------------

if(!file.exists("downloads")){
  dir.create("downloads")
}

tmp_dir <- tempdir() #Creo un archivo temporal

tmp_file <- file.path(tmp_dir, '2007.csv')

#Descarga de documentos de una url (si le pongo una url me descarga el fichero):
download.file('http://stat-computing.org/dataexpo/2009/2007.csv.bz2', tmp_file) 
library(R.utils) # for bunzip2
bunzip2(tmp_file, "downloads/2007.csv", remove = FALSE, skip = TRUE)
#bunzip2 se usa para leer fragmentos del archivo bzip2 que luego se escriben en el archivo de salida

# Checks
file.info(tmp_file) #Downlaoded file
utils:::format.object_size(file.info("downloads/2007.csv")$size, "auto") #Uncompressed file size


# Web Scraping ------------------------------------------------------------

library(rvest) # for read_html, html_*, ...
library(stringr) # for str_*

page <- read_html("http://stat-computing.org/dataexpo/2009/the-data.html") 
#Para hacer web scrapping tenemos que coger la url que apunta al fichero zip que nos qeuremos descargar

(all_links <- html_nodes(page, "a")) #Con html_nodes puedo acceder a páginas y obtener atributos html
(linked_resources <- html_attr(all_links, "href")) #Me quiero quedar solo con los que tienen atributos href
(linked_bz2_files <- str_subset(linked_resources, "\\.bz2"))
(bz2_files_links <- paste0("http://stat-computing.org/dataexpo/2009/", linked_bz2_files))

(bz2_files_links <- tail(bz2_files_links, 2)) # Nos quedamos con sólo los dos primeros 

(num_files <- length(bz2_files_links))


# Custom download function

download_flights_datasets <- function (link) {
  
  cat(link, "\n")
  
  this_file_link <- link
  
  this_file_name <- str_extract(basename(this_file_link), "^.{0,8}")
  
  this_tmp_file <- file.path(tmp_dir, this_file_name)
  
  download.file(this_file_link, this_tmp_file)
  
  bunzip2(this_tmp_file, file.path('downloads', this_file_name), remove = FALSE, skip = TRUE)
}

# Testing download_flights_datasets 

( link <- bz2_files_links[1] )

download_flights_datasets(link)


# Downloading all files in parallel
library("foreach") # for foreach
library("doParallel") # for makeCluster, registerDoParallel


detectCores()

cl <- makeCluster(detectCores() - 1) # create a cluster with x cores
registerDoParallel(cl) # register the cluster

res <- foreach(i = 1:num_files, 
               .packages = c("R.utils", "stringr")) %dopar% {
                 this_file_link <- bz2_files_links[i]
                 download_flights_datasets(this_file_link)
               }
