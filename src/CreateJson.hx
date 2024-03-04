package;

import haxe.Json;
import haxe.io.Path;
import sys.FileSystem;

// python -c 'import os, json; print json.dumps(os.listdir("."))'
class CreateJson {
	var json = {};
	var arr = [];

	var ROOT:String; // current ROOT (neko, node.js, c++, c#, python, java)
	var BUILD:String; // root folder of the website
	var EXPORT:String; // folder to generate files in (in this case `docs` folder from github )

	public function new() {
		// trace('CreateJson');

		// ROOT = Sys.getCwd().split('bin/')[1].split('/')[0];
		ROOT = Sys.getCwd(); // /Users/matthijs/Documents/workingdir/gen25/rawworks-widget/_haxe/bin
		BUILD = Path.normalize(Sys.getCwd().split('_haxe/')[0] + '/build/'); // /Users/matthijs/Documents/workingdir/gen25/rawworks-widget/build

		// trace(ROOT);

		if (FileSystem.exists(BUILD)) {
			// trace(BUILD);
			recursiveLoop(Path.normalize(BUILD + '/static/js/'));
			recursiveLoop(Path.normalize(BUILD + '/static/css/'));
			createJson();
		}
	}

	function recursiveLoop(directory:String = "path/to/") {
		if (sys.FileSystem.exists(directory)) {
			// trace("directory found: " + directory);
			for (file in sys.FileSystem.readDirectory(directory)) {
				var path = haxe.io.Path.join([directory, file]);
				if (!sys.FileSystem.isDirectory(path)) {
					// trace("file found: " + path);
					// do something with file
					arr.push(path);
				} else {
					var directory = haxe.io.Path.addTrailingSlash(path);
					// trace("directory found: " + directory);
					recursiveLoop(directory);
				}
			}
		} else {
			trace('"$directory" does not exists');
		}
	}

	function createJson() {
		writeFile(BUILD, 'path.json', Json.stringify(arr));
	}

	/**
	 * simply write the files
	 * @param path 		folder to write the files (current assumption is `EXPORT`)
	 * @param filename	(with extension) the file name
	 * @param content	what to write to the file (in our case markdown)
	 */
	function writeFile(path:String, filename:String, content:String) {
		if (!sys.FileSystem.exists(path)) {
			sys.FileSystem.createDirectory(path);
		}
		// write the file
		sys.io.File.saveContent(path + '/${filename}', content);
		trace('written file: ${path}/${filename}');
	}

	static public function main() {
		var app = new CreateJson();
	}
}
