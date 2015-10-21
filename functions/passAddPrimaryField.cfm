<cffunction name="passAddPrimaryField" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="key" type="string" required="true" />
  <cfargument name="label" type="string" required="true" />
  <cfargument name="value" type="string" required="true" />

  <!--- Add primary field --->
  <cfset arguments.pass.addPrimaryField(argumentCollection=arguments) />
</cffunction>
