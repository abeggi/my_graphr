## app.R ##
source("libraries.R")
source("server_rv.R")


ui <- dashboardPage(
  dashboardHeader(title = "graphR."),
  dashboardSidebar(
    sidebarMenu(
      menuItem("RV Tools", tabName = "tab_rv", icon = icon("th-list"))
    )
  ),
  ## Body content
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "tab_rv",
              fluidPage(theme = "custom.css",
                        # Application title.
                        titlePanel("RV Tools Report per Var Group S.p.A. v.8"),
                        shinyjs::useShinyjs(),
                        
                        sidebarLayout(
                          sidebarPanel(
                            
                            textInput("title_rv", "Titolo", "Titolo del report"),
                            
                            textInput("author_rv", "Autore", "Autore del report"),
                            
                            fileInput("file_rv", "File Input", accept=c('.xlsx', '.xls', '.csv')),
                            
                            actionButton("Generate_rv","Genera report")
                          ),
                          
                          # Show a summary of the dataset and an HTML table with the
                          # requested number of observations. Note the use of the h4
                          # function to provide an additional header above each output
                          # section.
                          mainPanel(
                            
                            tabsetPanel(
                              # using iframe along with tags() within tab to display pdf with scroll, height and width could be adjusted
                              tabPanel("Report", 
                                       uiOutput("pdfview_rv")),
                              tabPanel("Istruzioni", includeMarkdown("instructions_rv.md"))
                            ),
                            plotOutput("progress_bar_rv", height = 1,width = 1)
                          )
                        )
              )
              
      )
    )
  )
)
server <- function(input, output) {
  server_rv(input, output)
}

shinyApp(ui, server)
