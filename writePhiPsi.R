library(Hmisc);
aa<-'Leu';
setwd('/home/stage/karenb/Documents/Verslag');
aas<-toupper(aa);
source('getLongName.R');
setwd('isoleucine');
files<-list.files(pattern="^Java_Ile_phipsi");
for (file in files) {
	setwd('/home/stage/karenb/Documents/Verslag/isoleucine');
	newlines<-c();
	lines<-readLines(file);
	for (line in lines) {
		if (grepl(getLongName('Ile'),line)) {
			line<-gsub(getLongName('Ile'),getLongName(aa),line);
		}
		if (grepl(capitalize(getLongName('Ile')),line)) {
			line<-gsub(capitalize(getLongName('Ile')),capitalize(getLongName(aa)),line);
		}
		if (grepl('Ile',line)) {
			line<-gsub('Ile',aa,line);
		}
		if (grepl('[^f]ile',line)) {
			line<-gsub('[^f]ile',tolower(aa),line);
		}
		if (grepl('ILE',line)) {
			line<-gsub('ILE',toupper(aa),line);
		}
		newlines<-c(newlines,line);
	}
	setwd('/home/stage/karenb/Documents/Verslag');
	setwd(getLongName(aas));
	writeLines(newlines,gsub('Ile',aa,file),sep = "\n", useBytes = FALSE);
}
