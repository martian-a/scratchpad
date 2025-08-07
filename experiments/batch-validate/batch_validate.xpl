<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:cx="http://xmlcalabash.com/ns/extensions"
    xmlns:m="http://xylarium.org/ns/xml/documentation"
    xmlns:p="http://www.w3.org/ns/xproc"      
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:u="http://xylarium.org/ns/xproc/steps/utils"   
    name="batch-validate"
    type="u:batch-validate"
    version="3.1">
    
    <p:documentation>
    	<m:document>
    		<m:title>Custom Batch Validation</m:title>
    		<m:desc>
    			<m:ol>
    				<m:ingress>Finds and validates multiple files against:</m:ingress>
    				<m:li>a RelaxNG schema</m:li>    				
    				<m:li>Schematron A</m:li>
    				<m:li>Schematron B</m:li>
    			</m:ol>
    		</m:desc>
    		<m:note>Created in response to a problem posed in XML Slack by Syd Bauman.</m:note>
    		<m:note>Depends on an extension library that's only supported by XML Calabash: <m:link href=" https://docs.xmlcalabash.com/reference/current/cx-fileset.html">cx:fileset</m:link></m:note>
    		<m:contributors>
    			<m:original-author>Sheila Thomson</m:original-author>
    		</m:contributors>
    		<m:history created="2025-07-21" />
    	</m:document>
    </p:documentation>
  	
  	
	<p:documentation>
		<m:component>Import the cx:fileset extension library.</m:component>
	</p:documentation>
	<p:import href="https://xmlcalabash.com/ext/library/fileset.xpl"/>
	
		
	<p:documentation>
		<m:component>The source data serialised as XML.</m:component>
	</p:documentation>
    <p:output port="result" primary="true" sequence="true" />
	
	
	<p:documentation>
		<m:component>A path to the root directory in which to begin searching for files to validate.</m:component>
	</p:documentation>
	<p:option name="source-dir" required="true" as="xs:anyURI" />	
				

	<p:documentation>
		<m:component>Find the files that need to be validated.</m:component>
	</p:documentation>
	<cx:fileset path="{$source-dir}" includes="*.xpl" />
	
	<p:documentation>
		<m:component>Make the file paths absolute.</m:component>
	</p:documentation>
	<p:make-absolute-uris match="/c:directory//c:file" />
	
	
	<p:documentation>
		<m:component>
			<m:desc>
				<m:ol>
					<m:ingress>For each file:</m:ingress>
					<m:li>work out its full path from the data available from the <m:code>c:file</m:code> element</m:li>
					<m:li>use the full path to read (load) a copy of the file</m:li>
					<m:li>validate it against the RelaxNG schema; the default report format is XVRL</m:li>
					<m:li>validate it against the first Schematron schema; specifying XVRL for the report format</m:li>
					<m:li>validate it against the second Schematron schema; specifying XVRL for the report format</m:li>
					<m:li>discard (sink) the copy of the file</m:li>
					<m:li>collect together all three validation reports and wrap them in a <m:code>c:file</m:code> element, with the file's name and full path added as attributes to the wrapper.</m:li>				
				</m:ol>
				<m:p>For each file, validate against the RelaxNG schema.</m:p>
				<m:p>A copy of the file will be output via the result port, whilst the validation results will be output via the report port as XVRL.</m:p>
			</m:desc>
		</m:component>
	</p:documentation>
	<p:for-each name="validate">
		<p:with-input select="/c:directory//c:file" />
		
		<p:output port="result" primary="true" sequence="false" />
		
		<p:variable name="file-base-uri" select="/c:file/text()" as="xs:string" />		
		<p:variable name="file-name" select="c:file/@name" as="xs:string" />
		<p:variable name="file-to-validate" select="string-join(($file-base-uri, $file-name), '/')" as="xs:string" />
	
		<p:load href="{$file-to-validate}" />
		
		<p:validate-with-relax-ng assert-valid="false" name="relaxng">
			<p:with-input port="schema" href="schemas/xproc31.rnc" />
		</p:validate-with-relax-ng>

		<p:validate-with-schematron assert-valid="false" name="schematron-a" report-format="xvrl">
			<p:with-input port="schema" href="schemas/metadata.sch" />
		</p:validate-with-schematron>	
		
		<p:validate-with-schematron assert-valid="false" name="schematron-b" report-format="xvrl">
			<p:with-input port="schema" href="schemas/documentation.sch" />
		</p:validate-with-schematron>	
		
		<p:sink />
		
		<p:identity>
			<p:with-input>
				<p:inline>
					<c:file href="{$file-to-validate}" name="{$file-name}" />
				</p:inline>
			</p:with-input>
		</p:identity>
		
		<p:insert match="/c:file" position="last-child">
			<p:with-input port="insertion">
				<p:pipe port="report" step="relaxng" />
				<p:pipe port="report" step="schematron-a" />
				<p:pipe port="report" step="schematron-b" />
			</p:with-input>
		</p:insert>
		
	</p:for-each>	
	
	
	<p:documentation>
		<m:component>Collect together the results for all the validated files and wrap them in a <m:code>u:fileset</m:code> element.</m:component>
	</p:documentation>
	<p:wrap-sequence wrapper="u:fileset" />
	
	
	<p:documentation>
		<m:component>Add an attribute to the wrapper, recording the <m:code>source-dir</m:code> that was originally supplied to this XProc step as an option.</m:component>
	</p:documentation>
	<p:add-attribute attribute-name="source-dir" attribute-value="{$source-dir}" />

</p:declare-step>