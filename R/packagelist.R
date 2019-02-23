#' Helper Functions blatantly copied from reprex package
#'
#' @description Following functions are used to get text from the current selection
#' in your Rstudio
#' @param context extract Rstudio context

# blatantly copied from
# https://github.com/tidyverse/reprex/blob/master/R/reprex-addin.R

rstudio_selection <- function(context = rstudio_context()) {
  text <- rstudioapi::primary_selection(context)[["text"]]
  text
}

#' Helper Functions blatantly copied from reprex package
#'
#' @description Following functions are used to get text from the current selection
#' in your Rstudio


rstudio_context <- function() {
  rstudioapi::getSourceEditorContext()
}

#' To wrap up the selected text with install.packages()
#'
#' @description Selected Text from RStudio (Current Selection) is reformatted to
#' include install.packages
#' @param text the selected text from RStudio - default is library(tidyverse)


wrap_it_up <- function(text = "library('tidyverse')"){
  paste0("install.packages(c('",
         paste(gsub("library|require|\\(|\\)","",
                    unlist(strsplit(text,"\\n"))),
               collapse = "','"),"'))") -> pkg_list
  #rstudioapi::insertText(Inf, pkg_list)
  rstudioapi::sendToConsole(pkg_list, execute = FALSE)

}


#' Gives the text to install packages
#'
#' @description `pkgs_list()` is an
#'   [addin](http://rstudio.github.io/rstudioaddins/) that creates you code
#'   to install the selected packages from existing code. Appears as "Reprex selection"
#'   in the RStudio Addins menu. Heavy users might want to [create a keyboard
#'   shortcut](https://support.rstudio.com/hc/en-us/articles/206382178-Customizing-Keyboard-Shortcuts).
#'
#' @export
PkgsToInstall <- function(){
  wrap_it_up(rstudio_selection())
}
