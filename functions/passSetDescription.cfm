<cffunction name="passSetDescription" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="description" type="string" required="true" />

  <!--- Set description --->
  <cfset arguments.pass.setDescription(arguments.description) />
</cffunction>
