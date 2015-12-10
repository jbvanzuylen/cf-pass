<cfcomponent displayname="Pass" output="false">
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

    <!--- Set team identifier --->
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

    <!--- Set organization name --->
    <cfset variables.pass["organizationName"] = arguments.organizationName />
  </cffunction>

  <!---
    Set the background color for this pass

    @param backgroundColor the background color to be set
  --->
  <cffunction name="setBackgroundColor" access="public" returntype="void" output="false">
    <cfargument name="backgroundColor" type="string" required="true" />

    <!--- Set background color --->
    <cfset setColor("backgroundColor", arguments.backgroundColor) />
  </cffunction>

  <!---
    Set the foreground color for this pass

    @param foregroundColor the foreground color to be set
  --->
  <cffunction name="setForegroundColor" access="public" returntype="void" output="false">
    <cfargument name="foregroundColor" type="string" required="true" />

    <!--- Set foreground color --->
    <cfset setColor("foregroundColor", arguments.foregroundColor) />
  </cffunction>

  <!---
    Set the label color for this pass

    @param labelColor the label color to be set
  --->
  <cffunction name="setLabelColor" access="public" returntype="void" output="false">
    <cfargument name="labelColor" type="string" required="true" />

    <!--- Set label color --->
    <cfset setColor("labelColor", arguments.labelColor) />
  </cffunction>

  <!---
    Sets a color for this pass
  --->
  <cffunction name="setColor" access="private" returntype="void" output="false">
    <cfargument name="class" type="string" required="true" />
    <cfargument name="color" type="string" required="true" />

    <!--- Defined local variables --->
    <cfset var rd = 0 />
    <cfset var gr = 0 />
    <cfset var bl = 0 />

    <!--- Defined local variables --->
    <cfif (len(arguments.color) eq 4) AND (left(arguments.color, 1) eq "##")>
      <!--- Convert from HEX to RGB --->
      <cfset rd = inputBaseN(mid(arguments.color, 2, 1) & mid(arguments.color, 2, 1), 16) />
      <cfset gr = inputBaseN(mid(arguments.color, 3, 1) & mid(arguments.color, 3, 1), 16) />
      <cfset bl = inputBaseN(mid(arguments.color, 4, 1) & mid(arguments.color, 4, 1), 16) />
      <!--- Set color --->
      <cfset variables.pass[arguments.class] = "rgb(#rd#, #gr#, #bl#)" />
    <cfelseif (len(arguments.color) eq 7) AND (left(arguments.color, 1) eq "##")>
      <!--- Convert from HEX to RGB --->
      <cfset rd = inputBaseN(mid(arguments.color, 2, 2), 16) />
      <cfset gr = inputBaseN(mid(arguments.color, 4, 2), 16) />
      <cfset bl = inputBaseN(mid(arguments.color, 6, 2), 16) />
      <!--- Set color --->
      <cfset variables.pass[arguments.class] = "rgb(#rd#, #gr#, #bl#)" />
    <cfelseif (len(arguments.color) gt 4) AND (left(arguments.color, 4) eq "rgb(") AND (right(arguments.color, 1) eq ")")>
      <cfset variables.pass[arguments.class] = arguments.color />
    <cfelse>
      <cfthrow type="pass.IllegalArgumentException" message="Invalid color #arguments.color#" />
    </cfif>
  </cffunction>

  <!---
    Set the icon for this pass

    @param source the source of the icon to be set
  --->
  <cffunction name="setIcon" access="public" returntype="void" output="false">
    <cfargument name="source" type="string" required="true" />

    <!--- Defined local variables --->
    <cfset var content = "" />
    <cfset var image = "" />
    <cfset var dimension = "" />
    <cfset var file = "" />

    <!--- Get the content --->
    <cfset content = getBinaryContent(arguments.source) />

    <!--- Create icon image (normal size) --->
    <cfset image = imageNew(content) />
    <cfset dimension = variables.imageDimension["icon"] />
    <cfset imageScaleToFit(image, dimension.width, dimension.height) />
    <cfset imageWrite(image, variables.dir & server.separator.file & "icon.png") />

    <!--- Create icon image (double size) --->
    <cfset image = imageNew(content) />
    <cfset dimension = variables.imageDimension["icon@2x"] />
    <cfset imageScaleToFit(image, dimension.width, dimension.height) />
    <cfset imageWrite(image, variables.dir & server.separator.file & "icon@2x.png") />
  </cffunction>

  <!---
    Sets the logo of this pass

    @param source the source of the logo to be set
  --->
  <cffunction name="setLogo" access="public" returntype="void" output="false">
    <cfargument name="source" type="string" required="true" />

    <!--- Defined local variables --->
    <cfset var content = "" />
    <cfset var image = "" />
    <cfset var dimension = "" />
    <cfset var file = "" />

    <!--- Get the content --->
    <cfset content = getBinaryContent(arguments.source) />

    <!--- Create logo image (normal size) --->
    <cfset image = imageNew(content) />
    <cfset dimension = variables.imageDimension["logo"] />
    <cfset imageScaleToFit(image, dimension.width, dimension.height) />
    <cfset imageWrite(image, variables.dir & server.separator.file & "logo.png") />

    <!--- Create logo image (double size) --->
    <cfset image = imageNew(content) />
    <cfset dimension = variables.imageDimension["logo@2x"] />
    <cfset imageScaleToFit(image, dimension.width, dimension.height) />
    <cfset imageWrite(image, variables.dir & server.separator.file & "logo@2x.png") />
  </cffunction>

  <!---
    Retrieves the binary content of the specified source

    @param source the source from which the content is to be queried

    @return the binary content of the given source
  --->
  <cffunction name="getBinaryContent" acces="private" returntype="binary" output="false">
    <cfargument name="source" type="string" required="true" />

    <!--- Defined local variables --->
    <cfset var response = "" />

    <!--- Get the source --->
    <cfif isValid("URL", arguments.source)>
      <!--- Download content --->
      <cfhttp url="#arguments.source#" getasbinary="yes" throwonerror="true" result="response" />
      <cfreturn response.filecontent />
    <cfelseif fileExists(arguments.source)>
      <!--- Read content --->
      <cfreturn fileReadBinary(arguments.source) />
    <cfelse>
      <cfthrow type="pass.IllegalArgumentException" message="Invalid source #arguments.source#" />
    </cfif>
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

    <!--- Build field structure --->
    <cfset field["key"] = arguments.key />
    <cfset field["label"] = arguments.label />
    <cfset field["value"] = arguments.value />

    <!--- Add field to list --->
    <cfset arrayAppend(passFields[arguments.category], field) />
  </cffunction>

  <!---
    Adds a new barcode to this pass

    @param format the format of the barcode to be added
    @param message the message or the payload to be displayed as a barcode
    @param messageEncoding the text encoding that is used to render the barcode
                           (optional, default value is "ISO-8859-1")
    @param altText the text displayed near the barcode
                   (optional)
  --->
  <cffunction name="addBarcode" access="public" returntype="void" output="false">
    <cfargument name="format" type="string" required="true" />
    <cfargument name="message" type="string" required="true" />
    <cfargument name="messageEncoding" type="string" required="false" default="iso-8859-1" />
    <cfargument name="altText" type="string" required="false" />

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

    <!--- Build barcode structure --->
    <cfset barcode["format"] = arguments.format />
    <cfset barcode["message"] = arguments.message />
    <cfset barcode["messageEncoding"] = arguments.messageEncoding />
    <cfif structKeyExists(arguments, "altText") AND (NOT isNull(arguments.altText))>
      <cfset barcode["altText"] = arguments.altText />
    </cfif>

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

    <!--- Build location structure --->
    <cfset location["longitude"] = arguments.longitude />
    <cfset location["latitude"] = arguments.latitude />
    <cfif structKeyExists(arguments, "altitude") AND (NOT isNull(arguments.altitude))>
      <cfset location["altitude"] = arguments.altitude />
    </cfif>
    <cfif structKeyExists(arguments, "relevantText") AND (NOT isNull(arguments.relevantText))>
      <cfset location["relevantText"] = arguments.relevantText />
    </cfif>

    <!--- Add primary field to list --->
    <cfset arrayAppend(variables.pass["locations"], location) />
  </cffunction>

  <!---
    Set the maximum distance in meters from a relevant location that the pass is relevant

    @param maxDistance the maximum distance to be set
  --->
  <cffunction name="setMaxDistance" access="public" returntype="void" output="false">
    <cfargument name="maxDistance" type="numeric" required="true" />

    <!--- Set maximum distance --->
    <cfset variables.pass["maxDistance"] = arguments.maxDistance />
  </cffunction>

  <!---
    Build this pass

    @param keyStoreFilePath the path to the keystore file
    @param keyStorePassword the password to access the keystore

    @return the path to the file containing the pass
  --->
  <cffunction name="build" access="public" returntype="string" output="false">
    <cfargument name="keyStoreFilePath" type="string" required="true" />
    <cfargument name="keyStorePassword" type="string" required="true" />

    <!--- Defined local variables --->
    <cfset var pass = "" />
    <cfset var manifest = structNew() />
    <cfset var passUtils = createObject("java", "org.primeoservices.cfpass.PassUtils") />
    <cfset var dirContent = "" />
    <cfset var fileContent = "" />
    <cfset var filePath = getTempDirectory() & server.separator.file & variables.id & ".pkpass" />

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
    <cfzip action="zip" file="#filePath#" source="#variables.dir#">

    <cfreturn filePath />
  </cffunction>
</cfcomponent>