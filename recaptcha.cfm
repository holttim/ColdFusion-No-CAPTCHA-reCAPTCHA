<!--- 
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


The MIT License (MIT)

Copyright (c) [2016] [Jeff Pratt]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

--->
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