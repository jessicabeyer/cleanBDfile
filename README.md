# cleanBDfile
This package contains a single function, `cleanBDfile`, that reorganizes an output file from the BD Accuri C6 Plus flow cytometer software. Specifically, this function takes an xls file generated from the Batch Analysis tab and organizes for analysis in R.

You can install this package using [devtools](https://cran.r-project.org/web/packages/devtools/index.html).

```
devtools::install_github('jessicabeyer/cleanBDfile')
library(cleanBDfile
```

As an example, we can look at an example xls file containing Batch Analysis results

```
batchAnalysisResults <- system.file("extdata","exampleFC.xls", package="cleanBDfile")
```
The format of this xls file would be very difficult to work with in R:

|                                  |          |             |                |             |                |              |             |             |              |              | 
|----------------------------------|----------|-------------|----------------|-------------|----------------|--------------|-------------|-------------|--------------|--------------| 
| Plot 3: A01 Sample1              | Count    | Events / μL | % of This Plot | % of All    | Mean FL3-A     | Mean FL2-A   | CV FL3-A    | CV FL2-A    | Median FL3-A | Median FL2-A | 
| All                              | "76,219" | 762         | 100.00%        | 100.00%     | "2,283,173.40" | "1,221.17"   | 30.65%      | 71.32%      |              |              | 
| P5                               | 1        | 0           | 0.00%          | 0.00%       | "2,542,497.00" | "104,569.00" | 0.00%       | 0.00%       |              |              | 
| P6                               | "73,733" | 737         | 96.74%         | 96.74%      | "2,355,232.89" | "1,232.53"   | 23.86%      | 24.12%      |              |              | 
|                                  |          |             |                |             |                |              |             |             |              |              | 
| Plot 4: A01 Sample1: Gated on P6 | Count    | Events / μL | % of This Plot | % of All    | Mean FL3-A     | Mean FL1-A   | CV FL3-A    | CV FL1-A    | Median FL3-A | Median FL1-A | 
| This Plot                        | "73,733" | 737         | 100.00%        | 96.74%      | "2,355,232.89" | "9,748.76"   | 23.86%      | 27.52%      |              |              | 
| P7                               | "64,316" | 643         | 87.23%         | 0.843831591 | 2331800.431    | 10138.58446  | 0.227644637 | 0.23856464  |              |              | 
| P8                               | 3357     | 34          | 0.045529139    | 0.044044136 | 2346499.822    | 5447.780459  | 0.233231419 | 0.238693222 |              |              | 

Instead, use `cleanBDfile` to read this xls file into R and organize the data.
```
cleanBDfile(batchAnalysisResults)
```
| Cell | Sample  | Gate        | Plot   | group     | Count | Events / μL | Mean FL1-A | Mean FL2-A | Mean FL3-A | CV FL1-A  | CV FL2-A  | CV FL3-A  | 
|------|---------|-------------|--------|-----------|-------|-------------|------------|------------|------------|-----------|-----------|-----------| 
| A01  | Sample1 | NA          | Plot 3 | All       | 76219 | 762         | NA         | 1221.167   | 2283173    | NA        | 0.7132268 | 0.3064661 | 
| A01  | Sample1 | NA          | Plot 3 | P5        | 1     | 0           | NA         | 104569     | 2542497    | NA        | 0         | 0         | 
| A01  | Sample1 | NA          | Plot 3 | P6        | 73733 | 737         | NA         | 1232.525   | 2355233    | NA        | 0.2412269 | 0.238634  | 
| A01  | Sample1 | Gated on P6 | Plot 4 | This Plot | 73733 | 737         | 9748.761   | NA         | 2355233    | 0.275229  | NA        | 0.238634  | 
| A01  | Sample1 | Gated on P6 | Plot 4 | P7        | 64316 | 643         | 10138.584  | NA         | 2331800    | 0.2385646 | NA        | 0.2276446 | 
| A01  | Sample1 | Gated on P6 | Plot 4 | P8        | 3357  | 34          | 5447.78    | NA         | 2346500    | 0.2386932 | NA        | 0.2332314 | 
| A02  | Sample2 | NA          | Plot 3 | All       | 5718  | 57          | NA         | 1166.867   | 2034217    | NA        | 0.431591  | 0.3895973 | 
| A02  | Sample2 | NA          | Plot 3 | P5        | 0     | 0           | NA         | 0          | 0          | NA        | 0         | 0         | 
| A02  | Sample2 | NA          | Plot 3 | P6        | 5217  | 52          | NA         | 1243.251   | 2228867    | NA        | 0.2344015 | 0.2269615 | 
| A02  | Sample2 | Gated on P6 | Plot 4 | This Plot | 5217  | 52          | 9890.913   | NA         | 2228867    | 0.2813896 | NA        | 0.2269615 | 
| A02  | Sample2 | Gated on P6 | Plot 4 | P7        | 4702  | 47          | 10274.234  | NA         | 2219186    | 0.247009  | NA        | 0.2249267 | 
| A02  | Sample2 | Gated on P6 | Plot 4 | P8        | 245   | 2           | 5187.127   | NA         | 2232615    | 0.228119  | NA        | 0.2245781 | 


