<cffunction name="passAddHeaderField" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="key" type="string" required="true" />
  <cfargument name="label" type="string" required="true" />
  <cfargument name="value" type="string" required="true" />

  <!--- Add header field --->
  <cfset arguments.pass.addHeaderField(argumentCollection=arguments) />
</cffunction>
