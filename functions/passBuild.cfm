<cffunction name="passBuild" returntype="string" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="keyStoreFilePath" type="string" required="true" />
  <cfargument name="keyStorePassword" type="string" required="true" />

  <!--- Build pass --->
  <cfreturn arguments.pass.build(argumentCollection=arguments) />
</cffunction>
