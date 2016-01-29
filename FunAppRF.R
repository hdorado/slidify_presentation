
library(ggplot2)
library(datasets)

ggdescriptive <- function(dataSet,varOpc1,varOpc2)
{   
 
    if(sum(names(dataSet)%in% varOpc1) != 1 |  sum(names(dataSet)%in% varOpc2) != 1 ){return(NULL)}
        
    tme <- theme_bw() +theme(legend.position="none")+
        theme(axis.title.x = element_text(size = 12),
            axis.title.y = element_text(size = 12),
            axis.text.x =  element_text(size = 12),
            axis.text.y =  element_text(size = 12,angle = 90, hjust = 0.5))

    varsToPlot        <- dataSet[c(varOpc1,varOpc2)]
    names(varsToPlot) <- c("x","y")      

    if(!is.factor(dataSet[varOpc1][,1]))
    {    
        lows <- with(varsToPlot,lowess(y~x))
        lowsMat <- data.frame(x=lows$x,y=lows$y)
    
       gf <- ggplot(varsToPlot,aes(x=x,y=y))+geom_point(colour="grey4",fill="blue",
        size=4,shape = 21,alpha =0.6)+tme+geom_line(aes(x=x,y=y),lwd=1.3,
        col="red", data=lowsMat)+xlab(varOpc1)+ ylab(varOpc2)
        
    }else{
    
    gf <- ggplot() + geom_boxplot(aes(x=x,y=y),data=varsToPlot,binaxis = "y",
                            stackdir = "center",colour="grey4", fill="aquamarine",
                            na.rm=T)+ylab(varOpc2)+
        xlab(varOpc1)+tme+ theme(axis.text.x = element_text(angle = 45, 
                                                            hjust = 1)) 
    }
    print(gf)
}



importRelevance <- function(dataSet)
{

dataSet <- dataSet[,-1]

exrf <- formula(paste(names(dataSet)[ncol(dataSet)],"~ ."))

rf <- randomForest(exrf ,data=dataSet,varImportance=T,
                   mtry = round((ncol(dataSet)-1)/3), ntree=600)

rsquare <- rf$rsq[length(rf$rsq)]*100

rfImportance    <- rf$importance

#OPC 1

#StdRfImportance <- rfImportance/sum(rfImportance)*100

#OPC 2

#StdRfImportance <- rfImportance/max(rfImportance)*100

#OPC 3

StdRfImportance <- rfImportance/sum(rfImportance)*rsquare


Importance <- data.frame(Var=row.names(StdRfImportance),Imp=StdRfImportance)

ImpotanceSort <- Importance[order(Importance$IncNodePurity,decreasing=F),]

ImpotanceSort$Var <- factor(ImpotanceSort$Var,levels=ImpotanceSort$Var)

m <- ggplot(ImpotanceSort, aes(x=Var, y=IncNodePurity))
m <- m + geom_bar(stat="identity", width=0.5, fill="slategray1",colour="gray3")+
    geom_hline(yintercept = 0)+ ylab("Mean importance")+  coord_flip() +
    theme_bw() +ggtitle(paste("Importance of variables \n(with a mean R2 of",
                              round(rsquare,4), "%)")) +theme(plot.title = element_text(size = 12, 
                                                        face = "bold", colour = "black", vjust = 1.5),
                                                        axis.text.y =element_text(size = 12),
                                                        axis.text.x =element_text(size = 12),
                                                        axis.title.x = element_text(size = 12),
                                                        axis.title.y = element_text(size = 12))

return(suppressWarnings(print(m)))

 }
