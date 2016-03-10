<cfparam name="attributes.action" default="display">

<!--- Key's provided by google  https://www.google.com/recaptcha/admin --->
<cfparam name="attributes.secretKey" default="">
<cfparam name="attributes.siteKey" default="">

<!--- This section is used to display the captcha in your form. --->
<cfif attributes.action eq "display">
	<!--- This takes care of putting the JavaScript in the head tag of the calling page. --->
	<cfhtmlhead text="<script src='https://www.google.com/recaptcha/api.js' async defer></script>">
	<!--- Div to be displayed in form. --->
	<cfoutput><div class="g-recaptcha" data-sitekey="#attributes.siteKey#"></div></cfoutput>

<!--- This section is used to process the captcha after the form has been submitted. --->
<cfelseif attributes.action eq "process">
	<cftry>
		<cfif structkeyExists(form,'g-recaptcha-response')>
			<cfhttp url="https://www.google.com/recaptcha/api/siteverify" method="get" timeout="5" throwonerror="true">
				<cfhttpparam type="formfield" name="secret" value="#attributes.secretKey#">
				<cfhttpparam type="formfield" name="remoteip" value="#cgi.REMOTE_ADDR#">
				<cfhttpparam type="formfield" name="response" value="#form['g-recaptcha-response']#">
			</cfhttp>
			<cfset result = deserializeJSON(cfhttp.filecontent) />

			<!--- You can change these variables to whatever you want them to be for your processing code. --->
			<cfif result.success eq "YES">
				<cfset form.captcha = 1 />
			<cfelse>
				<cfset form.captcha = 0 />
			</cfif>
		</cfif>
		<!--- You can use this for any other error information you want to capture. --->
		<cfcatch>
			<cfset form.captcha = 0 />
		</cfcatch>
	</cftry>
</cfif>
