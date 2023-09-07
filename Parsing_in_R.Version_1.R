library(rvest)
library(httr)




# Загружаем html страницу:
simpl_html <- read_html('https://doker.ru/catalog/napolnye_pokrytiya/')

list_of_links_napoln_pokr <- c('https://doker.ru/catalog/napolnye_pokrytiya/',
                               paste0('https://doker.ru/catalog/napolnye_pokrytiya/?PAGEN_2=', c(2:82)))

# Преобразуем в XML:
XML_list_of_links_napoln_pork <- for (i in list_of_links_napoln_pokr){
  x[i] <- parseURI(i)
}

html_napoln_pokr <- read_html(for (i in list_of_links_napoln_pokr[c(1:3)]) {
  Sys.sleep(5)
})




date_node_css_name <- html_nodes(x = XML_list_of_links_napoln_pork, css = 'body > div > div > div > div > section') %>%
  html_nodes(., css = 'div > div > div > div > a > div > span')


html_text <- html_text(date_node_css_name)

html_text

start_time <- Sys.time()  

Sys.sleep(5)

end_time <- Sys.time() 

time_needed <- end_time - start_time 
  
time_needed 
  




for (i in pages_list_napoln_pokr[c(1,2)]) {
  Sys.sleep(5)
}



x1 parseURI("https://www.omegahat.net:8080/RCurl/index.html")

