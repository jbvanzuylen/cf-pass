<cffunction name="passSetIcon" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="path" type="string" required="true" />

  <!--- Set icon --->
  <cfreturn arguments.pass.setIcon(arguments.path) />
</cffunction>
