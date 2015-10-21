<cffunction name="passBuild" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="keyStoreFilePath" type="string" required="true" />
  <cfargument name="keyStorePassword" type="string" required="true" />

  <!--- Build pass --->
  <cfset arguments.pass.build(argumentCollection=arguments) />
</cffunction>
