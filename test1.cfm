<cfset gatt = new getallthetexts.textextractor()>

<!--- 
To run, create a sources directory and put some files in there.
This test template will scan the dir and call the read API on
each file (except .ds_store). 
--->
<cfset files = directoryList(expandPath("./sources"))>

<cfdump var="#files#">
<cfloop index="f" array="#files#">
	<cfif not findNoCase(".DS_Store",f)>
		<cfdump var="#gatt.read(f)#" label="#f#">
	</cfif>
</cfloop>

<p>
	Um done
</p>