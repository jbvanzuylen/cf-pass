<cffunction name="passSetTeamIdentifier" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="teamIdentifier" type="string" required="true" />

  <!--- Set team identifier --->
  <cfset arguments.pass.setTeamIdentifier(arguments.teamIdentifier) />
</cffunction>
