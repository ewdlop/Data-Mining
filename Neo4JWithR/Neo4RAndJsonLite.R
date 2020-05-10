install.packages("neo4r")
library(neo4r)
con <- neo4j_api$new(
  url = "http://localhost:7474", 
  user = "neo4j", 
  password = "1"
)

library(magrittr)
'MATCH (a:Airport) RETURN a;' %>%
  call_neo4j(con)


tmp <- tempfile(fileext = ".json")
'MATCH (p:Plane) RETURN p.name LIMIT 10' %>%
  call_neo4j(con, output = "json") %>%
  write(tmp)


install.packages("jsonlite", repos="http://cran.r-project.org")
library(jsonlite)
jsonlite::read_json(tmp)

Luke <- fromJSON("https://swapi.dev/api/people/1/")