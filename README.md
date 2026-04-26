> R Environment
>
> When installing a package, run `renv::snapshot()` afterwards. 
> You can also run `renv::install()` so it will add it to the snapshot for you.
> If anyone installs a package/update the environment, run `renv::restore()`.

# Project 1 -- Checkpoint 3

By the end of the week, your updated report should contain:
two new country-level data sources

One of these must be acquired using APIs, the other using webscraping.

**descriptions of each of the new datasets**

* a “meta” dataset containing all the acquired data (joined together)
* at least two data summaries OR visualizations incorporating the additional country-level data
* your webscraped data must come from a multi-paged source, so that iteration is used to gather all the data

__Delegated Tasks__ 
@nanamiikii - focus on web scraping the countries, iterating over the `region` filters in advanced filter from [WHO Measles vaccination record](https://immunizationdata.who.int/global/wiise-detail-page/measles-vaccination-coverage?CODE=Global&ANTIGEN=MCV1&YEAR=&ADVANCED_GROUPINGS=AFRO)

@an-avocado - focus on pulling data from API, up to him what it's going to be on. 

some starting questions: 
income by region, healthcare expenditure, some other cool things.

@librill - focus on some of the next week work a bit and the map visualization.

# Project 1 -- Checkpoint 2

Guidelines from 
**4 summary tables:**

Two data summaries that use existing (unmodified) columns in the data
* ~~At least one of these summaries need to be produced with a custom function.~~ -- DONE
* At least one of these summaries need to include iteration (either inside or outside of a function). 

__TO DO__ 
~~@nanamiikii Focus on lab confirmed by country/year~~ DONE
@an-avocado Focus on total measels by country/year
Keep consistent regardless of final decision.

Two data summaries that modify columns from the original data
* At least one of these summaries need to be produced with a custom function.
* At least one of these summaries need to include iteration (either inside or outside of a function).

__TO DO__
@librill Focus on the variable produced by a custom function, with a focus on creating confirmed v. suspected proportions
@an-avocado Focus on a summary for the normalized proportion of cases by population by country or something like that

Stat 541 only: Summary tables must at a minimum have:
* Formatted values (e.g., decimals, percentages, currencies)
* Boldface headers
* Captions
