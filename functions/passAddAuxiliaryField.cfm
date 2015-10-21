<cffunction name="passAddAuxiliaryField" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="key" type="string" required="true" />
  <cfargument name="label" type="string" required="true" />
  <cfargument name="value" type="string" required="true" />

  <!--- Add auxiliary field --->
  <cfset arguments.pass.addAuxiliaryField(argumentCollection=arguments) />
</cffunction>
