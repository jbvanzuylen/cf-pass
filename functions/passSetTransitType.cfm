<cffunction name="passSetTransitType" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="transitType" type="string" required="true" />

  <!--- Set transit type --->
  <cfset arguments.pass.setTransitType(arguments.transitType) />
</cffunction>
