library(markdown)

navbarPage(
  title = div(
    style = "display: flex; justify-content: space-between; align-items: center; width: 100%;",
    div("WFP COL | Sampling Tool", style="font-size: 25px; margin-top: 13px; margin-left: 0px; color: white; font-family: 'Open Sans';"), # Title on the left
  ),
  tags$head(
    tags$style(HTML("
        .navbar-default {
          background-color: #b1b1b3 !important;
        }
        .navbar .navbar-header .navbar-brand {
          padding-top: 0;
        }
        .navbar .navbar-header {
          flex-grow: 1;
        }
        .nav-tabs > li > a {
          font-size: 20px; /* Font size for tab titles */
          font-weight: bold; /* Make tab titles bold */}")),
    tags$style(
      ".btn-custom_5.active, .btn-custom_5:active, .btn-custom_5:focus, .btn-custom_5:hover {
      background: #B1B1B3 !important;
      color: #FFF !important;}",
      ".btn-custom_5 {border-color: #0D4A4F; color: #B1B1B3; background: #FFF; height: 5vh; font-size: 2.3vh !important; width: 28vh;}"
    ),
    tags$style(HTML("
      #rightLogo {
        height: 50px; /* Maintain the logo height */
        padding: 0px 0px 0px 0; /* Adjust padding as needed */
        float: right; /* Float right to keep it to the right of the tabs */}")),
    tags$script(HTML("
      $(document).ready(function() {
        // Create the logo image element
        var logoHtml = '<img src=\"wfp_logo.png\" id=\"rightLogo\">';
        // Append the logo to the navbar container
        $('.navbar .container-fluid').append(logoHtml);});"))
  ),
  
  windowTitle = "PMA COL | Herramienta de Muestreo",
           
           tabPanel("Introduction",
                    fluidRow(
                      column(width = 1),
                      column(width = 11,
                      h1("Brief overview of the tool"),
                      align = "left"
                    )),
                    fluidRow(
                      column(1,
                             br()
                      ),
                      column(4,
                             h2("Mode of sampling"),	
                             p(strong("Enter sample size:"),"You can input the target sample size"),
                             p(strong("Sample size based on population:"),"The sample size will be based on confidence level, error margin and proportion"),
                             
                             h2("Type of sampling"),
                             
                             p(strong("Random sampling:"),"Simple Random sampling, a random sample directly from the sampling frame which consists of every unit in the population of interest, thus ensuring equal probability of each unit to be selected."),
                             p(strong("Simple random - allocation:"),"Allocates surveys based on the size of the unit provided (e.g. cities), to use if the information about each unit of analysis is missing."),
                             p(strong("Cluster sampling:"),"Clusters, or Primary Sampling Units (PSUs), are first randomly selected, before a set number of units (e.g. households) at each cluster is randomly selected."),
                             p(strong("Stratified:"),"If ticked, a variable characterizing the stratification of the sampling will be ask to stratify the sample."),
                             
                             h2("Parameters"),
                             p(strong("Confidence level:"),"The desired confidence level."),
                             p(strong("Error Margin:"),"The desired error margin."),
                             p(strong("Proportion:"),"The expected proportion in the sample."),
                             p(strong("Buffer:"),"The desired percentage buffer."),
                             p(strong("Cluster size:"),"The minimum number of interviews to conduct by cluster."),
                             p(strong("ICC:"),"Intracluster  correlation : average value estimated in previous assessments = 0.06.")
                      ),
                      column(1,br()),
                      column(4,
                             h2("Loading files"),
                             p("The app takes only files .csv; each row of the csv need to be the primary sampling unit.",strong("The headers of the dataset must NOT contain special characters."),("You can use some example data by ticking 'example data'")),
                             p("When the files is loaded, depending of the type of sampling loaded before, some parameters will have to be specify:"),
                             p(strong("Cluster:"),"The variable including the name of each cluster, there should be no duplciates in this column."),
                             p(strong("Stratification:"),"The variable in the data defining the stratification."),
                             p(strong("Population:"),"The variable in the data defining the population number by PSU.",strong("Must be > 0 and > to cluster size")),
                             p(strong("When all this parameters are defined please press'Apply'.")),
                             
                             h2("Computing target"),
                             p("Under the target section will be compute the target based on the confidence level and margin error defined previously."),
                             p("Click Apply to compute the target"),
                             
                             h2("Sampling"),
                             p("When target appear in the tab, go to the 'Sampling tab' and click 'Sample!'. You can then download the list of units sampled and the sampling summary.")
                      )
                    )
           ),
  tabPanel("Sampling frame",
           column(width = 6,
                  fluidRow(
                    column(width = 2),
                    column(width = 8, align="center",
                           style="color: #B1B1B3; font-size: 3vh; font-weight: bold;",  # Add font-weight: bold
                           HTML('1) Define your sampling methodology:')
                    ),
                    column(width = 2)
                  ),
                  
                  fluidRow(
                    style = "margin-top: 4vh; margin-bottom: 0vh;",
                    column(width = 1),
                    column(width = 5,
                           radioGroupButtons(
                             inputId = "samp_type",
                             label = div(tags$span("Sampling Mode:", style = "color: #000000; font-size: 2.4vh;"), style = "text-align: center;"),
                             choices = c("Simple Random", "Simple random - allocation", "Cluster sampling"),
                             width = "95%",
                             individual = F,
                             status = "custom_5",
                             direction = "vertical")),
                    
                    column(width = 5,
                           radioGroupButtons(
                             inputId = "stratified",
                             label = div(tags$span("Stratification:", style = "color: #000000; font-size: 2.4vh;"), style = "text-align: center;"),
                             choices = c("Not Stratified", "Stratified"),
                             width = "95%",
                             individual = F,
                             status = "custom_5",
                             direction = "vertical")),
                    
                    column(width = 1)
                  ), #CLOSE FLUIDROW WITH SAMPLING METHODOLOGY INPUTS
                  
                  fluidRow(
                    style = "margin-top: 8vh; margin-bottom: 0vh;",
                    column(width = 2),
                    column(width = 8, align="center",
                           style="color: #B1B1B3; font-size: 3vh; font-weight: bold;",  # Add font-weight: bold
                           HTML('2) Upload your population dataset:')
                    ),
                    column(width = 2)
                  ),
                  
                  fluidRow(
                    style = "margin-top: 0vh; margin-bottom: 0vh;",
                    column(width = 2),
                    column(width = 8, align="center",
                           fileInput('popdata', '',accept=c('text/csv', 'text/comma-separated-values,text/plain'))),
                    column(width = 2)
                  ),
                  
                  fluidRow(
                    style = "margin-top: 1vh; margin-bottom: 0vh;",
                    
                    actionButton("f_apply", "Apply",width ="300",style="color: #fff; background-color: #B1B1B3; border-color: #B1B1B3"),
                    align = "center"
                  ),
                  
                  fluidRow(
                    style = "margin-top: 8vh; margin-bottom: 0vh;",
                    
                    DT::dataTableOutput("target_frame")
                  )
                  
                  ), #CLOSE COLUMN ON THE LEFT
           
           
           column(width = 6,
                  fluidRow(
                  style = "margin-top: 0vh; margin-bottom: 0vh;",
                  column(width = 2),
                  column(width = 8, align="center",
                         style="color: #B1B1B3; font-size: 3vh; font-weight: bold;",  # Add font-weight: bold
                         HTML('3) Define your sampling parameters:')),
                  column(width = 2)
                  ),
                  
                  fluidRow(
                    style = "margin-top: 4vh; margin-bottom: 0vh;",
                    column(width = 1),
                    column(width = 5,
                           numericInput('conf_level', 'Confidence level:',0.95,min=0.70,	max=0.99, step =0.005)),
                    column(width = 5,
                           numericInput('e_marg', 'Margin of Error:',0.05,min=0.01,	max=0.25, step =0.005))
                  ),
                  
                  fluidRow(
                    style = "margin-top: 1vh; margin-bottom: 0vh;",
                    column(width = 1),
                    column(width = 5,
                           numericInput('pror', 'Proportion',0.5,min=0.01,	max=1, step =0.05)),
                    column(width = 5,
                           numericInput('buf', 'Buffer',0.05,min=0.00,	max=0.50, step =0.01))
                  ),
                  
                  conditionalPanel(condition = "input.samp_type == 'Cluster sampling'",
                                   fluidRow(
                                     style = "margin-top: 1vh; margin-bottom: 0vh;",
                                     column(width = 1),
                                     column(width = 5,
                                            numericInput('cls', 'Cluster size',5,min=2, step =1)),
                                     column(width = 5,
                                            numericInput('ICC', 'ICC',0.06,min=0.01,	max=0.5, step =0.01))
                                   )
                  ),
                  
                  
              conditionalPanel(condition = "input.samp_type == 'Cluster sampling'|| input.samp_type =='Simple random - allocation' || input.stratified=='Stratified'",
                                   
                  fluidRow(
                    style = "margin-top: 8vh; margin-bottom: 0vh;",
                    column(width = 2),
                    column(width = 8, align="center",
                           style="color: #B1B1B3; font-size: 3vh; font-weight: bold;",  # Add font-weight: bold
                           HTML('4) Define your sampling frame:')),
                    column(width = 2)
                  ),
                  
                  fluidRow(
                    style = "margin-top: 1vh; margin-bottom: 0vh;",
                    column(width = 1),
                    column(width = 5,
                           conditionalPanel(condition = "input.samp_type == 'Cluster sampling'|input.samp_type =='Simple random - allocation'",
                                            selectInput('colpop', 'Input population', choices = NULL)
                           )),
                    column(width = 5,
                           conditionalPanel(condition = "input.samp_type == 'Cluster sampling'",
                                            selectInput('col_psu', 'Input cluster', choices = NULL)
                           ))
                  ),
                  
                  fluidRow(
                    style = "margin-top: 1vh; margin-bottom: 0vh;",
                    column(width = 1),
                    column(width = 5,
                           conditionalPanel(condition = "input.stratified=='Stratified'",
                                            selectInput('strata', 'Input strata', choices = NULL, multiple = F)
                           )),
                    column(width = 5)
                  )
                  
              )
                  
                  
                  ), #CLOSE COLUMN ON THE RIGHT
           
  ),
  
  
           tabPanel("Sampling", 
                    sidebarLayout(
                      sidebarPanel(width = 2, align = "center",
                               fluidRow(
                                 style = "margin-top: 0.5vh; margin-bottom: 0vh;",
                                 actionButton("desButton", "Sample!",width ="95%",style="color: #fff; background-color: #B1B1B3; border-color: #B1B1B3"),
                               ),
                               fluidRow(
                                 style = "margin-top: 2vh; margin-bottom: 0vh;",
                                 downloadButton("downloadBtn2", "Download Summary")
                               ),
                               fluidRow(
                                 style = "margin-top: 2vh; margin-bottom: 0vh;",
                                 downloadButton("downloadBtn", "Download SAMPLE")
                               )
                        ),
                      
                      mainPanel(
                        fluidRow(
                          style = "margin-top: 0vh; margin-bottom: 0vh;",
                          column(width = 2),
                          column(width = 8, align="center",
                                 style="color: #B1B1B3; font-size: 4vh; font-weight: bold;",  # Add font-weight: bold
                                 HTML('Sampling Summary:')),
                          column(width = 2)
                        ),
                        DT::dataTableOutput("test_1"),

                        
                        fluidRow(
                          style = "margin-top: 5vh; margin-bottom: 0vh;",
                          column(width = 2),
                          column(width = 8, align="center",
                                 style="color: #B1B1B3; font-size: 4vh; font-weight: bold;",  # Add font-weight: bold
                                 HTML('Final Sample:')),
                          column(width = 2)
                        ),
                        DT::dataTableOutput("sampling_output")
                      )
                    )
           ),
  div(
    style = "display: flex; justify-content: space-between; align-items: center; width: 100%;",
    img(src = 'wfp_logo.png', style = "height: 60px; margin-left: 12vw; padding-right: 10px; padding-bottom: 13px; padding-top: 0.4vh;") # Logo on the right
    # Title on the left
  )
) #CLOSE NAVBARPAGE


