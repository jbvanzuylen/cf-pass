<cffunction name="passSetExpirationDate" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="expirationDate" type="date" required="true" />
  <cfargument name="offset" type="numeric" required="true" />

  <!--- Set expiration date --->
  <cfset arguments.pass.setExpirationDate(argumentCollection=arguments) />
</cffunction>
