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
| group     | Count | Events / μL | % of This Plot | % of All | Mean FL3-A | Mean FL2-A | CV FL3-A  | CV FL2-A  | Plot   | Cell | Sample  | Gate        | Mean FL1-A | CV FL1-A  | 
|-----------|-------|-------------|----------------|----------|------------|------------|-----------|-----------|--------|------|---------|-------------|------------|-----------| 
| All       | 76219 | 762         | 1.00E+00       | 1.00E+00 | 2283173    | 1221.167   | 0.3064661 | 0.7132268 | Plot 3 | A01  | Sample1 | NA          | NA         | NA        | 
| P5        | 1     | 0           | 1.31E-05       | 1.31E-05 | 2542497    | 104569     | 0         | 0         | Plot 3 | A01  | Sample1 | NA          | NA         | NA        | 
| P6        | 73733 | 737         | 9.67E-01       | 9.67E-01 | 2355233    | 1232.525   | 0.238634  | 0.2412269 | Plot 3 | A01  | Sample1 | NA          | NA         | NA        | 
| This Plot | 73733 | 737         | 1.00E+00       | 9.67E-01 | 2355233    | NA         | 0.238634  | NA        | Plot 4 | A01  | Sample1 | Gated on P6 | 9748.761   | 0.275229  | 
| P7        | 64316 | 643         | 8.72E-01       | 8.44E-01 | 2331800    | NA         | 0.2276446 | NA        | Plot 4 | A01  | Sample1 | Gated on P6 | 10138.584  | 0.2385646 | 
| P8        | 3357  | 34          | 4.55E-02       | 4.40E-02 | 2346500    | NA         | 0.2332314 | NA        | Plot 4 | A01  | Sample1 | Gated on P6 | 5447.78    | 0.2386932 | 
| All       | 5718  | 57          | 1.00E+00       | 1.00E+00 | 2034217    | 1166.867   | 0.3895973 | 0.431591  | Plot 3 | A02  | Sample2 | NA          | NA         | NA        | 
| P5        | 0     | 0           | 0.00E+00       | 0.00E+00 | 0          | 0          | 0         | 0         | Plot 3 | A02  | Sample2 | NA          | NA         | NA        | 
| P6        | 5217  | 52          | 9.12E-01       | 9.12E-01 | 2228867    | 1243.251   | 0.2269615 | 0.2344015 | Plot 3 | A02  | Sample2 | NA          | NA         | NA        | 
| This Plot | 5217  | 52          | 1.00E+00       | 9.12E-01 | 2228867    | NA         | 0.2269615 | NA        | Plot 4 | A02  | Sample2 | Gated on P6 | 9890.913   | 0.2813896 | 
| P7        | 4702  | 47          | 9.01E-01       | 8.22E-01 | 2219186    | NA         | 0.2249267 | NA        | Plot 4 | A02  | Sample2 | Gated on P6 | 10274.234  | 0.247009  | 
| P8        | 245   | 2           | 4.70E-02       | 4.28E-02 | 2232615    | NA         | 0.2245781 | NA        | Plot 4 | A02  | Sample2 | Gated on P6 | 5187.127   | 0.228119  | 
