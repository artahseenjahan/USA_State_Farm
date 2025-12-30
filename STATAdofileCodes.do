//Answer 1

import delimited "/Users/tahseenjahan/Downloads/Quant Exercise in Stata/raw_countydata.csv", encoding(ISO-8859-1)clear

describe
tab
list

//Answer 2

rename ab84002 acres_corn

label variable acres_corn "Acres of harvested corn"

rename ab84006 acres_wheat

label variable acres_wheat "Acres of wheat"

 keep gisjoin year state county acres_corn acres_wheat
 
 //Answer 3
 
  duplicates report GISJOIN
   duplicates list GISJOIN
   duplicates drop GISJOIN, force
 
 save "/Users/tahseenjahan/Downloads/Quant Exercise in Stata/firstfile.dta"
   
 use "/Users/tahseenjahan/Desktop/test_mergefile.dta", clear
 rename GISJOIN YEAR STATE COUNTY, lower
 save "/Users/tahseenjahan/Desktop/test_mergefile.dta", replace
 
 
 use "/Users/tahseenjahan/Downloads/Quant Exercise in Stata/firstfile.dta"
  merge 1:1 gisjoin using "/Users/tahseenjahan/Desktop/test_mergefile.dta"
  
   keep if _merge==3
  drop _merge
 describe farmland farms tractors
 
//Answer 4

  gen pct_corn =(acres_corn / farmland)*100
  label variable pct_corn "Percentage of farmland in corn"

gen pct_wheat =(acres_wheat / farmland)*100
label variable pct_wheat "Percentage of farmland in wheat"

//Answer 5

mean pct_corn pct_wheat if inlist(state, "Kansas", "Iowa", "Michigan") //Considering the average of all three states together

 mean pct_corn pct_wheat if state== "Kansas"
 mean pct_corn pct_wheat if state== "Iowa"
 mean pct_corn pct_wheat if state== "Michigan" //Considering the average of three states seperately
 
//Answer 6

 twoway (scatter pct_corn pct_wheat) (lfit pct_corn pct_wheat)

 graph save Graph "/Users/tahseenjahan/Desktop/lineoffit_graph.gph"

//Answer 7
 gen tractors_per_farm = tractors/farms
 label variable tractors_per_farm "Number of tractors per farm"

 //Answer 8
 
reg tractors_per_farm pct_corn pct_wheat, robust //Using robust to avoid heteroskedasticity issues

//Answer 9

tab state
encode state, gen (state_dum)
reg tractors_per_farm pct_corn pct_wheat i.state_dum, robust

//Attaching a graph for visualization of the states

graph bar (mean) pct_corn pct_wheat, over(state_dum) blabel(bar) title("Average pct_corn and pct_wheat by State")





