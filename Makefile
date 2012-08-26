all: compile run

compile:
	mxmlc -static-link-runtime-shared-libraries=true src/Main.as \
		-output=Main.swf

run:
	chromium-browser Main.swf
