# cleanBDfile
This package contains a single function, `cleanBDfile`, that reorganizes an output file from the BD Accuri C6 Plus flow cytometer software.

You can install this package using [devtools](https://cran.r-project.org/web/packages/devtools/index.html).

```
devtools::install_github('jessicabeyer/cleanBDfile')
```

As an example, we can load an example xls file containing the Batch Analysis results

```
batchAnalysisResults <- dir(system.file("exampleFC.xls"))
```


