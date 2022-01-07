library("seqinr")
library("shiny")

ui <- fluidPage(
  title = "Mutation Visualization",

  titlePanel("Inspect Mutations"),
  sidebarLayout(
      sidebarPanel(
                
          helpText("Select alignment file (.aln) file to analyze:"),
          fileInput("file1", label = h3("File")),
          downloadButton('downloadF', 'Download example aln file'),
      h5("Discussion at ", shiny::a("labsolns.com", href="https://www.labsolns.com/software/mutvis/"))),
      
    mainPanel(

        h1("AA frequency vs. index"),
        h4("WT AA in red", style= "color:red"),
        h4("Mutations in black"),
        
      plotOutput( "plot1" )       
    )       
  )
)

server <- function(input, output) {
  alignspre <-  reactive({
    if(!is.null(input$file1)){
        infile <- input$file1
        l1.aln <- read.alignment(file= infile$datapath, format="clustal")
        alignsret <- as.matrix(l1.aln)
        alignsret
               
    } }) 

  output$downloadF <- downloadHandler(
      filename <- function() {
          paste("input", "aln", sep=".")
      },
      content <- function(file) {
          file.copy("abcdefgh/input.aln", file)      })    

  output$plot1 <- renderPlot({
      ##input$action
      aligns <- alignspre()
      levels(SEQINR.UTIL$CODON.AA$L)
      aas <- c(levels(SEQINR.UTIL$CODON.AA$L), 'X')
      freqs <- matrix(  ncol=dim(aligns)[2], nrow=length(aas))
      rownames(freqs) <- aas
        
      for( col in 1:dim(aligns)[2]){
          for( row in 1:length(aas)){
              freqs[row, col] <- length(which(toupper(aligns[,col])==aas[row]))/dim(aligns)[1]
          }
      }

        plot( which(freqs[7,]>0), freqs[7, freqs[7,]>0], pch=rownames(freqs)[7], ylab="Frequency", xlab="Position", cex=0.9)
        plot.window( xlim = c(1, dim(freqs)[2]), ylim= c(0,1),  ylab="Frequency", xlab="Position")

        for( i in 1:length(aas)){
            points( which(freqs[i,]>0), freqs[i, freqs[i,]>0], pch=rownames(freqs)[i], cex=0.9)
        }
        ref <-aligns[rownames(aligns)==rownames(aligns)[1],]

        for(i in 1:length(ref)){
            if(  length( freqs[rownames(freqs)[rownames(freqs)==toupper(ref[i])],i] ) > 0){
                if(freqs[rownames(freqs)[rownames(freqs)==toupper(ref[i])],i] > 0){
                    points( i,freqs[rownames(freqs)[rownames(freqs)==toupper(ref[i])],i]  , pch=toupper(ref[i]), cex=0.9, col="red")
                }
            }
        }           
  })  
}

#app <- shinyApp(ui = ui, server = server)
#runApp(app, host="0.0.0.0", port=3301)
shinyApp(ui = ui, server = server)
