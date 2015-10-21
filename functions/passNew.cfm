<cffunction name="passNew" returntype="pass.Pass" output="false">
  <cfargument name="style" type="string" required="true" />

  <!--- Create a new pass with the specified style --->
  <cfreturn createObject("component", "pass.Pass").init(argumentCollection = arguments) />
</cffunction>
