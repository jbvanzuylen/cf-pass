<cffunction name="passSetLogoText" access="public" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="text" type="string" required="true" />

  <!--- Set logo text --->
  <cfset arguments.pass.setLogoText(arguments.text) />
</cffunction>
