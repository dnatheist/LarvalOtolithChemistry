FeelForData <- function(df) {
  # Computes a standard summaty of data for perusal.
  #
  # Args:
  #   df: The data file to be summarised.
  #
  # Returns:
  #   The data with a variety of summaries.
  require(corrgram)
  df <- AllOtoData
  # Error handling
  str(df)
  corrgram(df)
  sapply(df[1,],class)
  unique(df$LarvalID)
  #table(df$Time,df$Ba)
}
