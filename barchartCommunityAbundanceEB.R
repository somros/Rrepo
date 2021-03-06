# please correct all the biomass to abundances

library(ggplot2)
library(reshape)
setwd("C:/Users/Alberto/Documents/itn100results/input/finalInput")
data <- read.table("abundance.csv", header=TRUE, sep=';', dec='.')
colnames(data) <- c("Regime", "Total", "Smallpelagic", "Mediumpelagic", "Largepelagic", "Smalldemersal",
                    "Mediumdemersal", "Largedemersal", "Toppiscivores", "totsd", "spsd", "mpsd", "lpsd",
                    "sdsd", "mdsd", "ldsd", "tcsd")
data$Regime <- as.character(data$Regime)
#Then turn it back into an ordered factor
data$Regime <- factor(data$Regime, levels=unique(data$Regime))
meanValues <- data[,c(1:9)]
sdValues <- data[,c(1,10:17)]

meltmeanValues <- melt(meanValues, id.vars="Regime")
meltsdValues <- melt(sdValues, id.vars="Regime")
meltmeanValues$sd <- meltsdValues$value
meltAllData <- meltmeanValues

meltAllDataMod <- subset(meltAllData, variable!="Total")
meltAllDataMod$intensity <- rep(c("0", rep(c("1","2","3"),6)), 7)

normal_scientific<-expression(0, 10^5, 2*10^5, 3*10^5, 4*10^5) # notation to be used in the plot


# limits for the errorbars, sd

library(RColorBrewer)
par(mar = c(0, 4, 0, 0))
display.brewer.all()
brewer.pal(9, "Set1")

# new try

dodge <- position_dodge(0.9)

newPlot <- ggplot(data=meltAllDataMod, aes(x=Regime, y=value, fill=variable))+
        geom_bar(position=dodge, stat="identity")+
        geom_errorbar(aes(ymin=value-sd,ymax=value+sd),
                      position=dodge, width=0.1, size=0.3)+
        scale_x_discrete(name="Fishing regime")+
        scale_y_continuous(limits=c(0,250000),
                           breaks=seq(0,250000,25000), 
                           expand=c(0,0), labels=seq(0,250000,25000), "Community biomass [t]")+
        scale_fill_manual(name="Functional groups",
                          values=c("#377EB8", "#E41A1C", "#4DAF4A","#FF7F00","#984EA3","#999999","#F781BF"),
                          labels=c("Small pelagic", "Medium pelagic", "Large pelagic", "Small demersal",
                                   "Medium demersal", "Large demersals", "Top carnivores"))+
        
        #coord_trans(y="log10")+ need to get rid of the zeroes to do this one, pain in the ass
        theme(panel.background = element_rect(fill = 'white'))+
        #theme
        theme_bw()+
        theme(panel.grid.minor = element_blank(), 
              panel.grid.major = element_line(linetype="dashed"))+
        theme(axis.title.x = element_text(size=12,vjust=0.5),
              axis.title.y = element_text(size=12,vjust=0.5))+
        theme(legend.title = element_text(size=12))+
        theme(axis.text.x=element_text(size=12,angle=45,vjust=0.5))+
        theme(axis.text.y=element_text(size=12))


newPlot # hahaha nailed it kek

# by intensity

meltAllDataMod <- subset(meltAllData, variable!="Total")
meltAllDataMod$intensity <- rep(c("0", rep(c("1","2","3"),6)), 7)

# 10%

int10 <- ggplot(data=subset(meltAllDataMod, intensity=="0" | intensity=="1"), 
                aes(x=Regime, y=value, fill=variable))+
        geom_bar(position=dodge, stat="identity")+
        geom_errorbar(aes(ymin=value-sd,ymax=value+sd),
                      position=dodge, width=0.1, size=0.3)+
        scale_x_discrete(name="Fishing regime")+
        scale_y_continuous(limits=c(0,250000),
                           breaks=seq(0,250000,25000), 
                           expand=c(0,0), labels=seq(0,250000,25000), "Community biomass [t]")+
        scale_fill_manual(name="Functional groups",
                          values=c("#377EB8", "#E41A1C", "#4DAF4A","#FF7F00","#984EA3","#999999","#F781BF"),
                          labels=c("Small pelagic", "Medium pelagic", "Large pelagic", "Small demersal",
                                   "Medium demersal", "Large demersals", "Top carnivores"))+
        
        #coord_trans(y="log10")+
        theme(panel.background = element_rect(fill = 'white'))+
        #theme
        theme_bw()+
        theme(panel.grid.minor = element_blank(), 
              panel.grid.major = element_line(linetype="dashed"))+
        theme(axis.title.x = element_text(size=12,vjust=0.5),
              axis.title.y = element_text(size=12,vjust=0.5))+
        theme(legend.title = element_text(size=12))+
        theme(axis.text.x=element_text(size=12,angle=45,vjust=0.5))+
        theme(axis.text.y=element_text(size=12))


int10 

# 20%

int20 <- ggplot(data=subset(meltAllDataMod, intensity=="0" | intensity=="2"), 
                aes(x=Regime, y=value, fill=variable))+
        geom_bar(position=dodge, stat="identity")+
        geom_errorbar(aes(ymin=value-sd,ymax=value+sd),
                      position=dodge, width=0.1, size=0.3)+
        scale_x_discrete(name="Fishing regime")+
        scale_y_continuous(limits=c(0,250000),
                           breaks=seq(0,250000,25000), 
                           expand=c(0,0), labels=seq(0,250000,25000), "Community biomass [t]")+
        scale_fill_manual(name="Functional groups",
                          values=c("#377EB8", "#E41A1C", "#4DAF4A","#FF7F00","#984EA3","#999999","#F781BF"),
                          labels=c("Small pelagic", "Medium pelagic", "Large pelagic", "Small demersal",
                                   "Medium demersal", "Large demersals", "Top carnivores"))+
        
        #coord_trans(y="log10")+
        theme(panel.background = element_rect(fill = 'white'))+
        #theme
        theme_bw()+
        theme(panel.grid.minor = element_blank(), 
              panel.grid.major = element_line(linetype="dashed"))+
        theme(axis.title.x = element_text(size=12,vjust=0.5),
              axis.title.y = element_text(size=12,vjust=0.5))+
        theme(legend.title = element_text(size=12))+
        theme(axis.text.x=element_text(size=12,angle=45,vjust=0.5))+
        theme(axis.text.y=element_text(size=12))


int20 

# 50%

int50 <- ggplot(data=subset(meltAllDataMod, intensity=="0" | intensity=="3"), 
                aes(x=Regime, y=value, fill=variable))+
        geom_bar(position=dodge, stat="identity")+
        geom_errorbar(aes(ymin=value-sd,ymax=value+sd),
                      position=dodge, width=0.1, size=0.3)+
        scale_x_discrete(name="Fishing regime")+
        scale_y_continuous(limits=c(0,250000),
                           breaks=seq(0,250000,25000), 
                           expand=c(0,0), labels=seq(0,250000,25000), "Community biomass [t]")+
        scale_fill_manual(name="Functional groups",
                          values=c("#377EB8", "#E41A1C", "#4DAF4A","#FF7F00","#984EA3","#999999","#F781BF"),
                          labels=c("Small pelagic", "Medium pelagic", "Large pelagic", "Small demersal",
                                   "Medium demersal", "Large demersals", "Top carnivores"))+
        
        #coord_trans(y="log10")+
        theme(panel.background = element_rect(fill = 'white'))+
        #theme
        theme_bw()+
        theme(panel.grid.minor = element_blank(), 
              panel.grid.major = element_line(linetype="dashed"))+
        theme(axis.title.x = element_text(size=12,vjust=0.5),
              axis.title.y = element_text(size=12,vjust=0.5))+
        theme(legend.title = element_text(size=12))+
        theme(axis.text.x=element_text(size=12,angle=45,vjust=0.5))+
        theme(axis.text.y=element_text(size=12))


int50 

############################### total analysis because why not #############################

meltAllDataTot <- subset(meltAllData, variable=="Total")
meltAllDataTot$intensity <- c("0", rep(c("1","2","3"),6))

totPlot <- ggplot(data=meltAllDataTot, aes(x=Regime, y=value, fill=intensity, colour="black"))+
        geom_bar(position=dodge, stat="identity")+
        geom_errorbar(aes(ymin=value-sd,ymax=value+sd),
                      position=dodge, width=0.1, size=0.3)+
        scale_x_discrete(name="Fishing regime")+
        scale_y_continuous(limits=c(0,400000),
                           breaks=c(0,100000,200000,300000,400000), 
                           expand=c(0,0), labels=c(0,100000,200000,300000,400000), "Abundance [individuals]")+
        scale_fill_manual(name="Intensity",
                          values=c("white", "lightgrey", "darkgrey","black"),
                          labels=c("Unfished", "10%", "20%", "50%"))+
        scale_colour_manual(name="lmao",
                            values=rep("black",4))+
        
        #coord_trans(y="log10")+
        theme(panel.background = element_rect(fill = 'white'))+
        #theme
        theme_bw()+
        theme(panel.grid.minor = element_blank(), 
              panel.grid.major = element_line(linetype="dashed"))+
        theme(axis.title.x = element_text(size=12,vjust=0.5),
              axis.title.y = element_text(size=12,vjust=0.5))+
        theme(legend.title = element_text(size=12))+
        theme(axis.text.x=element_text(size=12,angle=45,vjust=0.5))+
        theme(axis.text.y=element_text(size=12))


totPlot 

ggsave("C:/Users/Alberto/Documents/LaTeX/latexdirectory/picsWP/abundanceBarchart.pdf", totPlot, useDingbats=FALSE ) # set better res pls

# tot by intensity

# 10%

totPlot10 <- ggplot(data=subset(meltAllDataTot, intensity=="0" | intensity=="1"),
                    aes(x=Regime, y=value, fill=intensity, colour="black"))+
        geom_bar(position=dodge, stat="identity")+
        geom_errorbar(aes(ymin=value-sd,ymax=value+sd),
                      position=dodge, width=0.1, size=0.3)+
        scale_x_discrete(name="Fishing regime")+
        scale_y_continuous(limits=c(0,400000),
                           breaks=seq(0,400000,25000), 
                           expand=c(0,0), labels=seq(0,400000,25000), "Community biomass [t]")+
        scale_fill_manual(name="Intensity",
                          values=c("white", "lightgrey", "darkgrey","black"),
                          labels=c("Unfished", "10%", "20%", "50%"))+
        scale_colour_manual(name="lmao",
                            values=rep("black",4))+
        
        #coord_trans(y="log10")+
        theme(panel.background = element_rect(fill = 'white'))+
        #theme
        theme_bw()+
        theme(panel.grid.minor = element_blank(), 
              panel.grid.major = element_line(linetype="dashed"))+
        theme(axis.title.x = element_text(size=12,vjust=0.5),
              axis.title.y = element_text(size=12,vjust=0.5))+
        theme(legend.title = element_text(size=12))+
        theme(axis.text.x=element_text(size=12,angle=45,vjust=0.5))+
        theme(axis.text.y=element_text(size=12))


totPlot10

# 20%

totPlot20 <- ggplot(data=subset(meltAllDataTot, intensity=="0" | intensity=="2"),
                    aes(x=Regime, y=value, fill=intensity, colour="black"))+
        geom_bar(position=dodge, stat="identity")+
        geom_errorbar(aes(ymin=value-sd,ymax=value+sd),
                      position=dodge, width=0.1, size=0.3)+
        scale_x_discrete(name="Fishing regime")+
        scale_y_continuous(limits=c(0,400000),
                           breaks=seq(0,400000,25000), 
                           expand=c(0,0), labels=seq(0,400000,25000), "Community biomass [t]")+
        scale_fill_manual(name="Intensity",
                          values=c("white", "lightgrey", "darkgrey","black"),
                          labels=c("Unfished", "10%", "20%", "50%"))+
        scale_colour_manual(name="lmao",
                            values=rep("black",4))+
        
        #coord_trans(y="log10")+
        theme(panel.background = element_rect(fill = 'white'))+
        #theme
        theme_bw()+
        theme(panel.grid.minor = element_blank(), 
              panel.grid.major = element_line(linetype="dashed"))+
        theme(axis.title.x = element_text(size=12,vjust=0.5),
              axis.title.y = element_text(size=12,vjust=0.5))+
        theme(legend.title = element_text(size=12))+
        theme(axis.text.x=element_text(size=12,angle=45,vjust=0.5))+
        theme(axis.text.y=element_text(size=12))


totPlot20

# 50%

totPlot50 <- ggplot(data=subset(meltAllDataTot, intensity=="0" | intensity=="3"),
                    aes(x=Regime, y=value, fill=intensity, colour="black"))+
        geom_bar(position=dodge, stat="identity")+
        geom_errorbar(aes(ymin=value-sd,ymax=value+sd),
                      position=dodge, width=0.1, size=0.3)+
        scale_x_discrete(name="Fishing regime")+
        scale_y_continuous(limits=c(0,400000),
                           breaks=seq(0,400000,25000), 
                           expand=c(0,0), labels=seq(0,400000,25000), "Community biomass [t]")+
        scale_fill_manual(name="Intensity",
                          values=c("white", "lightgrey", "darkgrey","black"),
                          labels=c("Unfished", "10%", "20%", "50%"))+
        scale_colour_manual(name="lmao",
                            values=rep("black",4))+
        
        #coord_trans(y="log10")+
        theme(panel.background = element_rect(fill = 'white'))+
        #theme
        theme_bw()+
        theme(panel.grid.minor = element_blank(), 
              panel.grid.major = element_line(linetype="dashed"))+
        theme(axis.title.x = element_text(size=12,vjust=0.5),
              axis.title.y = element_text(size=12,vjust=0.5))+
        theme(legend.title = element_text(size=12))+
        theme(axis.text.x=element_text(size=12,angle=45,vjust=0.5))+
        theme(axis.text.y=element_text(size=12))


totPlot50

#############################



maxInt <- subset(meltAllDataMod, intensity=="0" | intensity=="3")
maxInt$cheat <- maxInt$value+1

int50 <- ggplot(data=maxInt, aes(x=variable, y=cheat))+
        geom_bar(position=dodge, stat="identity", width=0.7)+
        geom_errorbar(aes(ymin=cheat,ymax=cheat+sd),
                      position=dodge, width=0.1, size=0.2)+
        scale_x_discrete(name="Functional groups",
                         labels=c(1:7))+
        scale_y_log10(limits=c(1,300000), expand=c(0,1),
                      breaks=c(10,100,1000,10000,100000),
                      "Community abundance [individuals]")+
        #coord_trans(y="log10")+
        theme(panel.background = element_rect(fill = 'white'))+
        #theme
        theme_bw()+
        theme(panel.grid.minor = element_blank(), 
              panel.grid.major = element_line(linetype="dashed"))+
        theme(axis.title.x = element_text(size=12,vjust=0.5),
              axis.title.y = element_text(size=12,vjust=0.5))+
        theme(legend.title = element_text(size=12))+
        theme(axis.text.x=element_text(size=12,vjust=0.5))+
        theme(axis.text.y=element_text(size=12))+
        facet_grid(. ~ Regime)


int50 

ggsave("C:/Users/Alberto/Documents/LaTeX/latexdirectory/picsWP/lastPlotA.pdf", int50, useDingbats=FALSE ) # set better res pls


