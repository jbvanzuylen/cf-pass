<cffunction name="passSetTypeIdentifier" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="typeIdentifier" type="string" required="true" />

  <!--- Set type identifier --->
  <cfset arguments.pass.setTypeIdentifier(arguments.typeIdentifier) />
</cffunction>
