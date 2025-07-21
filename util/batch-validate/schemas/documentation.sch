<?xml version="1.0" encoding="UTF-8"?>
<sch:schema 
	xmlns:p="http://www.w3.org/ns/xproc"   
	xmlns:sch="http://purl.oclc.org/dsdl/schematron" 
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    queryBinding="xslt2">
	
	<sch:ns uri="http://www.w3.org/ns/xproc" prefix="p"/>
	
    <sch:pattern>
        
        <sch:rule context="/*">
            
            <sch:assert test="descendant::p:documentation">No documentation found.</sch:assert>
        </sch:rule>
    </sch:pattern>
	
</sch:schema>