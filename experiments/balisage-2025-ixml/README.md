# Balisage 2025 iXML Experiment

Status: Semi-working (2025-08-07).

## Table of contents
1. [Summary](#summary)
1. [History](#history)
1. [Dependencies](#dependencies)
1. [Run in Browser](#how-to-run)

## Summary <a id="summary"></a>

Find the DTD DOCTYPE Declaration at the top of an XML file and convert it to XML.
    
## History <a id="history"></a> 

This Invisible XML grammar was originally written by me (Sheila Thomson) to parse a DTD Doctype Declaration as a _single-line string_  that had _already been extracted_ from an XML file.  It was a companion asset for a paper I presented first at Markup UK 2025 and then secondly, at Balisage 2025.  After the second presentation, an impromptu collaborative coding session occurred, during which the audience recommended improvements and extensions and we tested the changes live using [https://johnlumley.github.io/jwiXML.xhtml]()

The first changes were an improvement pointed out by John Lumley, reducing "P", "U", "B", "L", "I", "C" to "PUBLIC" (and the same for SYSTEM and DOCTYPE).

Next were a demonstration of how to:
* add content that's not in the source (`foo` and `bar`) 
* ignore content at the beginning and/or end of a file (`any-junk`)

as advised by Steven Pemberton.

Then Vincent Lizzi asked "What if the input has a commented-out DOCTYPE followed by the actual DOCTYPE?" and it all went downhill from there ;)

After the session had finished, Steven shared the iXML for a `comment`.

Many other people contributed suggestions and questions to the session but sadly I don't remember exactly who said what.

Thank you to Debbie and Tommie for inviting me to give an encore presentation and also to everyone who contributed to the fun.


## How to Run <a id="how-to-run"></a>

* In a browser, open [https://johnlumley.github.io/jwiXML.xhtml]()
* Paste the contents of `experiment.ixml` into the `Grammar` textbox.
* Paste the contents of `balisage_2025.xml` into the `Input` textbox.
* Click on the `GO!` button
* The `Result` will display on the right-hand side.