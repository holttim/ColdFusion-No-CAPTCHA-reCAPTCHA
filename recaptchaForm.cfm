<html>
	<body>
		<!--- Processing code after form submission --->
		<cfif structKeyExists(form,"submit")>
			<cf_recaptcha action="process">
			<cfif form.captcha>
				success!!!
			<cfelse>
				failure!!!
			</cfif>
		</cfif>

		<!--- Form to display --->
		<form method="post">
			<cf_recaptcha>
			<input type="submit" name="submit" value="submit">
		</form>
	</body>
</html>
