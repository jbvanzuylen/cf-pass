<cffunction name="passSetMaxDistance" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="maxDistance" type="numeric" required="true" />

  <!--- Set maximum distance --->
  <cfset arguments.pass.setMaxDistance(arguments.maxDistance) />
</cffunction>
