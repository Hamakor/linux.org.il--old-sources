// Load a special CSS for Internet Explorer, to conpensate for parts of CSS 2
// which it doesn't implement.
// We do this through JS rather than through server-side scripting,
// in order to serve the same page to all clients (for sake of mirroring).

if (navigator.appName == "Microsoft Internet Explorer")
{
	var ver = navigator.appVersion.match(/MSIE (\d+)\.(\d+)/);
	if (ver != null)
	{
		var major = ver[1];
		var minor = ver[2];
		if ((major == 5) || (major == 6 && minor == 0))
		{
			document.writeln('<link rel="stylesheet" href="/layout_style_ie">');
		}
	}
}
