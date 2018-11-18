---
title: "Simulating data and file-based ETL"
author: "Gerhard Groenewald"
date: '2018-09-24'
output:
  pdf_document: default
  html_document: default
layout: post
tags:
- tutorial
- advanced
- R
# audience
- development
- analysis

comments: yes
---



## Introduction
*Data Scientists* spend a lot of time importing, cleaning, tidying and transforming data before any decent analysis can start. Like many, the industry that I work in typically email files to communicate data and report. I follow a consistent approach to ETL and subsequent data concentration to better manage the accumulation of multiple, disparate files from a variety of sources and different formats.

This tutorial demonstrates a simplified version of this process.  It is split into four parts, starting with manufacturing data and culminating in file-based *IO[^1]*.

**[Part 1](#part1)** covers importing and cleaning base data and creating features.  

**[Part 2](#part2)** extends the output from *Part 1* with simulated data in the context of a gym training scenario.

**[Part 3](#part3)** exports multiple grouped simulated data to a variety of file types.

**[Part 4](#part4)**, the final tutorial, imports, tidies and transforms *the exported files from Part 3* in an automated and standardised way.

## The Scenario
As an honorary English person, I decided to simulate a *gym training log* for the **current English football squad**. The result is a daily record of selected exercise repetitions for each player, logged during a gym training session.  It covers a two month period, with the first month during 2017 and the latter in 2018, a year difference.

The base list of players is copied from  [Wikipedia](https://en.wikipedia.org/wiki/England_national_football_team), extended further down this tutorial with simulated data, and used to demonstrate procedures and functions to do with IO.  

<a id="part1"></a>

## Part 1:  Import, Tidy Data and Create Features

### Library
I always declare libraries at the top of the document in a typical workflow.  It makes it a lot easier to know upfront which libraries are used when sharing the document with others.


```r
library(tidyverse)
library(lubridate)
library(readxl)
library(knitr)
library(kableExtra)
```

### Functions
Keeping general functions towards the top of a document makes it easier to reuse throughout.  In larger projects, I tend to create function files that are `sourced` by other files, sourcing it upon setting up a document.  It promotes consistency, continuity, standardisation and simplification.

A better idea is to create packages, as I am increasingly reusing functions between different projects.  [Hadley Wickham](http://hadley.nz) wrote a whole book advocating the use of packages to *[create fundamental units of shareable R code](http://r-pkgs.had.co.nz), bundling together code, data, documentation, and tests*.


```r
func_rename_tidy <-
  function(.) {
    gsub("[^[:alnum:] \\_\\.]", "", .) %>%
      str_replace_all(pattern = " |\\.", replacement = "\\_") %>%
      str_replace_all(pattern = "\\_+", replacement = "\\_") %>%
      str_replace_all(pattern = "\\_$|\\.$", replacement = "")
  }
```

<a id="parameters"></a>

### General Parameters
Grouping generic parameters in one section quickly allows new users to adopt a document customised to their environment and for its intended use.  Here I am setting up the relative path to the source data.


```r
directory_path <- "../../resources/england_football_simulation/"
```

### Importing
The data type of each column is guessed when the base source data is imported.  I always increase the `guess_max` parameter as a rule unless I know the data structure in advance.  

I have previously imported data where the first few hundred values in a column are empty, having populated values further down the table.  The import function guesses the data-type as logical when it isn't, resulting in subsequent populated values incorrectly coerced to `NA`.

A hangover from working with databases, I tend to tidy column names upon import, using the `func_rename_tidy` function as it simplifies coding after import.


```r
# IO: In: df
df <- 
  readr::read_csv(
    file = paste0(directory_path, "football.csv"), 
    guess_max = 100000
  ) %>% 
  rename_all(func_rename_tidy)
```

```
## Parsed with column specification:
## cols(
##   No. = col_integer(),
##   Player = col_character(),
##   `Date of birth (age)` = col_character()
## )
```

Let's take a look at the first few rows of data and simultaneously create an initial table for later comparison.


```r
kable(
  df_initial <-
    df %>% 
    head()
)
```

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> No </th>
   <th style="text-align:left;"> Player </th>
   <th style="text-align:left;"> Date_of_birth_age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Jordan Pickford </td>
   <td style="text-align:left;"> 7 March 1994 (age 24) </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> Trent Alexander-Arnold </td>
   <td style="text-align:left;"> 7 October 1998 (age 19) </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> Danny Rose </td>
   <td style="text-align:left;"> 2 July 1990 (age 28) </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> Kyle Walker </td>
   <td style="text-align:left;"> 28 May 1990 (age 28) </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> James Tarkowski </td>
   <td style="text-align:left;"> 19 November 1992 (age 25) </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> Harry Maguire </td>
   <td style="text-align:left;"> 5 March 1993 (age 25) </td>
  </tr>
</tbody>
</table>

### Tidying
The `Date_of_birth_age` field contains multiple variables, depicting the date-of-birth, and age calculated at the time the article was published.  This is messy data, which I have previously [written about](/page/resources/#tidy).

The `DOB` is extracted from the field and converted to a `date` datatype, with the `age` part discarded. A new feature `Age` is created, which is the calculated interval between `DOB` field and the `lubridate::today()` function. <br>


```r
df <-
  df %>%
  rename(DOB = Date_of_birth_age) %>% 
  mutate_at("DOB", ~
              str_remove(., pattern = "\\(age \\d+\\)") %>% 
              str_trim(., side = "both") %>% 
              dmy(.)) %>% 
  mutate(Age = DOB %>% 
           interval(today()) %>%
           as.period(unit = "year") %>% 
           year())
```

Let's inspect the head of the tidied compared with the initial dataframe.


```r
  df_initial %>% 
  
  # Join the newly created table with the initial table using the common fields
  inner_join(
    df %>%
      head(),
    by = c("No", "Player")) %>% 
  kable() %>% 
  kable_styling(full_width = FALSE) %>%
  add_header_above(c("Common fields" = 2, 
                     "Initial field\nwith multi-values" = 1,
                     "New\nsplit fields" = 2)) %>% 
  column_spec(3, background = "red", color = "white") %>% 
  column_spec(4:5, background = "lightgreen")
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
<tr>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px;">Common fields</div></th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="1"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px;">Initial field<br>with multi-values</div></th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px;">New<br>split fields</div></th>
</tr>
  <tr>
   <th style="text-align:right;"> No </th>
   <th style="text-align:left;"> Player </th>
   <th style="text-align:left;"> Date_of_birth_age </th>
   <th style="text-align:left;"> DOB </th>
   <th style="text-align:right;"> Age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Jordan Pickford </td>
   <td style="text-align:left;color: white;background-color: red;"> 7 March 1994 (age 24) </td>
   <td style="text-align:left;background-color: lightgreen;"> 1994-03-07 </td>
   <td style="text-align:right;background-color: lightgreen;"> 24 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> Trent Alexander-Arnold </td>
   <td style="text-align:left;color: white;background-color: red;"> 7 October 1998 (age 19) </td>
   <td style="text-align:left;background-color: lightgreen;"> 1998-10-07 </td>
   <td style="text-align:right;background-color: lightgreen;"> 20 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> Danny Rose </td>
   <td style="text-align:left;color: white;background-color: red;"> 2 July 1990 (age 28) </td>
   <td style="text-align:left;background-color: lightgreen;"> 1990-07-02 </td>
   <td style="text-align:right;background-color: lightgreen;"> 28 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> Kyle Walker </td>
   <td style="text-align:left;color: white;background-color: red;"> 28 May 1990 (age 28) </td>
   <td style="text-align:left;background-color: lightgreen;"> 1990-05-28 </td>
   <td style="text-align:right;background-color: lightgreen;"> 28 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> James Tarkowski </td>
   <td style="text-align:left;color: white;background-color: red;"> 19 November 1992 (age 25) </td>
   <td style="text-align:left;background-color: lightgreen;"> 1992-11-19 </td>
   <td style="text-align:right;background-color: lightgreen;"> 25 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> Harry Maguire </td>
   <td style="text-align:left;color: white;background-color: red;"> 5 March 1993 (age 25) </td>
   <td style="text-align:left;background-color: lightgreen;"> 1993-03-05 </td>
   <td style="text-align:right;background-color: lightgreen;"> 25 </td>
  </tr>
</tbody>
</table>

This confirms that the `DOB` field has been converted into a date field, and used to calculate the `Age` based on `today()`, the current date when the notebook was run.<br><br>

<a id="part2"></a>

## Part 2: Simulation
### Simulation Scenario
The number of repetitions for each one of the standard exercises are logged during a training session.  Most players are unable to train every day, so there are gaps in the timeline for each player during the recorded period, with some players missing more sessions compared with others.

The exercises included:

- `Horizontal Seated Leg Press`
- `Lat Pull-Down`
- `Cable Biceps Bar`
- `Cable Triceps Bar`
- `Chest Press`
- `Hanging Leg Raise`

### Simulation Process
The graph shows the simulation data process flow cycle.<br><br>

![Simulation Process Cycle](/post/2018-09-24-simulated_data_files/simulation_process.png)

Between 15 and 22 players train daily, represented by the `Sampled Players` in the above graph.  Days during the two months where no exercises are simulated are coded those as `Day Off`.

Some of the exercises repetitions, represented by `Repetitions` in the graph have a zero count, the case where a player skips an exercise during a training session.

Let's start this section by creating some parameters and reference values.

### Simulation Parameters

```r
# Players: group size
param_group_size <- df %>% nrow()

# Training: Gym exercises + Day off
param_exercises <-
  c(
  "Horizontal Seated Leg Press",
  "Lat Pull-Down",
  "Cable Biceps Bar",
  "Cable Triceps Bar",
  "Chest Press",
  "Hanging Leg Raise",
  "Day Off"
)

# Factor version of the exercises which helps to retain order when graphing
param_exercises_factored <-
  param_exercises %>% 
  factor(ordered = TRUE)

# Starting date of the log
param_date_start <- ymd("2018-03-01")

# Creating data ranges, one for 2017 and another for 2018, packaging it nicely
# into a tibble
param_days <- 
  
  tibble(
    Date = c(
      # 2018 data
      seq.Date(
        from = param_date_start,
        by = "day",
        length.out = 28
      ),
      
      # 2017 data
      seq.Date(
        from = param_date_start - years(1),
        by = "day",
        length.out = 28
      )
    )
  )
```

### Simulation Function
The following code section is the simulation function that maps together the parameters with random combinations and sequences through the simulation process, as represented by the `Simulation Process Cycle` graph shown above.


```r
func_create_data <-
  
  # As with the process graph, each day from the param_days tibble is used as a
  # input to start a new simulated cycle
  function(param_day) {
    
    # Use the integer value of the day to set a seed value, which means that
    # this part of the simulation can be recreated as is
    set.seed(param_day %>% as.integer())
    
    # create the sample size from the 22 players, sampling a value between 15
    # and 22 which represent the total number of players that exercise in a
    # single day
    training_group_size <- sample(15:param_group_size, 1)
    
    # Generate between training_group_size-value samples, instanced from a population
    # between 1 to 22 without replacement
    sample(x = 1:param_group_size,
             replace = FALSE,
             size = training_group_size) %>%
      
      # Map each sampled player in the distribution to all 6 exercises
      map(function(param_player_number) {
       param_exercises[1:6] %>%

          # for each one of the exercises, create a random sample between 0 and
          # 20 repetitions
          map(function(param_excercise) {
          
              # Populate a tibble with all parameters used within the daily
              # cycle simulation.  This part is truly random and will be
              # different between all iterations
            tibble(
              No = param_player_number,
              Exercise = param_excercise,
              Volume = sample(x = 0:20,
                             replace = FALSE,
                             size = 1)
            ) %>%
              return()
          })
      }) %>%
      
      # Return and nest the result in the daily tibble, corresponding its
      # calling date
      return()
  }
```

### Executing the Simulation
The code section below calls the `tmp_exercise_data` function by feeding it the previously created parameters.


```r
tmp_exercise_data <- 
  param_days %>%
  
  # Map the list of days to the func_create_data function to simulate the data
  mutate_at("Date", funs(data = map), func_create_data) %>% 
  
  # The unnest() function returns all iteratively nested cycled data to a top
  # param_days level
  unnest() %>%
  unnest() %>%
  unnest() %>% 
  
  # Complete the data for all combinations of the player no, date and exercise,
  # creating explicit entries for the missing combinations
  complete(No, Date, Exercise) %>% 
  
  # Create a new variable by extracting the year value from the date
  mutate_at("Date", funs(Year = year)) %>% 
  
  # Group by Player Number and nest the simulated data in the `training_data`
  # column
  group_by(No) %>%
  nest(.key = training_data)
```

### Explore the Simulated Data
Let's take a look at the first few rows of player data joined with the simulated data.


```r
df %>%
  select(Player, No) %>%
  
  # Select the first three players in the list
  head(3) %>%
  
  # Join the player information (DOB) with the latest year (2018) from the
  # simulated exercise log
  inner_join(tmp_exercise_data %>% 
               unnest() %>% 
               filter(Year == max(Year)) %>% # 2018 in this example
               filter(! is.na(Volume)) %>% 
               select(-Year)
               ,
             by = "No") %>%
  select(-No) %>%
  
  # Spread the exercises as columns and populate Volume as its value
  spread(Exercise, Volume) %>%
  group_by(Player) %>% 
  
  # select the top three dates for each of the first three players
  top_n(3, wt = Date) %>%
  kable() %>%
  kable_styling(full_width = FALSE,
                font_size = 9) %>%
  column_spec(1, bold = TRUE) %>%
  collapse_rows(columns = 1:1, valign = "top")
```

<table class="table" style="font-size: 9px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Player </th>
   <th style="text-align:left;"> Date </th>
   <th style="text-align:right;"> Cable Biceps Bar </th>
   <th style="text-align:right;"> Cable Triceps Bar </th>
   <th style="text-align:right;"> Chest Press </th>
   <th style="text-align:right;"> Hanging Leg Raise </th>
   <th style="text-align:right;"> Horizontal Seated Leg Press </th>
   <th style="text-align:right;"> Lat Pull-Down </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;font-weight: bold;vertical-align: top !important;" rowspan="3"> Danny Rose </td>
   <td style="text-align:left;"> 2018-03-26 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 12 </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> 2018-03-27 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 6 </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> 2018-03-28 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 7 </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;vertical-align: top !important;" rowspan="3"> Jordan Pickford </td>
   <td style="text-align:left;"> 2018-03-26 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> 2018-03-27 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 10 </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> 2018-03-28 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;vertical-align: top !important;" rowspan="3"> Trent Alexander-Arnold </td>
   <td style="text-align:left;"> 2018-03-25 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 17 </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> 2018-03-26 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 13 </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> 2018-03-27 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
</tbody>
</table>

The following graph shows the cumulative repetitions by player and exercise over a timeline, highlighting the missed training sessions in red.

The `func_visualise_day_off` function is used to impute a value for the days without exercise data for a player, making it explicit when visualising the data.


```r
func_visualise_day_off <-
  
  # This function is to explicitly visualise the `Day Off` when graphing the exercise
  # log
  function(df) {
    df %>% 
      
      # Remove all entries with zero volume
      filter(! is.na(Volume)) %>% 
      
      # Extract the entries where all exercises for each player and day
      # combination have zero volume, and overwrite it with 100 in order to
      # visualise it in the context of the exercises
      union_all(
        df %>% 
          group_by(No, Date) %>% 
          filter(any(is.na(Volume))) %>% 
          distinct(No, Date) %>% 
          mutate(Exercise = "Day Off", 
                 Volume = 100)    
      ) %>% 
      return()
  }

param_colour_ramp <-
  
  # Create a colour ramp that maps the colours with the factored exercises, which
  # includes the `Day Off`
  function() {
    # Create an array of colour data
    tmp <- c(viridis::cividis(n = 6), "red")
    
    # Reorder colour values to align with the exercises and `Day Off`
    tmp <-
      c(
        tmp[1:3], # First 3 exercise colour values
        tmp[7], # Day Off colour in red
        tmp[4:6] # Last 3 exercise colour values
      )
  }

# Create a plot dataframe as we will use filtered parts of it in different geoms
# in the plot
plot_data <-
  df %>% 
  
  # Plot data for the first 9 players in the list
  head(9) %>% 
  
  # Join the exercise log with the player data
  inner_join(
    tmp_exercise_data %>% 
      unnest() %>% 
      filter(Year == 2018) %>%
      
      # Explicitly add in the missing days per player and add volume to plot it
      func_visualise_day_off(),
    by = "No") %>% 
  
  # Convert the exercises into levelled factors to retain the order of the exercises when plotting
  mutate_at("Exercise", factor, levels = param_exercises_factored, ordered = TRUE)

# Now plot the data
plot_data %>%
  
  # Remove the `Day Off` from the tibble and plot the volume of exercises over
  # the timeline, splitting exercises by colour
  filter(! grepl("day", Exercise, ignore.case = TRUE)) %>%
  ggplot(aes(x = Date, y = Volume, fill = Exercise)) +
  geom_area() +
  
  # Plot the `Day Off` as bars in the timeline
  geom_col(data  =
             plot_data %>%
             filter(grepl("day", Exercise, ignore.case = TRUE)),
           width = 0.5
           ) +
  
  # Wrap the plot by player
  facet_wrap(~ Player) +
  
  # Tidy up the x (data) scale to a suitable format
  scale_x_date(date_labels = "%d-%b") +
  theme_classic() +
  
  # Manually populate the colour fill values with the function created
  scale_fill_manual(values = param_colour_ramp()) +
  theme(axis.text.x = element_text(angle = 90),
        legend.position = "bottom") +
  labs(title = "English football team training log",
       subtitle = "Volume of reps per exercise & days off over 28 days",
       x = "Date [2018]")
```

<img src="/post/2018-09-24-simulated_data_files/figure-html/eda_vis_days_off-1.png" width="672" />
<a id="part3"></a>

## Part 3:  Export Simulated Data
### Export Process
The aim of this part is to output data into a variety of files to be consumed in **[Part 4](#part4)**, which is to *Import Simulated Data*.

The following image shows the process by which data is transformed, grouped and outputted into a variety of file types.

![Data Export Process](/post/2018-09-24-simulated_data_files/export_process.png)

The *training log data* is grouped by year, data nested and exported to two file-types, including `Excel` and `CSV`.

2017 data is exported to `Excel`, mapping each player and associated data to a tab.  The 2018 data is exported to `CSV` file-type, with each exercise written to its own file.

#### To Excel

I use the `openxlsx` library to create and manipulate Excel files.  The aim is to create one Excel file for the 2017 data, creating tabs for each of the 22 players, and populating each sheet with relevant data.


```r
library(openxlsx) 

wb <- createWorkbook()
# create workbook instance to populate with tabs and tables

# Join player and simulated data
df_exercise_tab <-
  df %>%
  inner_join(tmp_exercise_data %>%
               unnest(),
             by = "No") %>%
  
  # Filter on the initial year (2017)
  filter_at("Year", all_vars(. == min(.))) %>% 
  
  # Create new duplicage variable `tab` from Player, using it to group data and
  # output as tabs within the spreadsheet
  mutate(tab = Player) %>% 
  group_by(tab) %>%
  
  # And nest all data for each Player
  nest()

# populate the tabs by walking through the combination of tabs and associated
# data
list(
  df_exercise_tab$tab,
  df_exercise_tab$data
) %>%
  pwalk(function(file_tab, file_data) {
    
    # add a tab
    addWorksheet(wb, sheetName = file_tab, gridLines = FALSE)
    setColWidths(wb, file_tab, cols = 2:20, widths = 12)
    
    # Insert a datatable
    writeDataTable(
      wb,
      sheet = file_tab,
      file_data %>% unnest(),
      startCol = "A",
      startRow = 1,
      bandedRows = TRUE,
      tableStyle = "TableStyleLight1"
    )
  })

# IO: Out: Excel
saveWorkbook(
  wb = wb, 
  file = paste0(directory_path,
                "england_football_exercise_training_log_2017.xlsx"),
  overwrite = TRUE)
```


#### To CSV
Using 2018 data, group `data` by `Exercise` and output each to an appropriately named CSV file.


```r
# Join Player data and simulated exercise data
df_exercise_tab <-
  df %>%
  inner_join(tmp_exercise_data %>%
               unnest(),
             by = "No") %>% 
  
  # Filter to retain the max year only (2018)
  filter_at("Year", all_vars(. == max(.))) %>% 
  
  # Create a duplicate variable for Exercise and group by it
  mutate(Exercise_csv = Exercise) %>% 
  group_by(Exercise_csv) %>% 
  
  # Nest the data within each exercise 
  nest()

# IO: Out: csv
list(
  df_exercise_tab$Exercise_csv,
  df_exercise_tab$data
) %>%
  
  # Step through list of exercises and nested data
  pwalk(function(csv_name, csv_data) {
    csv_data %>%
      
      # Write each exercise nested data to a file, appending `2018` to each
      # tidied exercise name to create a file name
      write_csv(
        path = paste0(
          directory_path,  # Directory Path
          csv_name %>%  # Tidied name of the Exercise
            func_rename_tidy() %>%
            str_to_lower(),
          "_2018.csv"  # Add the Year extention
        )
      )
  })
```

Confirm that the files are created by checking the `directory_path` folder, as specified in the **[General Parameters](#parameters)** section.

<a id="part4"></a>

## Part 4:  Import Simulated Data
### Import Process
The aim is to dynamically import data into a common dataframe.  With `Excel` files, the function lists and unnest all the tabs, and import each table back into the calling `files` tibble as is the case with `CSV` files.

![Data Import Process](/post/2018-09-24-simulated_data_files/import_process.png)

### Import Function
The `func_get_file_dynamic` function dynamically imports data depending on file-type, depicted in the process graph above.


```r
func_get_file_dynamic <- 
  function(file_name) {
    
    # Check if file name contains .xlsx and map all tabs within it
    if(grepl("xlsx", file_name, ignore.case = TRUE)) {
      tibble(
        file_path = paste(directory_path, file_name, sep = "/"),
        file_tab = excel_sheets(path = paste(directory_path, file_name, sep = "/"))
      ) %>%
        
        # unnest the list of tabs for each file and import columns with detault
        # `text` datatype
        unnest() %>%
        mutate(file = map2(file_path, file_tab, function(file_path, file_tab) {
          read_excel(path = file_path,
                     col_types = "text",
                     sheet = file_tab, 
                     guess_max = 100000)
        })) %>%
        unnest() %>%
        return()
    } else {
      
      # assume that alternative file type is .csv
      read_csv(
        file = paste(directory_path, file_name, sep = "/"),
        guess_max = 100000,
        
        # set default datatype as text, similar to Excel config
        col_types = cols(.default = col_character())
      ) %>%
        return()
    }
  }
```

### List and import the files
In this section we generate a list of the files located in the `directory_path` parameter folder, import it using the `func_get_file_dynamic` function, unnest it and `parse_guess` the data-types.


```r
files_expanded <-
  
  # find all files within directory and underlying folders
  list.files(path = directory_path,
           recursive = TRUE) %>%
  
  # create a tibble of the files and rename the file name to fil_name
  as_data_frame() %>%
  rename(file_name = value) %>% 
  
  # exclude the football file from the results
  filter(! grepl("football\\.csv$", file_name, ignore.case = TRUE)) %>% 
  
  # extract the file type for future processing
  mutate_at("file_name", funs(file_source = str_extract), pattern = "\\.(csv|xlsx)$") %>% 
  
  # dynamically import the files and nest the file column
  mutate_at("file_name", funs(file = map), func_get_file_dynamic) %>% 
  
  # Unnest all files and consolidate columns, then only guess the data type.
  # This prevents any errors if there are columns with the same file-names but
  # have different datatypes.
  unnest() %>% 
  mutate_all(parse_guess)
```

Let's check the first few rows of the imported data.


```r
# Inspect the first 6 rows of the newly imported files
files_expanded %>% 
  head() %>% 
  kable() %>%
  kable_styling(full_width = FALSE,
                font_size = 9) %>%
  column_spec(1, bold = TRUE)
```

<table class="table" style="font-size: 9px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> file_name </th>
   <th style="text-align:left;"> file_source </th>
   <th style="text-align:right;"> No </th>
   <th style="text-align:left;"> Player </th>
   <th style="text-align:left;"> DOB </th>
   <th style="text-align:right;"> Age </th>
   <th style="text-align:left;"> Date </th>
   <th style="text-align:left;"> Exercise </th>
   <th style="text-align:right;"> Volume </th>
   <th style="text-align:right;"> Year </th>
   <th style="text-align:left;"> file_path </th>
   <th style="text-align:left;"> file_tab </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;font-weight: bold;"> cable_biceps_bar_2018.csv </td>
   <td style="text-align:left;"> .csv </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Jordan Pickford </td>
   <td style="text-align:left;"> 1994-03-07 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:left;"> 2018-03-01 </td>
   <td style="text-align:left;"> Cable Biceps Bar </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;"> cable_biceps_bar_2018.csv </td>
   <td style="text-align:left;"> .csv </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Jordan Pickford </td>
   <td style="text-align:left;"> 1994-03-07 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:left;"> 2018-03-02 </td>
   <td style="text-align:left;"> Cable Biceps Bar </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;"> cable_biceps_bar_2018.csv </td>
   <td style="text-align:left;"> .csv </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Jordan Pickford </td>
   <td style="text-align:left;"> 1994-03-07 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:left;"> 2018-03-03 </td>
   <td style="text-align:left;"> Cable Biceps Bar </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;"> cable_biceps_bar_2018.csv </td>
   <td style="text-align:left;"> .csv </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Jordan Pickford </td>
   <td style="text-align:left;"> 1994-03-07 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:left;"> 2018-03-04 </td>
   <td style="text-align:left;"> Cable Biceps Bar </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;"> cable_biceps_bar_2018.csv </td>
   <td style="text-align:left;"> .csv </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Jordan Pickford </td>
   <td style="text-align:left;"> 1994-03-07 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:left;"> 2018-03-05 </td>
   <td style="text-align:left;"> Cable Biceps Bar </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;"> cable_biceps_bar_2018.csv </td>
   <td style="text-align:left;"> .csv </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Jordan Pickford </td>
   <td style="text-align:left;"> 1994-03-07 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> Cable Biceps Bar </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
</tbody>
</table>

### Visualise Imported Data
Now create a couple of visualisations.  The first is the number of records per CSV file or per Excel tab after removing entries with missing or zero volume.


```r
# Visualise the imported file data
files_expanded %>%
  
  # filter to retain exercises with volume > 0 only, including removing those
  # with NA
  filter(Volume > 0) %>% 
  mutate_at("file_tab", ~coalesce(., "None")) %>% 
  
  # This creates a count of rows for combination of file_name, file_tab and
  # file_source
  count(file_name, file_tab, file_source) %>% 
  
  # Create new feature showing tab and file names where relevant:
  # With CSV files:  remove .csv and 2018 from the file name
  # With Excel file: show the tabs only
  mutate(file_tab = case_when(
    grepl("csv", file_name, ignore.case = TRUE) ~ 
      file_name %>%
      str_remove("\\.csv") %>% 
      str_remove("\\_2018"),
    TRUE ~ file_tab
  )) %>% 
  
  # Replace the underscore from the file_tab feature with spaces
  mutate_if(is.character, str_replace_all, pattern = "_", replacement = " ") %>% 
  
  # Turn file_tab into factor and order the descending count (n)
  arrange(desc(n)) %>% 
  mutate_at("file_tab", fct_inorder) %>% 
  ggplot(aes(x = file_tab, y = n, fill = file_source)) +
  geom_col() +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_fill_viridis_d(option = "E") +
  labs(title = "Number of records by file source", 
       subtitle = "Empty records and zero counts removed", 
       fill = "File Source",
       x = "File or Tab",
       y = "# Records")
```

<img src="/post/2018-09-24-simulated_data_files/figure-html/vis_import_row_counts-1.png" width="672" />

Now combine the file data and create a plot grouped by Player, file type and Year.


```r
# Calculate the average count of records by player
param_player_file_source_ave <-
  files_expanded %>% 
  filter(Volume > 0) %>% 
  count(Player, file_source) %>%
  ungroup() %>% 
  summarise_if(is.numeric, mean) %>% 
  pull()
  
files_expanded %>% 
  filter(Volume > 0) %>% 
  mutate_at("file_tab", ~coalesce(., "None")) %>% 
  count(Player, Year, file_source) %>% 
  mutate_if(is.character, str_replace_all, pattern = "_", replacement = " ") %>% 
  group_by(Player) %>% 
  mutate(total_score = sum(n)) %>% 
  arrange(desc(total_score)) %>% 
  ungroup() %>% 
  mutate_at("Player", fct_inorder) %>% 
  ggplot(aes(x = Player, y = n, fill = n)) +
  geom_col() +
  geom_hline(yintercept = param_player_file_source_ave,
             col = "red",
             lty = 2,
             size = 0.5
             ) +
  annotate("text",
           x = 5,
           y = param_player_file_source_ave + 20,
           label = paste("Average:", round(param_player_file_source_ave)),
           col = "red",
           size = 4
           ) +
  facet_grid(file_source + Year ~ .) +
  scale_fill_viridis_c() +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Number of records by player and file source", 
       subtitle = "Empty records and zero counts removed", 
       fill = "# Records",
       x = "Player",
       y = "# Records")
```

<img src="/post/2018-09-24-simulated_data_files/figure-html/vis_import_consolidated-1.png" width="672" />

## Summary
This tutorial is simplified and without real-world nuances and overhead, like error handling for example.  However, the power and simplicity of the approach is adequately demonstrated and can be extended for use in similar situations.

## Session Info

```
## R version 3.5.1 (2018-07-02)
## Platform: x86_64-apple-darwin15.6.0 (64-bit)
## Running under: macOS  10.14
## 
## Matrix products: default
## BLAS: /Library/Frameworks/R.framework/Versions/3.5/Resources/lib/libRblas.0.dylib
## LAPACK: /Library/Frameworks/R.framework/Versions/3.5/Resources/lib/libRlapack.dylib
## 
## locale:
## [1] en_GB.UTF-8/en_GB.UTF-8/en_GB.UTF-8/C/en_GB.UTF-8/en_GB.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
##  [1] openxlsx_4.1.0   bindrcpp_0.2.2   kableExtra_0.9.0 knitr_1.20      
##  [5] readxl_1.1.0     lubridate_1.7.4  forcats_0.3.0    stringr_1.3.1   
##  [9] dplyr_0.7.8      purrr_0.2.5      readr_1.1.1      tidyr_0.8.2     
## [13] tibble_1.4.2     ggplot2_3.1.0    tidyverse_1.2.1 
## 
## loaded via a namespace (and not attached):
##  [1] tidyselect_0.2.5  xfun_0.4          reshape2_1.4.3   
##  [4] haven_1.1.2       lattice_0.20-38   colorspace_1.3-2 
##  [7] htmltools_0.3.6   viridisLite_0.3.0 yaml_2.2.0       
## [10] rlang_0.3.0.1     pillar_1.3.0      glue_1.3.0       
## [13] withr_2.1.2       selectr_0.4-1     modelr_0.1.2     
## [16] bindr_0.1.1       plyr_1.8.4        munsell_0.5.0    
## [19] blogdown_0.9      gtable_0.2.0      cellranger_1.1.0 
## [22] zip_1.0.0         rvest_0.3.2       evaluate_0.12    
## [25] labeling_0.3      highr_0.7         broom_0.5.0      
## [28] Rcpp_1.0.0        scales_1.0.0      backports_1.1.2  
## [31] jsonlite_1.5      gridExtra_2.3     hms_0.4.2        
## [34] digest_0.6.18     stringi_1.2.4     bookdown_0.7     
## [37] grid_3.5.1        rprojroot_1.3-2   cli_1.0.1        
## [40] tools_3.5.1       magrittr_1.5      lazyeval_0.2.1   
## [43] crayon_1.3.4      pkgconfig_2.0.2   xml2_1.2.0       
## [46] viridis_0.5.1     assertthat_0.2.0  rmarkdown_1.10   
## [49] httr_1.3.1        rstudioapi_0.8    R6_2.3.0         
## [52] nlme_3.1-137      compiler_3.5.1
```

[^1]: <sub>*IO:* in/ out or input and output for data</sub>
