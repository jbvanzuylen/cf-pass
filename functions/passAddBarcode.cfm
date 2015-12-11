<cffunction name="passAddBarcode" access="public" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="format" type="string" required="true" />
  <cfargument name="message" type="string" required="true" />
  <cfargument name="messageEncoding" type="string" required="false" />
  <cfargument name="altText" type="string" required="false" />

  <!--- Add barcode --->
  <cfset arguments.pass.addBarcode(argumentCollection=arguments) />
</cffunction>
