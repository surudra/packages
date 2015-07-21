%invoke wm.deployer.gui.UIBundle:getBundleISFiles%
	var fileNamePattern = "%value fileNamePattern%";

	%switch filter%
	%case 'include'%
		if (fileNamePattern.length == 0) {
			var p = new WebFXTreeItem("Selected Files");
			pkgTree.add(p);
			%loop files% 
				var f = new WebFXTreeItem("%value fullName%", null, null, 
					getNSIcon("PackageFile"), getNSIcon("PackageFile"));
				p.add(f);
			%endloop files%
		}
		else {
			var p = new WebFXTreeItem("Files Specified by Filter");
			pkgTree.add(p);
			var f = new WebFXTreeItem("%value fileNamePattern%", null, null, 
				getNSIcon("PackageFiles"), getNSIcon("PackageFiles"));
			p.add(f);
		}
	%case 'includeall'%
		var f = new WebFXTreeItem("All Files", null, null, 
			getNSIcon("PackageFiles"), getNSIcon("PackageFiles"));
		pkgTree.add(f);

	%case 'exclude'%
		if (fileNamePattern.length == 0) {
			var p = new WebFXTreeItem("Except Selected Files");
			pkgTree.add(p);
			%loop files% 
				var f = new WebFXTreeItem("%value fullName%", null, null, 
					getNSIcon("PackageFile"), getNSIcon("PackageFile"));
				p.add(f);
			%endloop files%
		}
		else {
			var p = new WebFXTreeItem("Except Files Specified by Filter");
			pkgTree.add(p);
			var f = new WebFXTreeItem("%value fileNamePattern%", null, null, 
				getNSIcon("PackageFiles"), getNSIcon("PackageFiles"));
			p.add(f);
		}
	%end case%

	var deleteCnt = 0;
	%loop deleteFiles% 
		deleteCnt++;
	%endloop%

	if (deleteCnt > 0) {
		var p = new WebFXTreeItem("Files to Delete from Target Package");
		pkgTree.add(p);
		%loop deleteFiles% 
			var f = new WebFXTreeItem("%value fullName%", null, null, 
				getNSIcon("PackageDeleteFile"), getNSIcon("PackageDeleteFile"));
			p.add(f);
		%endloop files%
	}
%endinvoke getBundleISFiles%
