<cffunction name="passAddBackField" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="key" type="string" required="true" />
  <cfargument name="label" type="string" required="true" />
  <cfargument name="value" type="string" required="true" />

  <!--- Add back field --->
  <cfset arguments.pass.addBackField(argumentCollection=arguments) />
</cffunction>
