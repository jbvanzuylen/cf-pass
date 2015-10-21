<cffunction name="passSetLogo" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="path" type="string" required="true" />

  <!--- Set logo --->
  <cfreturn arguments.pass.setLogo(arguments.path) />
</cffunction>
