
# Libraries ---------------------------------------------------------------

library(tidyverse)
library(lubridate)
library(rcompanion)
library(rio)

# Functions ---------------------------------------------------------------

func_rename <-
  function(x) {
    
    # sequence is important here
    # regex removing all chars not alpha-numeric, underscore or period
    gsub("[^[:alnum:] \\_\\.]", "", x) %>%
      
      # replace any space or period with underscore
      str_replace_all(pattern = " |\\.", replacement = "\\_") %>%
      
      # replace multiple underscores with one
      str_replace_all(pattern = "\\_+", replacement = "\\_") %>%
      
      # remove trailing underscores and period
      str_remove(pattern = "\\_$|\\.$")
  }

func_legible_boolean <-
  
  # returns `feature name` when TRUE and "Not_" + `feature name` otherwise
  function(df) {
    
    # only exec if there is a logical field in the df
    if (df %>%
        select_if(is.logical) %>%
        ncol() > 0) {
      # add row numbers to input dataframe
      df <-
        df %>%
        ungroup() %>%
        mutate(row_id = row_number())
      
      # select row_id and other logical fields
      tmp <-
        df %>%
        select(row_id, select_if(., is.logical) %>% names(.)) %>%
        
        # gather all logical fields and keep row_id to retain identity
        gather(key, value,-row_id) %>%
        
        # when value is TRUE then return the feature name else "Not_" pasted in
        # front of it
        mutate(value = case_when(
          value ~ key,
          TRUE ~ paste("Not", key, sep = "_")
        )) %>%
        
        # return the feature names back to header positions
        spread(key, value)
      
      vars <- 
        df %>%
        select_if(is.logical) %>%
        names()
      
      df %>% 
        
        # return all values from the table after excluding the original logical
        # fields and join the newly adjuted features back into the table using the
        # row_id
        select(-(!!vars)) %>%
        inner_join(tmp,
                   by = "row_id") %>%
        
        # remove the row_id as the join is complete
        select(-row_id)
    } else {
      df %>% 
        return()
    }
  }

func_create_summary <-
  
  # group by factors, summarising numeric fields to sum total
  function(df) {
    
    # create a list of factors from the input dataframe
    tmp_factors <- df %>% select_if(is.factor) %>% names()
    
    # mutate all factors in the dataframe to characters
    df <- df %>% ungroup() %>% mutate_if(is.factor, as.character)
    
    
    # list original dataframe with a newly created summary row
    list(
      
      # original input dataframe
      df,
      
      # summary row, replaceing each factor value to "Total"
      df %>%
        mutate_at(tmp_factors, ~"Total") %>%
        
        # group by for each of the original factor features
        group_by_at(tmp_factors) %>%
        
        # summarise all numeric values to sum total, ignoring NULL values
        summarise_if(is.numeric, sum, na.rm = TRUE)
    ) %>% 
      
      # union all tables contained in the list, including original dataframe and
      # newly created summary row
      reduce(union_all) %>%
      
      # change factors back into factors
      mutate_at(tmp_factors, factor) %>% 
      return()
  }


func_present_headers <-
  function(.) {
    
    # replace all `spaceholder underscores` with spaces
    str_replace_all(., pattern = "_", replacement = " ") %>%
      
      # change all words in string to title text
      str_to_title() %>%
      return()
  }

# Create Data -------------------------------------------------------------

func_rescale_range <-
  function(m, tmin, tmax) {
    rmin = min(m)
    rmax = max(m)
    return(((m - rmin) / (rmax - rmin)) * (tmax - tmin) + tmin)
  }

# Check out  Distributions {stats}.  Use find as they show all distributions!!!!
rbeta(n = 1e5, shape1 = 1, shape2 = 5, ncp = 0) %>%
  func_rescale_range(3, 10) %>% 
  round() %>% 
  table() %>% 
  plot()

set.seed(123)
# par(mfrow=c(1, 1)) 
par(mfrow=c(3, 1)) 
rbeta(n = 1.5e3, shape1 = 1, shape2 = 200, ncp = 5) %>% 
  enframe() %>% 
  mutate_at("value", ~ func_rescale_range(., 1, 14) %>% round()) %>% 
  mutate_at("value", factor) %>% 
  pull(value) %>% 
  table() %>% 
  print() %>% 
  plot()

rbeta(n = 3e3, shape1 = 1, shape2 = 100, ncp = 30) %>% 
  enframe() %>% 
  mutate_at("value", ~ func_rescale_range(., 1, 30) %>% round()) %>% 
  mutate_at("value", factor) %>% 
  pull(value) %>% 
  table() %>% 
  print() %>% 
  plot()

rbeta(n = 5e2, shape1 = 1, shape2 = 200, ncp = 5) %>% 
  enframe() %>% 
  mutate_at("value", ~ func_rescale_range(., 30, 40) %>% round()) %>% 
  mutate_at("value", factor) %>% 
  pull(value) %>% 
  table() %>% 
  print() %>% 
  plot()

# list(
#   rbeta(n = 1.5e3, shape1 = 1, shape2 = 200, ncp = 5) %>% 
#     enframe() %>% 
#     mutate_at("value", ~ func_rescale_range(., 1, 14) %>% round()),
#   rbeta(n = 3e3, shape1 = 1, shape2 = 100, ncp = 30) %>% 
#     enframe() %>% 
#     mutate_at("value", ~ func_rescale_range(., 1, 30) %>% round()),
#   rbeta(n = 5e2, shape1 = 1, shape2 = 200, ncp = 5) %>% 
#     enframe() %>% 
#     mutate_at("value", ~ func_rescale_range(., 30, 40) %>% round())
# ) %>% 
#   reduce(union_all) %>% 
#   count(value) %>% 
#   print(n = 100)
#   


# Create an overlapping distr ---------------------------------------------

set.seed(123)
par(mfrow=c(3, 1)) 
rbeta(n = 1.5e3, shape1 = 1, shape2 = 200, ncp = 5) %>% 
  enframe() %>% 
  mutate_at("value", ~ func_rescale_range(., 1, 14) %>% round()) %>% 
  mutate_at("value", factor) %>% 
  pull(value) %>% 
  table() %>% 
  print() %>% 
  plot()

rbeta(n = 3e3, shape1 = 1, shape2 = 100, ncp = 30) %>% 
  enframe() %>% 
  mutate_at("value", ~ func_rescale_range(., 1, 40) %>% round()) %>% 
  mutate_at("value", factor) %>% 
  pull(value) %>% 
  table() %>% 
  print() %>% 
  plot()

rbeta(n = 5e2, shape1 = 200, shape2 = 1, ncp = 10) %>% 
  enframe() %>% 
  mutate_at("value", ~ func_rescale_range(., 15, 35) %>% round()) %>% 
  mutate_at("value", factor) %>% 
  pull(value) %>% 
  table() %>% 
  print() %>% 
  plot()

# stuff -------------------------------------------------------------------

set.seed(123)
par(mfrow=c(1, 1)) 

list(
  rbeta(n = 1.5e3, shape1 = 1, shape2 = 200, ncp = 20) %>% 
    enframe(name = NULL) %>% 
    mutate(Cat = "One") %>% 
    mutate_at("value", ~ func_rescale_range(., 1, 14) %>% round()),
  rbeta(n = 3e3, shape1 = 1, shape2 = 50, ncp = 15) %>% 
    enframe(name = NULL) %>% 
    mutate(Cat = "Two") %>% 
    mutate_at("value", ~ func_rescale_range(., 1, 40) %>% round()),
  rbeta(n = 5e2, shape1 = 200, shape2 = 10, ncp = 10) %>% 
    enframe(name = NULL) %>%
    mutate(Cat = "Three") %>% 
    mutate_at("value", ~ func_rescale_range(., 15, 35) %>% round())  
) %>% 
  reduce(union_all) %>%
  mutate_at("Cat", fct_inorder) %>% 
  ggplot(aes(x = value, col = Cat)) +
  geom_freqpoly(bins = 40) +
  theme_classic()

# Test --------------------------------------------------------------------

df_dist<-
  list(
  rbeta(n = 1624, shape1 = 1, shape2 = 200, ncp = 20) %>% 
    enframe(name = NULL) %>% 
    mutate(Cat = "One") %>% 
    mutate_at("value", ~ func_rescale_range(., 1, 30) %>% round()),
  rbeta(n = 3057, shape1 = 1, shape2 = 50, ncp = 15) %>% 
    enframe(name = NULL) %>% 
    mutate(Cat = "Two") %>% 
    mutate_at("value", ~ func_rescale_range(., 10, 40) %>% round()),
  rbeta(n = 319, shape1 = 200, shape2 = 10, ncp = 10) %>% 
    enframe(name = NULL) %>%
    mutate(Cat = "Three") %>% 
    mutate_at("value", ~ func_rescale_range(., 15, 35) %>% round())  
) %>% 
  reduce(union_all) %>%
  mutate_at("Cat", fct_inorder)

df_dist %>% 
  ggplot(aes(x = value, col = Cat)) +
  geom_freqpoly(bins = 40) +
  theme_classic()

df_dist_enhanced <-
  df_dist %>% 
  group_by(Cat) %>%
  nest() %>%
  mutate(n = map(data, nrow)) %>% 
  unnest(n) %>% 
  mutate_at("Cat", as.character) %>% 
  inner_join(
    tribble(
      ~Cat, ~cmin, ~cmax,
      "One", 0, 4, 
      "Two", 5, 7,
      "Three", 8, 9
    ),
    by = "Cat"
  ) %>% 
  mutate_at("Cat", factor) %>% 
  mutate(dist = pmap(list(n=n, cmin, cmax), function(n, cmin, cmax) {
    sample(seq(cmin, cmax), n, replace = TRUE) %>% paste0("T", .)
  })) %>% 
  unnest() %>% 
  mutate_at("dist", factor)

df_dist_enhanced %>% 
  group_by(dist) %>% 
  do(summary = summary(.$value)) %>% 
  group_by(dist) %>% 
  mutate_at("summary", map, broom::tidy) %>% 
  unnest()

df_dist_enhanced %>% 
  mutate(label = value > 30) %>% 
  select(Category = dist, Overdue = label) %>% 
  export("~/Downloads/ml_cat_data.csv")

sample(
  x = c("Gerhard", "Johan"),
  size = 1e7,
  replace = TRUE,
  prob = c(0.2, 0.8)
) %>%
  table() %>% 
  print() %>% 
  prop.table()
