# ColdFusion-No-CAPTCHA-reCAPTCHA
ColdFusion CFML No CAPTCHA reCAPTCHA Custom Tag without using cfscript

Custom Tag for Google's No CAPTCHA reCAPTCHA 

This is a basic and to the point ColdFusion Custom Tag that does not use cfscript.
The purpose of this is to show the ease of integrating Google's No CAPTCHA reCAPTCHA
into your application using ColdFusion. There is a lot more you can do with the
Custom Tag and form page to enhance the features.

::::IMPORTANT:::: 
You will need to get a secretKey and Site Key from Google located here: 
https://www.google.com/recaptcha/admin

You will then need to update the default values for the secretKey and siteKey
parameters or pass them in as attributes of the Custom Tag call.

If you will be using the Custom Tag in a single Custom Tag directory where the
tag will be used by multiple sites, you will most likely want to specify the
keys as attributes of the tag when making the call from the form, rather than
setting the default values in the actual tag below. Furthermore, if each site
has its' own application file, you can set application variables for each key
and use those as the default values.
::::IMPORTANT:::: 


 - Page example using the Custom Tag -

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
