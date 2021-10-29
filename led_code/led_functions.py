import math
import ws281x

#a kelvin to rgb function
#original: https://tannerhelland.com/2012/09/18/convert-temperature-rgb-algorithm-code.html

def k_to_rgb(k):
    #floor/ceiling extreme values
    if k < 1000:
        k = 1000
    if k > 40000:
        k = 40000
        
    k = k/100
    
    #rgb below 6600k
    if k <= 66:
        red = 255
        green = 99.4708025861 * math.log(k) - 161.1195681661
        
        #blue has two cases
        if k <= 19:
            blue = 0 
        else:
            blue = 138.577312231 * math.log(k - 10) - 305.0447927307
    
    #rgb above 6600k
    else:
        red = 329.698727446 *  math.pow(k - 60, -0.1332047592)
        green = 288.1221695283 * math.pow(k - 60, -0.0755148492)
        blue = 255
    
    #coerce to list of integers
    rgb = [red, green, blue]
    rgb = [int(x) for x in rgb]
    
    #floor/ceiling
    rgb = [0 if x < 0 else x for x in rgb]
    rgb = [255 if x > 255 else x for x in rgb]
    
    return rgb

#takes kelvin and outputs rgb values mediated by a brightness variable 0-1
def k_to_color(k, brightness = 1):
    output =[x*brightness for x in k]
    
    output = [int(x) for x in output]
    
    return output