<cffunction name="passAddLocation" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="longitude" type="string" required="true" />
  <cfargument name="latitude" type="string" required="true" />
  <cfargument name="altitude" type="string" required="false" />
  <cfargument name="relevantText" type="string" required="false" />

  <!--- Add location --->
  <cfset arguments.pass.addLocation(argumentCollection=arguments) />
</cffunction>
