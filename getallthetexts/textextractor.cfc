component {

	public function init() {
		variables.javaloader = new javaloader.JavaLoader().init([getDirectoryFromPath(getCurrentTemplatePath()) & 'tika-app-1.2.jar'],true);
		return this;
	}	

	public function doParse(fis) {
		var result = {};
		var parser = create("org.apache.tika.parser.AutoDetectParser");
		//Ray, the -1 disables the limit on size. May be a bad idea.
		var ch = create("org.apache.tika.sax.BodyContentHandler").init(-1);
		var md = create("org.apache.tika.metadata.Metadata").init();

		parser.parse(fis, ch, md);

		var keys = md.names();
		result.metadata = {};
		for(var i=1; i<arrayLen(keys); i++) {
			result.metadata[keys[i]] = md.get(keys[i]);
		}

		result.text = ch.toString();

		return result;  
	}

	public function read(required string filename) {
		var result = {};

		if(!fileExists(filename)) {
			result.error = "#filename# does not exist.";
			return result;
		};

		var f = createObject("java", "java.io.File").init(filename);
		var fis = createObject("java","java.io.FileInputStream").init(f);

		try {
			result = variables.javaloader.switchThreadContextClassLoader(doParse, {fis=fis});
		} catch(any e) {
			result.error = e;
		}
		fis.close();
		return result;
	}

}