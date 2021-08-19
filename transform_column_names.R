# Transforms column names from the raw dataset to more readable names
#
# Note: using perl-style regex notation with named-groups
# - domain = t | f
# - force = Body | Gravity
# - sensor = Acc | Gyro
# - prep = Jerk (optional)
# - aggregation = mean|std
# - dim = X|Y|Z

transform_column_names <- function(column_names) {
  colpattern <- "^(?<domain>t|f)(?<force>Body|Gravity)(?<sensor>Acc|Gyro)(?<jerk>Jerk)?(?<mag>Mag)?-(?<aggregation>mean|std)\\(\\)(?<dim>-X|-Y|-Z)?$"
  # extracting named components from
  m <- regmatches(column_names, regexec(colpattern, column_names, perl = TRUE))
  # Note: using lapply on indexes so that we can access the original
  # column_names along with the matches m
  # notice, that length(m) == length(column_names)
  transformed_column_names <- lapply(seq_along(column_names), function(i) {
    item <- m[[i]]
    if (length(item) ==  0) {
      return(column_names[i])
    }
    parts <- c()
    # First is the aggregation type (mean or std)
    parts <- append(parts, str_to_sentence(item["aggregation"]))
    # Next is sensor type + space dimension
    if (item["sensor"] == "Acc") {
      parts <- append(parts, "accelerator")
    } else if (item["sensor"] == "Gyro") {
      parts <- append(parts, "gyro")
    }
    if (item["jerk"] != "") {
      parts <- append(parts, "jerk")
    }
    if (item["mag"] != "") {
      parts <- append(parts, "magnitude")
    }
    if (item["dim"] != "") {
      parts <- append(parts, tolower(substr(item["dim"], 2, 3)))
    }
    flavour_parts <- c()
    if (item["force"] != "") {
      flavour_parts <- append(flavour_parts, tolower(item["force"]))
    }
    if (item["domain"] == "f") {
      flavour_parts <- append(flavour_parts, "frequency")
    }
    flavour <- paste(flavour_parts, collapse = ", ")
    parts <- append(parts, paste("(", flavour , ")", collapse = ""))
    paste(parts, collapse = " ")
  })
  return(unlist(transformed_column_names))
}
