# cleanBDfile
This package contains a single function, `cleanBDfile`, that reorganizes an output file from the BD Accuri C6 Plus flow cytometer software.

You can install this package using [devtools](https://cran.r-project.org/web/packages/devtools/index.html).

```
devtools::install_github('jessicabeyer/cleanBDfile')
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
