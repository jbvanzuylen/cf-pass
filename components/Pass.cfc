﻿<cfcomponent displayname="Pass" output="false">
  <!--- The standard dimension of the image for each type --->
  <cfset variables.imageDimension = structNew() />
  <cfset variables.imageDimension["icon"] = {width = 29, height = 29} />
  <cfset variables.imageDimension["icon@2x"] = {width = 58, height = 58} />
  <cfset variables.imageDimension["logo"] = {width = 300, height = 30} />
  <cfset variables.imageDimension["logo@2x"] = {width = 600, height = 60} />

  <!--- The list of valid styles --->
  <cfset variables.styles = arrayNew(1) />
  <cfset variables.styles[1] = "boardingPass" />
  <cfset variables.styles[2] = "coupon" />
  <cfset variables.styles[3] = "eventTicket" />
  <cfset variables.styles[4] = "storeCard" />
  <cfset variables.styles[5] = "generic" />

  <!--- The list of valid barcode formats --->
  <cfset variables.barcodeFormats = arrayNew(1) />
  <cfset variables.barcodeFormats[1] = "PKBarcodeFormatQR" />
  <cfset variables.barcodeFormats[2] = "PKBarcodeFormatPDF417" />
  <cfset variables.barcodeFormats[3] = "PKBarcodeFormatAztec" />
  <cfset variables.barcodeFormats[4] = "PKBarcodeFormatCode128" />

  <!---
    Initializes this pass
  --->
  <cffunction name="init" access="public" returntype="Pass" output="false">
    <cfargument name="style" type="string" required="true" />

    <!--- Check style --->
    <cfif NOT arrayContains(variables.styles, arguments.style)>
      <cfthrow type="pass.IllegalArgumentException" message="Invalid style #arguments.style#" />
    </cfif>

    <!--- Init variables --->
    <cfset variables.id = createUUID() />
    <cfset variables.dir = getTempDirectory() & server.separator.file & variables.id />
    <cfset variables.style = arguments.style />
    <cfset variables.pass = structNew() />
    <cfset variables.pass["formatVersion"] = 1 />
    <cfset variables.pass[variables.style] = structNew() />

    <!--- Create directory --->
    <cfset directoryCreate(variables.dir) />

    <cfreturn this />
  </cffunction>

  <!---
    Set the team identifier for this pass

    @param teamIdentifier the team identifier to be set
  --->
  <cffunction name="setTeamIdentifier" access="public" returntype="void" output="false">
    <cfargument name="teamIdentifier" type="string" required="true" />

    <!--- Set description --->
    <cfset variables.pass["teamIdentifier"] = arguments.teamIdentifier />
  </cffunction>

  <!---
    Set the type identifier of this pass

    @param typeIdentifier the type identifier to be set
  --->
  <cffunction name="setTypeIdentifier" access="public" returntype="void" output="false">
    <cfargument name="typeIdentifier" type="string" required="true" />

    <!--- Set type identifier --->
    <cfset variables.pass["passTypeIdentifier"] = arguments.typeIdentifier />
  </cffunction>

  <!---
    Set the serial number of this pass

    @param serialNumber the serial number to be set
  --->
  <cffunction name="setSerialNumber" access="public" returntype="void" output="false">
    <cfargument name="serialNumber" type="string" required="true" />

    <!--- Set serial number --->
    <cfset variables.pass["serialNumber"] = arguments.serialNumber />
  </cffunction>

  <!---
    Set the authentication token of this pass

    @param authenticationToken the authentication token to be set
  --->
  <cffunction name="setAuthenticationToken" access="public" returntype="void" output="false">
    <cfargument name="authenticationToken" type="string" required="true" />

    <!--- Set authentication token --->
    <cfset variables.pass["authenticationToken"] = arguments.authenticationToken />
  </cffunction>

  <!---
    Set the description for this pass

    @param description the description to be set
  --->
  <cffunction name="setDescription" access="public" returntype="void" output="false">
    <cfargument name="description" type="string" required="true" />

    <!--- Set description --->
    <cfset variables.pass["description"] = arguments.description />
  </cffunction>

  <!---
    Set the organization name for this pass

    @param organizationName the organization name to be set
  --->
  <cffunction name="setOrganizationName" access="public" returntype="void" output="false">
    <cfargument name="organizationName" type="string" required="true" />

    <!--- Set description --->
    <cfset variables.pass["organizationName"] = arguments.organizationName />
  </cffunction>

  <!---
    Set the background color for this pass

    @param backgroundColor the background color to be set
  --->
  <cffunction name="setBackgroundColor" access="public" returntype="void" output="false">
    <cfargument name="backgroundColor" type="string" required="true" />

    <!--- Set description --->
    <cfset variables.pass["backgroundColor"] = arguments.backgroundColor />
  </cffunction>

  <!---
    Set the foreground color for this pass

    @param foregroundColor the foreground color to be set
  --->
  <cffunction name="setForegroundColor" access="public" returntype="void" output="false">
    <cfargument name="foregroundColor" type="string" required="true" />

    <!--- Set description --->
    <cfset variables.pass["foregroundColor"] = arguments.foregroundColor />
  </cffunction>

  <!---
    Set the label color for this pass

    @param labelColor the label color to be set
  --->
  <cffunction name="setLabelColor" access="public" returntype="void" output="false">
    <cfargument name="labelColor" type="string" required="true" />

    <!--- Set description --->
    <cfset variables.pass["labelColor"] = arguments.labelColor />
  </cffunction>

  <!---
    Set the icon for this pass

    @param path the file path of the icon to be set
  --->
  <cffunction name="setIcon" access="public" returntype="void" output="false">
    <cfargument name="path" type="string" required="true" />

    <!--- Defined local variables --->
    <cfset var image = "" />
    <cfset var dimension = "" />
    <cfset var file = "" />

    <!--- Check if file exists --->
    <cfif NOT fileExists(arguments.path)>
      <cfthrow type="pass.FileNotFoundException" message="File #arguments.path# not found" />
    </cfif>

    <!--- Create icon image (normal size) --->
    <cfset image = imageRead(arguments.path) />
    <cfset dimension = variables.imageDimension["icon"] />
    <cfset imageScaleToFit(image, dimension.width, dimension.height) />
    <cfset imageWrite(image, variables.dir & server.separator.file & "icon.png") />

    <!--- Create icon image (double size) --->
    <cfset image = imageRead(arguments.path) />
    <cfset dimension = variables.imageDimension["icon@2x"] />
    <cfset imageScaleToFit(image, dimension.width, dimension.height) />
    <cfset imageWrite(image, variables.dir & server.separator.file & "icon@2x.png") />
  </cffunction>

  <!---
    Sets the logo of this pass

    @param path the file path of the logo to be set
  --->
  <cffunction name="setLogo" access="public" returntype="void" output="false">
    <cfargument name="path" type="string" required="true" />

    <!--- Defined local variables --->
    <cfset var image = "" />
    <cfset var dimension = "" />
    <cfset var file = "" />

    <!--- Check if file exists --->
    <cfif NOT fileExists(arguments.path)>
      <cfthrow type="pass.FileNotFoundException" message="File #arguments.path# not found" />
    </cfif>

    <!--- Create logo image (normal size) --->
    <cfset image = imageRead(arguments.path) />
    <cfset dimension = variables.imageDimension["logo"] />
    <cfset imageScaleToFit(image, dimension.width, dimension.height) />
    <cfset imageWrite(image, variables.dir & server.separator.file & "logo.png") />

    <!--- Create logo image (double size) --->
    <cfset image = imageRead(arguments.path) />
    <cfset dimension = variables.imageDimension["logo@2x"] />
    <cfset imageScaleToFit(image, dimension.width, dimension.height) />
    <cfset imageWrite(image, variables.dir & server.separator.file & "logo@2x.png") />
  </cffunction>

  <!---
    Set logo text

    @param text the logo text to be set
  --->
  <cffunction name="setLogoText" access="public" returntype="void" output="false">
    <cfargument name="text" type="string" required="true" />

    <!--- Set logo text --->
    <cfset variables.pass["logoText"] = arguments.text />
  </cffunction>

  <!---
    Adds a new header field to this pass

    @param key the unique of the field to be added
    @param label the label of the field to be added
    @param value the value of the field to be added
  --->
  <cffunction name="addHeaderField" access="public" returntype="void" output="false">
    <cfargument name="key" type="string" required="true" />
    <cfargument name="label" type="string" required="true" />
    <cfargument name="value" type="string" required="true" />

    <!--- Set category --->
    <cfset arguments.category = "headerFields" />

    <!--- Add field --->
    <cfset addField(argumentCollection=arguments) />
  </cffunction>

  <!---
    Adds a new primary field to this pass

    @param key the unique of the field to be added
    @param label the label of the field to be added
    @param value the value of the field to be added
  --->
  <cffunction name="addPrimaryField" access="public" returntype="void" output="false">
    <cfargument name="key" type="string" required="true" />
    <cfargument name="label" type="string" required="true" />
    <cfargument name="value" type="string" required="true" />

    <!--- Set category --->
    <cfset arguments.category = "primaryFields" />

    <!--- Add field --->
    <cfset addField(argumentCollection=arguments) />
  </cffunction>

  <!---
    Adds a new secondary field to this pass

    @param key the unique of the field to be added
    @param label the label of the field to be added
    @param value the value of the field to be added
  --->
  <cffunction name="addSecondaryField" access="public" returntype="void" output="false">
    <cfargument name="key" type="string" required="true" />
    <cfargument name="label" type="string" required="true" />
    <cfargument name="value" type="string" required="true" />

    <!--- Set category --->
    <cfset arguments.category = "secondaryFields" />

    <!--- Add field --->
    <cfset addField(argumentCollection=arguments) />
  </cffunction>

  <!---
    Adds a new auxiliary field to this pass

    @param key the unique of the field to be added
    @param label the label of the field to be added
    @param value the value of the field to be added
  --->
  <cffunction name="addAuxiliaryField" access="public" returntype="void" output="false">
    <cfargument name="key" type="string" required="true" />
    <cfargument name="label" type="string" required="true" />
    <cfargument name="value" type="string" required="true" />

    <!--- Set category --->
    <cfset arguments.category = "auxiliaryFields" />

    <!--- Add field --->
    <cfset addField(argumentCollection=arguments) />
  </cffunction>

  <!---
    Adds a new back field to this pass

    @param key the unique of the field to be added
    @param label the label of the field to be added
    @param value the value of the field to be added
  --->
  <cffunction name="addBackField" access="public" returntype="void" output="false">
    <cfargument name="key" type="string" required="true" />
    <cfargument name="label" type="string" required="true" />
    <cfargument name="value" type="string" required="true" />

    <!--- Set category --->
    <cfset arguments.category = "backFields" />

    <!--- Add field --->
    <cfset addField(argumentCollection=arguments) />
  </cffunction>

  <!---
    Adds a new field to this pass
  --->
  <cffunction name="addField" access="private" returntype="void" output="false">
    <cfargument name="category" type="string" required="true" />
    <cfargument name="key" type="string" required="true" />
    <cfargument name="label" type="string" required="true" />
    <cfargument name="value" type="string" required="true" />

    <!--- Defined local variables --->
    <cfset var field = structNew() />
    <cfset var passFields = variables.pass[variables.style] />

    <!--- Check if field array exists --->
    <cfif NOT structKeyExists(passFields, arguments.category)>
      <cfset passFields[arguments.category] = arrayNew(1) />
    </cfif>

    <!--- Build structure --->
    <cfset structAppend(field, arguments) />

    <!--- Add field to list --->
    <cfset arrayAppend(passFields[arguments.category], field) />
  </cffunction>

  <!---
    Adds a new barcode to this pass

    @param format the format of the barcode to be added
    @param message
    @param messageEncoding
  --->
  <cffunction name="addBarcode" access="public" returntype="void" output="false">
    <cfargument name="format" type="string" required="true" />
    <cfargument name="message" type="string" required="true" />
    <cfargument name="messageEncoding" type="string" required="false" />

    <!--- Defined local variables --->
    <cfset var barcode = structNew() />

    <!--- Check barcode format --->
    <cfif NOT arrayContains(variables.barcodeFormats, arguments.format)>
      <cfthrow type="pass.IllegalArgumentException" message="Invalid format #arguments.format#" />
    </cfif>

    <!--- Check if array exists --->
    <cfif NOT structKeyExists(variables.pass, "barcodes")>
      <cfset variables.pass["barcodes"] = arrayNew(1) />
    </cfif>

    <!--- Build structure --->
    <cfset structAppend(barcode, arguments) />

    <!--- Add primary field to list --->
    <cfset arrayAppend(variables.pass["barcodes"], barcode) />
  </cffunction>

  <!---
    Adds a new location to this pass

    @param longitude
    @param latitude
    @param altitude
    @param relevantText
  --->
  <cffunction name="addLocation" access="public" returntype="void" output="false">
    <cfargument name="longitude" type="string" required="true" />
    <cfargument name="latitude" type="string" required="true" />
    <cfargument name="altitude" type="string" required="false" />
    <cfargument name="relevantText" type="string" required="false" />

    <!--- Defined local variables --->
    <cfset var location = structNew() />

    <!--- Check if array exists --->
    <cfif NOT structKeyExists(variables.pass, "locations")>
      <cfset variables.pass["locations"] = arrayNew(1) />
    </cfif>

    <!--- Build structure --->
    <cfset structAppend(location, arguments) />

    <!--- Add primary field to list --->
    <cfset arrayAppend(variables.pass["locations"], location) />
  </cffunction>

  <!---
    Build this pass
  --->
  <cffunction name="build" access="public" returntype="void" output="false">
    <cfargument name="keyStoreFilePath" type="string" required="true" />
    <cfargument name="keyStorePassword" type="string" required="true" />

    <!--- Defined local variables --->
    <cfset var pass = "" />
    <cfset var manifest = structNew() />
    <cfset var passUtils = createObject("java", "org.primeoservices.cfpass.PassUtils") />
    <cfset var dirContent = "" />
    <cfset var fileContent = "" />

    <!--- Generate pass --->
    <cfset pass = serializeJSON(variables.pass) />
    <cfset fileWrite(variables.dir & server.separator.file & "pass.json", pass, "utf-8") />

    <!--- Generate manifest --->
    <cfset dirContent = directoryList(variables.dir, false, "query") />
    <cfloop query="dirContent">
      <!--- Read file content to calculate hash --->
      <cfset fileContent = fileReadBinary(dirContent.directory & server.separator.file & dirContent.name) />
      <!--- Create manifest entry --->
      <cfset manifest[dirContent.name] = lcase(hash(fileContent, "SHA-1")) />
    </cfloop>
    <cfset fileWrite(variables.dir & server.separator.file & "manifest.json", serializeJSON(manifest), "utf-8") />

    <!--- Create signature --->
    <cfset passUtils.createSignature(variables.dir, arguments.keyStoreFilePath, arguments.keyStorePassword) />

    <!--- Create pass file --->
    <cfzip action="zip" file="E:\test45.pkpass" source="#variables.dir#">
  </cffunction>
</cfcomponent>