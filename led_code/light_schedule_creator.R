min_k = 2500
max_k = 7500
hours_on = 6
midday = 12
ramp_duration = 1

#create the base dataframe at hour/minute level
template_df <- function() {
  temp <- expand.grid(0:23, 0:59)
  colnames(temp) <- c('hour', 'minute')
  temp <- temp[order(temp$hour),]
  temp$k_values <- NA
  temp$brightness <- NA
  return(temp)
}

#create the final df
create_lighting_df <- function(min_k = 2500, max_k = 7500,
                               hours_on = 6, midday = 12,
                               ramp_duration = 1) {
  #from-to values between min and max k
  ramp <- seq(from = min_k,
              to = max_k,
              length.out = ramp_duration*60)
  
  #get K values for all day
  k_values <- c(
    rep(min_k, ramp_duration * 60),
    ramp,
    rep(max_k, hours_on*60),
    rev(ramp),
    rep(min_k, ramp_duration * 60)
  )
  
  #add 0 values
  k_values <- c(
    rep(NA, (1440 - length(k_values)) / 2),
    k_values,
    rep(NA, (1440 - length(k_values)) / 2)
  )
  
  brightness <- c(
    rep(NA, sum(is.na(k_values))/2),
    seq(from = 0, to = 1, length.out = ramp_duration*60),
    rep(1, (hours_on + (ramp_duration*2))*60),
    seq(from = 1, to = 0, length.out = ramp_duration*60),
    rep(NA, sum(is.na(k_values))/2)
  )
  
  temp <- template_df()
  
  temp$k_values <- k_values
  temp$brightness <- brightness
  
  temp$k_values <- round(temp$k_values)
  
  return(temp)
}

#brightness values

temp <- create_lighting_df()

write.csv(temp, 'light_schedule.csv', row.names = FALSE)
