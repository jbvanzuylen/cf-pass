<cffunction name="passSetRelevantDate" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="relevantDate" type="date" required="true" />
  <cfargument name="offset" type="numeric" required="true" />

  <!--- Set relevant date --->
  <cfset arguments.pass.setRelevantDate(argumentCollection=arguments) />
</cffunction>
