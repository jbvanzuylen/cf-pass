<cffunction name="passSetExpirationDate" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="expirationDate" type="date" required="true" />

  <!--- Set expiration date --->
  <cfset arguments.pass.setExpirationDate(arguments.expirationDate) />
</cffunction>
