all: compile run

compile:
	mxmlc -compiler.debug=true -static-link-runtime-shared-libraries=true src/Main.as \
		-output=Main.swf

run:
	chromium-browser Main.swf
