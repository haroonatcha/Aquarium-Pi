
#This is the r version of a function to turn kelvin values into rgb values
#original: https://tannerhelland.com/2012/09/18/convert-temperature-rgb-algorithm-code.html
#some re-arranging was done to minimize code

k_to_rgb <- function(k) {
  #if super orange, do the lowest orange it can be
  if(k < 1000) {
    k <- 1000
  } else {
    if(k > 4e4) {
      k <- 4e4
    }
  }
  
  #working with a scaled version fo kelvin
  k <- k/100
  
  #if under 6600k
  if(k <= 66) {
    red <- 255
    green <- 99.4708025861 * log(k) - 161.1195681661
    
    #blue has two conditions under 6600k
    if(k <= 19) {
      blue <- 0
    } else {
      blue <- 138.577312231 * log(k - 10) - 305.0447927307
    }
    
    #if over 6600k
  } else {
    red <- 329.698727446 * ((k - 60)^-0.1332047592)
    green <- 288.1221695283 * ((k - 60) ^ -0.0755148492)
    blue <- 255
  }
  
  #create rgb
  rgb <- c(red, green, blue)
  
  #rgb values are 0-255. If lower, 0. If higher, 255
  rgb[which(rgb < 0)] <- 0
  rgb[which(rgb > 255)] <- 255
  
  #rgb are integer values only
  rgb <- round(rgb)
  
  return(rgb)
}

k_to_rgb(1500)
