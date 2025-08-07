# Batch Validate

A working example (2025-07-21).

## Table of contents
1. [Summary](#summary)
1. [Dependencies](#dependencies)
1. [Run from the command-line](#how-to-run)

## Summary <a id="summary"></a>

Find a set of files (using cx:fileset) and then validate each file against multiple schemas.

* Input ports: 
    * none
* Options:
    *  `source-dir` - a path to the top-level directory in which to start the search for files to validate
* Output ports: 
    * `result`
    
    
This particular example is hard-coded to search for `*.xpl` files and validate them against the three schemas in `batch-validate/schemas`.

## Dependencies <a id="dependencies"></a>

* XML Calabash 3.*

## Run from the command line <a id="how-to-run"></a>

Unix:
```
$> java -cp  /path/to/calabash.jar com.xmlcalabash.app.Main path/to/batch_validate.xpl source-dir=path/to/directory/to/search
```

## Notes

This code was written as an example of how someone's very specific use-case could be addressed.  It wasn't written with any other use-cases in mind (hence the hard-coding and lack of options).