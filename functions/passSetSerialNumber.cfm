<cffunction name="passSetSerialNumber" returntype="void" output="false">
  <cfargument name="pass" type="pass.Pass" required="true" />
  <cfargument name="serialNumber" type="string" required="true" />

  <!--- Set serial number --->
  <cfreturn arguments.pass.setSerialNumber(arguments.serialNumber) />
</cffunction>
