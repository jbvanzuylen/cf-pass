<cffunction name="passSetForegroundColor" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="foregroundColor" type="string" required="true" />

  <!--- Set foreground color --->
  <cfset arguments.pass.setForegroundColor(arguments.foregroundColor) />
</cffunction>
