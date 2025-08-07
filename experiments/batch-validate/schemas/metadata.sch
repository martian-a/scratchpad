<?xml version="1.0" encoding="UTF-8"?>
<sch:schema 
	xmlns:p="http://www.w3.org/ns/xproc"   
	xmlns:sch="http://purl.oclc.org/dsdl/schematron" 
	xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
	queryBinding="xslt2">
	
	<sch:ns uri="http://www.w3.org/ns/xproc" prefix="p"/>
	
	<sch:pattern>
		
		<sch:rule context="p:declare-step">
			
			<sch:assert test="self::*/normalize-space(@type) != ''">Step doesn't have a type.</sch:assert>
			<sch:assert test="self::*/normalize-space(@name) != ''">Step doesn't have a name.</sch:assert>
		</sch:rule>
	</sch:pattern>
	
</sch:schema>