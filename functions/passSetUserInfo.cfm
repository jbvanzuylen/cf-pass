<cffunction name="passSetUserInfo" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="userInfo" type="string" required="true" />

  <!--- Set user info --->
  <cfset arguments.pass.setUserInfo(arguments.userInfo) />
</cffunction>
