<cffunction name="passSetVoided" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="voided" type="boolean" required="true" />

  <!--- Set voided flag --->
  <cfset arguments.pass.setVoided(arguments.voided) />
</cffunction>
