<cffunction name="passSetBackgroundColor" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="backgroundColor" type="string" required="true" />

  <!--- Set background color --->
  <cfset arguments.pass.setBackgroundColor(arguments.backgroundColor) />
</cffunction>
