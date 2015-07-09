#
# Making the VNC applet.
#

CP = cp
JC = /usr/java/jdk1.7.0_45/bin/javac
#JCFLAGS = -target 1.7
#JCFLAGS = -target 1.5 -Xlint:none
SOURCES = $(shell find src -type f -name \*.java)
JAR = /usr/java/jdk1.7.0_45/bin/jar
ARCHIVE = VncViewer.jar
MANIFEST = MANIFEST.MF
PAGES = index.vnc
INSTALL_DIR = /usr/local/vnc/classes


all: build jar sign

build:
	$(JC) $(JCFLAGS) $(SOURCES)

jar:
	pwd
	#classes=$(shell cd src; find . -type f -name \*.class)
	#echo ${classes};
	cd src/; \
	$(JAR) cfm ../$(ARCHIVE) ../$(MANIFEST) $(shell cd src; find . -type f -name \*.class)

perm:
	jar ufm $(ARCHIVE) ./src/com/tightvnc/vncviewer/MANIFEST.MF

sign: 
	jarsigner -storepass "1q2w3e" -keystore .keystore $(ARCHIVE) "Terrasoft"

install: $(CLASSES) $(ARCHIVE)
	$(CP) $(CLASSES) $(ARCHIVE) $(PAGES) $(INSTALL_DIR)

export:: $(CLASSES) $(ARCHIVE) $(PAGES)
	@$(ExportJavaClasses)

clean::
	$(RM) *.class *.jar
