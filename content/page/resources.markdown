---
title: Resources
subtitle: Links to and information about data science references, training and news
author: "Gerhard Groenewald"
date: "26/08/2018"
output: html_document
comments: false
---



I have a ‘go-to’ list of quality and up-to-date sources of information that I continuously draw upon either as a *reference*, for *training*, detecting *patterns* and *trends*, or *comparison* and *evaluation*.

I have mapped the list to the data science process, and the skills and knowledge supporting it. I hope that it will save you time and help focus on relevant and key aspects using quality, vetted information.

The following graph provides an outline of the data science process and the skills and knowledge required to practice it.<br><br>

<a id="data_science_process_map"></a>

![The data science process and tools, skills & knowledge that support it](/page/resources_files/datascience_process_skills.png)

The `process` section of the graph is an extract from [R for Data Science](http://r4ds.had.co.nz/explore-intro.html) by [Hadley Wickham](http://hadley.nz) and [Garrett Grolemund](https://www.linkedin.com/in/garrett-grolemund-49328411/).<br><br>

## Summary of the data-science process
> [Data analysis is the **process** by which data becomes understanding, knowledge and insight.](https://www.londonr.org/wp-content/uploads/sites/2/presentations/LondonR_-_BigR_Data_-_Hadley_Wickham_-_20130716.pdf) Hadley Wickham, July 2013

### Extract, Transform & Load
The first, and probably the most labour intensive part of the data science process is to prepare and structure datasets to facilitate analysis, specifically **importing**, **tidying** and **cleaning** data.  Hadley Wickham wrote about it in [The Journal of Statistical Software, vol. 59, 2014](http://vita.had.co.nz/papers/tidy-data.html).<br><br>

<a id="tidy"></a>

#### Tidy Data
*Tidying data[^1]* aims to achieve the following:<br>

* Each *variable[^2]* forms a column and contains *values[^3]*
* Each *observation[^4]* forms a row.
* Each type of observational unit forms a table.<br>

It attempts to deal with 'messy data', including the following issues:<br>

* Column headers are values, not variable names.
* Multiple variables are stored in one column.
* Variables are stored in both rows and columns.
* Multiple types of observational units are stored in the same table.
* A single observational unit is stored in multiple tables.<br><br>

#### Null Values/ Missing Data
Most models are typically unable to support data with missing values.  The data science process will, therefore, include steps to detect and populate missing data.

It can occur anywhere between the *importing* and *transforming* stages.  *Models* can be used to guess values for more complex treatments, whereas a simpler approach could use aggregation during *transformation*.<br><br>

### Transform
The result of the `transform` step in the data science process is to:

* reshape data, which could be used to produce tidy data,
* transform data, like *rescaling[^5]* of numeric values, or reducing dimensions of categorical values using [Principle Component Analysis](#pca)
* create new features, also known as 'Feature Engineering',
* or a combination of the above that typically results in aggregation.<br><br>

#### Split, Apply, Combine
A common analytical pattern is to:

* split, group or nest data into pieces,
* apply some function to each piece,
* and to combine the results back together again.

It is also useful approach when modelling.  Read more about it in [Hadley Wickham's paper: 'The Split-Apply-Combine Strategy for Data Analysis'](https://www.jstatsoft.org/article/view/v040i01).<br><br>

### Visualisation & Modelling
In Feburary 2013 Hadley Wickham gave a talk where he described the interaction between visualisation and modelling very well.  

> Visualization can surprise you, but it doesn’t scale well. Modeling scales well, but it can’t surprise you.<br><br>  Visualization can show you something in your data that you didn’t expect. But some things are hard to see, and visualization is a slow, human process.<br><br>
Modeling might tell you something slightly unexpected, but your choice of model restricts what you’re going to find once you’ve fit it.<br><br>
So you iterate. Visualization suggests a model, and then you use your model to factor out some feature of the data. Then you visualize again.

[^1]: <sub>Described in [R for Data Science: Exploratory Data Analysis](http://r4ds.had.co.nz/exploratory-data-analysis.html)</sub>
[^2]: <sub>A *variable* is a quantity, quality, or property that you can measure. *Height, weight, sex, etc.*</sub>
[^3]: <sub>A *value* is the state of a variable when you measure it. The value of a variable may change from measurement to measurement. *152 cm, 80 kg, female, etc.*</sub>
[^4]: <sub>An *observation*, or data point, is a set of measurements made under similar conditions (you usually make all of the measurements in an observation at the same time and on the same object).  An observation will contain several values, each associated with a different variable. *Each person.*</sub>
[^5]: <sub>[*Standardisation*](https://en.wikipedia.org/wiki/Standard_score), *Normalisation* & [*Box-Cox transformations*](https://en.wikipedia.org/wiki/Power_transform) for example</sub>


<h2>Table of resources in relation to Data Science</h2>
<h3>Process</h3><h4>Programming</h4><table class="table table-hover table-condensed" style="font-size: 12px; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Area </th>
   <th style="text-align:left;"> Language </th>
   <th style="text-align:left;"> Source </th>
   <th style="text-align:right;"> # </th>
   <th style="text-align:left;"> Title </th>
   <th style="text-align:left;"> Author </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="4"> Reference </td>
   <td style="text-align:left;"> Python </td>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="4"> Web </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> [ pandas ]( http://pandas.pydata.org/pandas-docs/stable/ ) </td>
   <td style="text-align:left;"> [ Wes McKinney ]( http://wesmckinney.com ) </td>
  </tr>
  <tr>
   
   <td style="text-align:left;vertical-align: middle !important;" rowspan="2"> R </td>
   
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> [ Tidyverse ]( https://www.tidyverse.org ) </td>
   <td style="text-align:left;"> [ Hadley Wickham ]( http://hadley.nz ), Various </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> [ Style guide ]( http://r-pkgs.had.co.nz/style.html ) </td>
   <td style="text-align:left;"> [ Hadley Wickham ]( http://hadley.nz ) </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> R, Spark </td>
   
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> [ SparklyR ]( http://spark.rstudio.com ) </td>
   <td style="text-align:left;"> [ Rstudio ]( https://www.rstudio.com/products/RStudio/ ) </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="13"> Training </td>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="6"> Python </td>
   <td style="text-align:left;"> Book </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> [ Python for Data Analysis: Data Wrangling with Pandas, NumPy, and IPython 2nd Edition ]( https://www.amazon.co.uk/Python-Data-Analysis-Wrangling-IPython-ebook/dp/B075X4LT6K/ref=sr_1_1?s=digital-text&amp;ie=UTF8&amp;qid=1533142155&amp;sr=1-1&amp;keywords=pandas ) </td>
   <td style="text-align:left;"> [ Wes McKinney ]( http://wesmckinney.com ) </td>
  </tr>
  <tr>
   
   
   <td style="text-align:left;vertical-align: middle !important;" rowspan="5"> Web </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> [ Easier data analysis in Python with pandas (video series) ]( https://www.youtube.com/channel/UCnVzApLJE2ljPZSeQylSEyg ) </td>
   <td style="text-align:left;"> [ Kevin Markham ]( https://www.dataschool.io ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> [ Best practices with pandas (video series) ]( https://www.dataschool.io/best-practices-with-pandas/ ) </td>
   <td style="text-align:left;"> [ Kevin Markham ]( https://www.dataschool.io ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:left;"> [ Google's Python Class ]( https://developers.google.com/edu/python/ ) </td>
   <td style="text-align:left;"> [ Nick Parlante ]( https://cs.stanford.edu/people/nick/ ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> [ Kaggle Learn: Python ]( https://www.kaggle.com/learn/python ) </td>
   <td style="text-align:left;"> [ Colin Morris ]( https://www.kaggle.com/colinmorris ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:left;"> [ Kaggle Learn: Pandas ]( https://www.kaggle.com/learn/pandas ) </td>
   <td style="text-align:left;"> [ Aleksey Bilogur ]( http://www.residentmar.io/about.html ) </td>
  </tr>
  <tr>
   
   <td style="text-align:left;vertical-align: middle !important;" rowspan="4"> R </td>
   <td style="text-align:left;"> Book </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:left;"> [ R for Data Science: Import, Tidy, Transform, Visualize, and Model Data 1st Edition ]( https://www.amazon.co.uk/Data-Science-Transform-Visualize-Model-ebook/dp/B01NAJAEN5/ref=sr_1_1?s=digital-text&amp;ie=UTF8&amp;qid=1533143298&amp;sr=1-1&amp;keywords=r+for+data+science ) </td>
   <td style="text-align:left;"> [ Garrett Grolemund ]( https://www.linkedin.com/in/garrett-grolemund-49328411/ ), [ Hadley Wickham ]( http://hadley.nz ) </td>
  </tr>
  <tr>
   
   
   <td style="text-align:left;vertical-align: middle !important;" rowspan="3"> Web </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:left;"> [ R for Data Science ]( http://r4ds.had.co.nz ) </td>
   <td style="text-align:left;"> [ Garrett Grolemund ]( https://www.linkedin.com/in/garrett-grolemund-49328411/ ), [ Hadley Wickham ]( http://hadley.nz ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:left;"> [ Kaggle Learn: R ]( https://www.kaggle.com/learn/r ) </td>
   <td style="text-align:left;"> [ Rachael Tatman ]( http://www.rctatman.com ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:left;"> [ Introduction to Data Science with R How to Manipulate, Visualize, and Model Data with the R Language ]( http://shop.oreilly.com/product/0636920034834.do ) </td>
   <td style="text-align:left;"> [ Garrett Grolemund ]( https://www.linkedin.com/in/garrett-grolemund-49328411/ ) </td>
  </tr>
  <tr>
   
   <td style="text-align:left;vertical-align: middle !important;" rowspan="3"> SQL </td>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="2"> Book </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:left;"> [ High Performance MySQL: Optimization, Backups, and Replication 3rd Edition ]( https://www.amazon.co.uk/High-Performance-MySQL-Optimization-Replication-ebook/dp/B007I8S1TY/ref=tmm_kin_swatch_0?_encoding=UTF8&amp;qid=1533186140&amp;sr=8-1 ) </td>
   <td style="text-align:left;"> [ Baron Schwartz ]( https://www.xaprb.com ), [ Peter Zaitsev ]( https://www.percona.com/about-percona/team/peter-zaitsev ), [ Vadim Tkachenko ]( https://www.percona.com/about-percona/team/vadim-tkachenko ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:left;"> [ MySQL Stored Procedure Programming: Building High-Performance Web Applications in MySQL ]( https://www.amazon.co.uk/MySQL-Stored-Procedure-Programming-High-Performance-ebook/dp/B0043D2EJU/ref=tmm_kin_swatch_0?_encoding=UTF8&amp;qid=1533186303&amp;sr=8-1 ) </td>
   <td style="text-align:left;"> [ Guy Harrison ]( http://guyharrison.squarespace.com ), [ Steven Feuerstein ]( http://stevenfeuerstein.com ) </td>
  </tr>
  <tr>
   
   
   <td style="text-align:left;"> Web </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:left;"> [ Kaggle Learn: SQL ]( https://www.kaggle.com/learn/sql ) </td>
   <td style="text-align:left;"> [ Rachael Tatman ]( http://www.rctatman.com ) </td>
  </tr>
</tbody>
</table>
<h4>Visualisation</h4><table class="table table-hover table-condensed" style="font-size: 12px; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Area </th>
   <th style="text-align:left;"> Language </th>
   <th style="text-align:left;"> Source </th>
   <th style="text-align:right;"> # </th>
   <th style="text-align:left;"> Title </th>
   <th style="text-align:left;"> Author </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="2"> Reference </td>
   <td style="text-align:left;"> Python </td>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="3"> Web </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> [ matplotlib ]( https://matplotlib.org ) </td>
   <td style="text-align:left;"> Various </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> R </td>
   
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> [ ggplot2 ]( https://ggplot2.tidyverse.org/reference/index.html ) </td>
   <td style="text-align:left;"> [ Hadley Wickham ]( http://hadley.nz ), Various </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="3"> Training </td>
   <td style="text-align:left;"> Python </td>
   
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> [ Kaggle Learn: Data Visualisation ]( https://www.kaggle.com/learn/data-visualisation ) </td>
   <td style="text-align:left;"> [ Aleksey Bilogur ]( http://www.residentmar.io/about.html ) </td>
  </tr>
  <tr>
   
   <td style="text-align:left;vertical-align: middle !important;" rowspan="2"> R </td>
   <td style="text-align:left;"> Book </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> [ ggplot2: Elegant Graphics for Data Analysis (Use R!) 2nd Edition ]( https://www.amazon.co.uk/ggplot2-Elegant-Graphics-Data-Analysis-ebook/dp/B01GVCRF6M/ref=tmm_kin_swatch_0?_encoding=UTF8&amp;qid=1533142020&amp;sr=8-1 ) </td>
   <td style="text-align:left;"> [ Hadley Wickham ]( http://hadley.nz ), [ Carson Sievert ]( https://cpsievert.me ) </td>
  </tr>
  <tr>
   
   
   <td style="text-align:left;"> Web </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> [ Introduction to Data Science with R How to Manipulate, Visualize, and Model Data with the R Language ]( http://shop.oreilly.com/product/0636920034834.do ) </td>
   <td style="text-align:left;"> [ Garrett Grolemund ]( https://www.linkedin.com/in/garrett-grolemund-49328411/ ) </td>
  </tr>
</tbody>
</table>
<h4>Model</h4><table class="table table-hover table-condensed" style="font-size: 12px; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Area </th>
   <th style="text-align:left;"> Language </th>
   <th style="text-align:left;"> Source </th>
   <th style="text-align:right;"> # </th>
   <th style="text-align:left;"> Title </th>
   <th style="text-align:left;"> Author </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Reference </td>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="6"> Python </td>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="6"> Web </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> [ scikit-learn ]( http://scikit-learn.org/stable/ ) </td>
   <td style="text-align:left;"> Various </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="10"> Training </td>
   
   
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> [ Introduction to machine learning in Python with scikit-learn (video series) ]( https://www.dataschool.io/machine-learning-with-scikit-learn/ ) </td>
   <td style="text-align:left;"> [ Kevin Markham ]( https://www.dataschool.io ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> [ Kaggle Learn: Machine Learning ]( https://www.kaggle.com/learn/machine-learning ) </td>
   <td style="text-align:left;"> [ Dan Becker ]( https://www.linkedin.com/in/dansbecker/ ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> [ Kaggle Learn: Deep Learning ]( https://www.kaggle.com/learn/deep-learning ) </td>
   <td style="text-align:left;"> [ Dan Becker ]( https://www.linkedin.com/in/dansbecker/ ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> [ Machine Learning Crash Course with TensorFlow APIs ]( https://developers.google.com/machine-learning/crash-course/ ) </td>
   <td style="text-align:left;"> Google </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> [ Machine Learning with Text in Python ]( https://www.dataschool.io/learn/ ) </td>
   <td style="text-align:left;"> [ Kevin Markham ]( https://www.dataschool.io ) </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> Python, R </td>
   <td style="text-align:left;"> Web, Book </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> [ Machine Learning Mastery ]( https://machinelearningmastery.com ) </td>
   <td style="text-align:left;"> [ Jason Brownlee ]( https://machinelearningmastery.com/about/ ) </td>
  </tr>
  <tr>
   
   <td style="text-align:left;vertical-align: middle !important;" rowspan="5"> R </td>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="2"> Book </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:left;"> [ An Introduction to Statistical Learning with Applications in R ]( http://www-bcf.usc.edu/~gareth/ISL/ ) </td>
   <td style="text-align:left;"> [ Gareth James ]( https://www.amazon.co.uk/Gareth-James/e/B00F54OH4G/ref=dp_byline_cont_book_1 ), [ Daniela Witten ]( https://scholar.google.co.uk/citations?user=bHZf-c8AAAAJ&amp;hl=en ), [ Trevor Hastie ]( http://web.stanford.edu/~hastie/ ), [ Robert Tibshirani ]( https://statweb.stanford.edu/~tibs/ ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> [ Machine Learning with R - Second Edition: Expert techniques for predictive modeling to solve all your data analysis problems ]( https://www.amazon.co.uk/Machine-Learning-techniques-predictive-modeling-ebook/dp/B0114P1K1C/ref=pd_cp_351_1?_encoding=UTF8&amp;pd_rd_i=B0114P1K1C&amp;pd_rd_r=af4fbfc0-95ad-11e8-9889-7529903ded07&amp;pd_rd_w=zF0PO&amp;pd_rd_wg=CGjia&amp;pf_rd_i=desktop-dp-sims&amp;pf_rd_m=A3P5ROKL5A1OLE&amp;pf_rd_p=3262852920272843952&amp;pf_rd_r=TA0Z2YJAZ5TNV4SCTFN7&amp;pf_rd_s=desktop-dp-sims&amp;pf_rd_t=40701&amp;psc=1&amp;refRID=TA0Z2YJAZ5TNV4SCTFN7 ) </td>
   <td style="text-align:left;"> [ Brett Lantz ]( https://www.linkedin.com/in/brettlantz/ ) </td>
  </tr>
  <tr>
   
   
   <td style="text-align:left;vertical-align: middle !important;" rowspan="2"> Web </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:left;"> [ Statistical Learning ]( https://lagunita.stanford.edu/courses/HumanitiesSciences/StatLearning/Winter2016/info ) </td>
   <td style="text-align:left;"> [ Trevor Hastie ]( http://web.stanford.edu/~hastie/ ), [ Robert Tibshirani ]( https://statweb.stanford.edu/~tibs/ ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:left;"> [ Applied Predictive Modeling ]( http://appliedpredictivemodeling.com ) </td>
   <td style="text-align:left;"> [ Max Kuhn ]( https://www.linkedin.com/in/max-kuhn-864a9110/ ), [ Kjell Johnson ]( https://www.linkedin.com/in/kjell-johnson-9a65b33/ ) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Training, Reference </td>
   
   <td style="text-align:left;"> Book </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:left;"> [ Applied Predictive Modeling ]( https://www.amazon.co.uk/Applied-Predictive-Modeling-Max-Kuhn-ebook/dp/B00K15TZU0/ref=tmm_kin_swatch_0?_encoding=UTF8&amp;qid=1533142962&amp;sr=8-1 ) </td>
   <td style="text-align:left;"> [ Max Kuhn ]( https://www.linkedin.com/in/max-kuhn-864a9110/ ), [ Kjell Johnson ]( https://www.linkedin.com/in/kjell-johnson-9a65b33/ ) </td>
  </tr>
</tbody>
</table>
<h3>Statistics</h3><h4>Probability</h4><table class="table table-hover table-condensed" style="font-size: 12px; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Area </th>
   <th style="text-align:left;"> Language </th>
   <th style="text-align:left;"> Source </th>
   <th style="text-align:right;"> # </th>
   <th style="text-align:left;"> Title </th>
   <th style="text-align:left;"> Author </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="4"> Training </td>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="4"> Mathematics </td>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="4"> Web </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> [ Statistics 101 ]( https://www.youtube.com/channel/UCFrjdcImgcQVyFbK04MBEhA ) </td>
   <td style="text-align:left;"> [ Brandon Foltz ]( https://www.youtube.com/channel/UCFrjdcImgcQVyFbK04MBEhA ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> [ Statistics Foundations 1 ]( https://www.linkedin.com/learning/statistics-foundations-1 ) </td>
   <td style="text-align:left;"> [ Eddie Davila ]( https://www.linkedin.com/in/eddie-davila-b308b322/?trk=lil_instructor ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> [ Statistics Foundations 2 ]( https://www.linkedin.com/learning/statistics-foundations-2 ) </td>
   <td style="text-align:left;"> [ Eddie Davila ]( https://www.linkedin.com/in/eddie-davila-b308b322/?trk=lil_instructor ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> [ Statistics Foundations 3 ]( https://www.linkedin.com/learning/statistics-foundations-3 ) </td>
   <td style="text-align:left;"> [ Eddie Davila ]( https://www.linkedin.com/in/eddie-davila-b308b322/?trk=lil_instructor ) </td>
  </tr>
</tbody>
</table>
<h4>Statistics</h4><table class="table table-hover table-condensed" style="font-size: 12px; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Area </th>
   <th style="text-align:left;"> Language </th>
   <th style="text-align:left;"> Source </th>
   <th style="text-align:right;"> # </th>
   <th style="text-align:left;"> Title </th>
   <th style="text-align:left;"> Author </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Reference </td>
   <td style="text-align:left;"> R </td>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="5"> Web </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> [ Summary and Analysis of Extension Program Evaluation in R ]( http://rcompanion.org/handbook/ ) </td>
   <td style="text-align:left;"> [ Salvatore S. Mangiafico ]( https://scholar.google.com/citations?user=W9CxPFIAAAAJ&amp;hl=en ) </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="7"> Training </td>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="4"> Mathematics </td>
   
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> [ Statistics 101 ]( https://www.youtube.com/channel/UCFrjdcImgcQVyFbK04MBEhA ) </td>
   <td style="text-align:left;"> [ Brandon Foltz ]( https://www.youtube.com/channel/UCFrjdcImgcQVyFbK04MBEhA ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> [ Statistics Foundations 1 ]( https://www.linkedin.com/learning/statistics-foundations-1 ) </td>
   <td style="text-align:left;"> [ Eddie Davila ]( https://www.linkedin.com/in/eddie-davila-b308b322/?trk=lil_instructor ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> [ Statistics Foundations 2 ]( https://www.linkedin.com/learning/statistics-foundations-2 ) </td>
   <td style="text-align:left;"> [ Eddie Davila ]( https://www.linkedin.com/in/eddie-davila-b308b322/?trk=lil_instructor ) </td>
  </tr>
  <tr>
   
   
   
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> [ Statistics Foundations 3 ]( https://www.linkedin.com/learning/statistics-foundations-3 ) </td>
   <td style="text-align:left;"> [ Eddie Davila ]( https://www.linkedin.com/in/eddie-davila-b308b322/?trk=lil_instructor ) </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> Python, R </td>
   <td style="text-align:left;"> Web, Book </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> [ Machine Learning Mastery ]( https://machinelearningmastery.com ) </td>
   <td style="text-align:left;"> [ Jason Brownlee ]( https://machinelearningmastery.com/about/ ) </td>
  </tr>
  <tr>
   
   <td style="text-align:left;vertical-align: middle !important;" rowspan="2"> R </td>
   <td style="text-align:left;"> Book </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> [ An Introduction to Statistical Learning with Applications in R ]( http://www-bcf.usc.edu/~gareth/ISL/ ) </td>
   <td style="text-align:left;"> [ Gareth James ]( https://www.amazon.co.uk/Gareth-James/e/B00F54OH4G/ref=dp_byline_cont_book_1 ), [ Daniela Witten ]( https://scholar.google.co.uk/citations?user=bHZf-c8AAAAJ&amp;hl=en ), [ Trevor Hastie ]( http://web.stanford.edu/~hastie/ ), [ Robert Tibshirani ]( https://statweb.stanford.edu/~tibs/ ) </td>
  </tr>
  <tr>
   
   
   <td style="text-align:left;"> Web </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:left;"> [ Statistical Learning ]( https://lagunita.stanford.edu/courses/HumanitiesSciences/StatLearning/Winter2016/info ) </td>
   <td style="text-align:left;"> [ Trevor Hastie ]( http://web.stanford.edu/~hastie/ ), [ Robert Tibshirani ]( https://statweb.stanford.edu/~tibs/ ) </td>
  </tr>
</tbody>
</table>
<h3>Mathematics</h3><h4>Linear Algebra</h4><table class="table table-hover table-condensed" style="font-size: 12px; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Area </th>
   <th style="text-align:left;"> Language </th>
   <th style="text-align:left;"> Source </th>
   <th style="text-align:right;"> # </th>
   <th style="text-align:left;"> Title </th>
   <th style="text-align:left;"> Author </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="2"> Training </td>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="2"> Mathematics </td>
   <td style="text-align:left;"> Book </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> [ Linear Algebra: Step by Step ]( https://www.amazon.co.uk/Linear-Algebra-Step-Kuldeep-Singh-ebook/dp/B016WNBNGI/ref=tmm_kin_swatch_0?_encoding=UTF8&amp;qid=1533141864&amp;sr=8-1 ) </td>
   <td style="text-align:left;"> [ Kuldeep Singh ]( https://www.amazon.co.uk/Kuldeep-Singh/e/B001KI8PA8/ref=dp_byline_cont_book_1 ) </td>
  </tr>
  <tr>
   
   
   <td style="text-align:left;"> Web </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> [ Mathematics for Machine Learning: Linear Algebra ]( https://www.coursera.org/learn/linear-algebra-machine-learning ) </td>
   <td style="text-align:left;"> [ David Dye ]( http://www.imperial.ac.uk/people/david.dye ), [ Samuel J. Cooper ]( https://www.coursera.org/instructor/samuel-cooper ), [ A. Freddie Page ]( https://www.coursera.org/instructor/freddie-page ) </td>
  </tr>
</tbody>
</table>
<h4>Calculus</h4><table class="table table-hover table-condensed" style="font-size: 12px; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Area </th>
   <th style="text-align:left;"> Language </th>
   <th style="text-align:left;"> Source </th>
   <th style="text-align:right;"> # </th>
   <th style="text-align:left;"> Title </th>
   <th style="text-align:left;"> Author </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Training </td>
   <td style="text-align:left;"> Mathematics </td>
   <td style="text-align:left;"> Web </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> [ Mathematics for Machine Learning: Multivariate Calculus ]( https://www.coursera.org/learn/multivariate-calculus-machine-learning ) </td>
   <td style="text-align:left;"> [ David Dye ]( http://www.imperial.ac.uk/people/david.dye ), [ Samuel J. Cooper ]( https://www.coursera.org/instructor/samuel-cooper ), [ A. Freddie Page ]( https://www.coursera.org/instructor/freddie-page ) </td>
  </tr>
</tbody>
</table>
<h4>PCA</h4><table class="table table-hover table-condensed" style="font-size: 12px; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Area </th>
   <th style="text-align:left;"> Language </th>
   <th style="text-align:left;"> Source </th>
   <th style="text-align:right;"> # </th>
   <th style="text-align:left;"> Title </th>
   <th style="text-align:left;"> Author </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Training </td>
   <td style="text-align:left;"> Mathematics </td>
   <td style="text-align:left;"> Web </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> [ Mathematics for Machine Learning: PCA ]( https://www.coursera.org/learn/pca-machine-learning ) </td>
   <td style="text-align:left;"> [ Marc P. Deisenroth ]( https://sites.google.com/view/marcdeisenroth ) </td>
  </tr>
</tbody>
</table>
