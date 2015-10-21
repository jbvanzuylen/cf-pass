<cffunction name="passSetAuthenticationToken" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="authenticationToken" type="string" required="true" />

  <!--- Set authentication token --->
  <cfset arguments.pass.setAuthenticationToken(arguments.authenticationToken) />
</cffunction>
