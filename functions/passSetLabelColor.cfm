<cffunction name="passSetLabelColor" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="labelColor" type="string" required="true" />

  <!--- Set label color --->
  <cfset arguments.pass.setLabelColor(arguments.labelColor) />
</cffunction>
