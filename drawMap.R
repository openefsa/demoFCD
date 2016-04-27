library(RColorBrewer)
library(maptools)
library(ggplot2)
library(tmap)
library(efsagis)


data(World)
eu_countries <- c("AL", "AD", "AT", "BY", "BE", "BA", "BG", "HR", "CY", "CZ", "DK",
                 "EE", "FO", "FI", "FR", "DE", "GI", "GR", "HU", "IS", "IE", "IT", "LV", "LI", "LT", "LU", "MK", "MT",
                 "MC", "NL", "NO", "PL", "PT", "RO", "SM", "RS", "SK", "SI", "ES", "SE", "CH", "GB", "VA", "RS", "IM", "RS", "ME")


plotme <- function(ddf,foodName) {
    

    ##wrld_simpl@data$id <- wrld_simpl@data$NAME
    ##europe <- wrld_simpl[wrld_simpl@data$ISO2 %in% eu_countries,]
    europe <- World[World@data$continent == "Europe",]
    europe@data$id <- europe@data$name
    europe <- europe[!europe@data$name %in% c("Ukraine","Russia"), ]
    europe <- fortify(europe, region="id")
    
    gg <- ggplot() + ggtitle(paste0("Consumption of ",foodName," in Europe"))
    

                                        # setup base map
    gg <- gg + geom_map(data=europe, map=europe, aes(map_id=id, x=long, y=lat), fill="white", color="#7f7f7f", size=0.25)

    gg <- gg + labs(x="", y="")
    gg <- gg + theme(plot.background = element_rect(fill = "transparent", colour = NA),
                    panel.border = element_blank(),
                    panel.background = element_rect(fill = "transparent", colour = NA),
                    panel.grid = element_blank(),
                    axis.text = element_blank(),
                    axis.ticks = element_blank(),
                    legend.position = "right")
   
    if(nrow(ddf) == 0) {
        return(gg)
    } else {
        
        ddf$value <- jitter(ddf$value+0.1) 

        ddf$brk <- cut(ddf$value, 
                      breaks=c(0, sort(ddf$value)), 
                      labels=paste0(as.character(ddf[order(ddf$value),]$Country)," - ",round(sort(ddf$value),4)),
                      include.lowest=TRUE)

                                        # add our colored regions
        gg <- gg + geom_map(data=ddf, map=europe, aes(map_id=Country, fill=brk),  color="#7f7f7f", size=0.25)
  
                                        # this sets the scale and, hence, the legend
        gg <- gg + scale_fill_manual(values=colorRampPalette(brewer.pal(9, 'Reds'))(length(ddf$value)),   name="mean consumptions g/day")

                                        # this gives us proper coords. mercator proj is default
                                        #gg <- gg + coord_map()
        gg
    }

}
