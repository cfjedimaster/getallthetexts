component {

	public function init() {
		variables.javaloader = new javaloader.JavaLoader().init([getDirectoryFromPath(getCurrentTemplatePath()) & 'tika-app-1.2.jar'],true);
		return this;
	}	

	public function read(required string filename) {
		var result = {};
		//todo: validate it exists
		var f = createObject("java", "java.io.File").init(filename);
		var fis = createObject("java","java.io.FileInputStream").init(f);
		var parser = variables.javaloader.create("org.apache.tika.parser.AutoDetectParser");

		var ch = createObject("java","org.apache.tika.sax.BodyContentHandler").init();
		var md = variables.javaloader.create("org.apache.tika.metadata.Metadata").init();

		try {
			parser.parse(fis, ch, md);

			var keys = md.names();
			result.metadata = {};
			for(var i=1; i<arrayLen(keys); i++) {
				result.metadata[keys[i]] = md.get(keys[i]);
			}

			result.text = ch.toString();
		} catch(any e) {
			result.error = e;
		}
		fis.close();
		return result;
	}

}