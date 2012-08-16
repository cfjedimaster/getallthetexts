GetAllTheTexts
================

A CFC wrapper to the Apache Tika project. Basically - pass a file name to the CFC and it will attempt to get
metadata and text from the document.

Getting Started
---------------

Create an instance of the CFC. Like:

<cfset gatt = new getallthetexts.textextractr>

Then call read() on a file name.

<cfset stuff = gatt.read("/Users/ray/Documents/foo.doc")>

The result is a structure with 2-3 keys. If everything worked well, you get one key called metadata and one key called text.
I bet you can guess what is returned in each key.

If things went poorly, you get a key called error with a stack trace. 
