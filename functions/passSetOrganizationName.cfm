<cffunction name="passSetOrganizationName" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="organizationName" type="string" required="true" />

  <!--- Set organization name --->
  <cfset arguments.pass.setOrganizationName(arguments.organizationName) />
</cffunction>
