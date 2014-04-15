library(Hmisc);
aa<-'Ile';
aas<-toupper(aa);
setwd('/home/stage/karenb/Documents/Verslag/');
source('getLongName.R');

dataset<-c("urdb1","isUnique30","no");
datasetlist<-list("urdb1"="_urdb1","isUnique30"="_isUnique30","no"="");
datasetlist2<-list("urdb1"='<A target="_blank" href="Ordinary_residues.html" >Ordinary residues</A>, ',"isUnique30"='<A target="_blank" href="Unique_chains.html" >Unique chains</A>, ',"no"="");
datasetlist3<-list("urdb1"="urdb1","isUnique30"="Sel30","no"="");
valuelist<-list("urdb1"="1.0-","isUnique30"="true-","no"="");
chis<-c("chi1","chi2");
chislist<-list("chi1"="1","chi2"="2");
scales<-c("variable","fixed");
scaleslist<-list("variable"="","fixed"="_yscaled");
text1<-readLines("text14.txt");
text2<-readLines("text2.txt");
text3<-readLines("text3.txt");
lijn3<-"</div>";
lijn4<-"</body></html>";

setwd(getLongName(aas));

for (dat in dataset) {
	for (chi in chis) {
		lijn0<-paste("<h1>Mean &chi;",chislist[chi]," of ",getLongName(aas)," per refinement software per deposition year</h1>",sep="");
		for (section in 1:9) {
			text8<-paste("<p>",getSectionRange(section,chislist[[chi]]),"Blue: &alpha;-helix, Red: &beta;-strand, Green: loop</p>")
			lijn2<-paste("<h1>Mean &chi;",chislist[chi]," of ",getLongName(aas)," per resolution per secondary structure</h1>\n<p>",getSectionRange(section,chislist[chi]),"</p>",sep="");
			for (scale in scales) {
				name<-paste("R_",aa,"_DateRefprog",datasetlist[dat],"_s",section,"_",chi,"_",scale,"Y.html",sep="");
				lijn1<-paste("<h2>Dataset: ",datasetlist2[dat],"&chi;",chislist[[chi]],", section = ",section,", resolution = <1.8 &Aring;,2.5 &Aring;>, ",scale," y-scale</h2>",sep="");
				text<-c(text1,lijn0,lijn1,text8,text2,makeImg(aas,section,chislist[[chi]],datasetlist3[dat],scaleslist[scale],"CNS"),text3,makeImg(aas,section,chislist[chi],datasetlist3[dat],scaleslist[scale],"PHENIX"),lijn3,lijn3,text2,makeImg(aas,section,chislist[chi],datasetlist3[dat],scaleslist[scale],"PROLSQ"),text3,makeImg(aas,section,chislist[chi],datasetlist3[dat],scaleslist[scale],"REFMAC"),lijn3,lijn3,text2,makeImg(aas,section,chislist[chi],datasetlist3[dat],scaleslist[scale],"SHELXL"),text3,makeImg(aas,section,chislist[chi],datasetlist3[dat],scaleslist[scale],"TNT"),lijn3,lijn3,text2,makeImg(aas,section,chislist[chi],datasetlist3[dat],scaleslist[scale],"X_PLOR"),lijn3,lijn3,lijn4);
				setwd(paste('/home/stage/karenb/Documents/Verslag/',getLongName(aas),sep=""));
				writeLines(text, con = name, sep = "\n", useBytes = FALSE)
			}
		}
	}
}

makeImg<-function(aas,Q,chi,dat,scale,refprog) {
setwd(paste("/home/stage/karenb/Documents/Verslag/",getLongName(aas),"/Figures/",aas,"/R/DateRefprog"));
fileName<-paste("Year_",dat,'Quadrant_',Q,"_",refprog,"_chi",chi,scale,'_50.png',sep="");
if (length(list.files(pattern=fileName))==0) {
string<-paste('<img border=0 hspace=2 src="Figures/NoData.png" alt="Mean values of &chi;',chi,' per resolution for ',getLongName(aas),' in section ',Q,'."  height="400px" width="400px" align="texttop">',sep="");
} else {
string<-paste('<img border=0 hspace=2 src="Figures/',aas,'/R/DateRefprog/Year_',dat,'Quadrant_',Q,"_",refprog,"_chi",chi,scale,'_50.png " alt="Mean values of &chi;',chi,' per deposition year for ',getLongName(aas),' refined by ',refprog,'."  height="400px" width="400px" align="texttop">',sep="");
}
return(string);
}

getSectionRange<-function(section,chi) {
	switch(paste(section,"",sep=""),
	"1"="Section 1: &chi;1 = <0,120>, &chi;2 = <240,360><br>",
	"2"="Section 2: &chi;1 = <120,240>, &chi;2 = <240,360><br>",
	"3"="Section 3: &chi;1 = <240,360>, &chi;2 = <240,360><br>",
	"4"="Section 4: &chi;1 = <0,120>, &chi;2 = <120,240><br>",
	"5"="Section 5: &chi;1 = <120,240>, &chi;2 = <120,240><br>",
	"6"="Section 6: &chi;1 = <240,360>, &chi;2 = <120,240><br>",
	"7"="Section 7: &chi;1 = <0,120>, &chi;2 = <0,120><br>",
	"8"="Section 8: &chi;1 = <120,240>, &chi;2 = <0,120><br>",
	"9"="Section 9: &chi;1 = <240,360>, &chi;2 = <0,120><br>",
	"g+"=paste("g+: &chi;",chi," = <0,120><br>",sep=""),
	"t"=paste("g+: &chi;",chi," = <120,240><br>",sep=""),
	"g-"=paste("g+: &chi;",chi," = <240,360><br>",sep="")
	)
}


