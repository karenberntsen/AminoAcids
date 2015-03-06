library(Hmisc);
aa<-'Ile';
aas<-toupper(aa);
setwd('/home/stage/karenb/Documents/Verslag/AminoAcids/');
source('getLongName.R');

dataset<-c("urdb1","isUnique30","no");
datasetlist<-list("urdb1"="_urdb1","isUnique30"="_isUnique30","no"="");
datasetlist2<-list("urdb1"='<A target="_blank" href="Ordinary_residues.html" >Ordinary residues</A>, ',"isUnique30"='<A target="_blank" href="Unique_chains.html" >Unique chains</A>, ',"no"="");
datasetlist3<-list("urdb1"="urdb1","isUnique30"="sel","no"="");
valuelist<-list("urdb1"="1.0-","isUnique30"="true-","no"="");
chis<-c("chi1","chi2");
chislist<-list("chi1"="1","chi2"="2");
binsizes<-c("0.1","0.2");
binsizelist<-list("0.1"="01","0.2"="02");
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
		lijn0<-paste("<h1>Mean &chi;",chislist[chi]," of ",getLongName(aas)," per resolution per refinement software</h1>",sep="");
		for (section in c(1:9,"g+","t","g-")) {
			text8<-paste("<p>",getSectionRange(section,chislist[chi]),"Blue: &alpha;-helix, Red: &beta;-strand, Green: loop</p>")
			lijn2<-paste("<h1>Mean &chi;",chislist[chi]," of ",getLongName(aas)," per resolution per secondary structure</h1>\n<p>",getSectionRange(section,chislist[chi]),"Light green: CNS, Red: REFMAC, Blue: X-PLOR, Purple: PHENIX, Cyan: SHELXL, Dark green: TNT, Yellow: PROLSQ<p>",sep="");
			for (bs in binsizes) {
				for (scale in scales) {
					lijn1<-paste("<h2>Dataset: ",datasetlist2[dat],"&chi;",chislist[chi],", section = ",section,", binsize = ",bs," &Aring;, ",scale," y-scale</h2>",sep="");
					if (section=="g+" | section=="t" | section=="g-") {
						name<-paste("R_",aa,"_Refprog",datasetlist[dat],"_",section,"_",binsizelist[bs],"_",chi,"_",scale,"Y.html",sep="");
						text<-c(text1,lijn1,text8,text2,makeImg2(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"CNS"),text3,makeImg2(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"PHENIX"),lijn3,lijn3,text2,makeImg2(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"PROLSQ"),text3,makeImg2(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"REFMAC"),lijn3,lijn3,text2,makeImg2(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"SHELXL"),text3,makeImg2(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"TNT"),lijn3,lijn3,text2,makeImg2(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"X_PLOR"),lijn3,lijn3,'<p style="clear: both"><br></p>',lijn2,text2,makeImg2(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"H"),text3,makeImg2(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"S"),text3,makeImg2(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"C"),lijn3,lijn3,lijn4);
					} else {
						name<-paste("R_",aa,"_Refprog",datasetlist[dat],"_s",section,"_",binsizelist[bs],"_",chi,"_",scale,"Y.html",sep="");
						text<-c(text1,lijn0,lijn1,text8,text2,makeImg(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"CNS"),text3,makeImg(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"PHENIX"),lijn3,lijn3,text2,makeImg(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"PROLSQ"),text3,makeImg(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"REFMAC"),lijn3,lijn3,text2,makeImg(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"SHELXL"),text3,makeImg(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"TNT"),lijn3,lijn3,text2,makeImg(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"X_PLOR"),lijn3,lijn3,'<p style="clear: both"><br></p>',lijn2,text2,makeImg(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"H"),text3,makeImg(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"S"),text3,makeImg(aas,section,chislist[chi],datasetlist3[dat],bs,scaleslist[scale],"C"),lijn3,lijn3,lijn4);
					}
					setwd(paste('/home/stage/karenb/Documents/Verslag/AminoAcids/',getLongName(aas),sep=""));
					writeLines(text, con = name, sep = "\n", useBytes = FALSE)
				}
			}
		}
	}
}

makeImg<-function(aas,Q,chi,dat,bs,scale,refprog) {
binsizelist<-list("0.1"="","0.2"="bs2");
Qlist<-list("1"="1","2"="2","3"="3","4"="4","5"="5","6"="6","7"="7","8"="8","9"="9","g-"="g\\-","t"="t","g+"="g\\+");
setwd(paste("/home/stage/karenb/Documents/Verslag/AminoAcids/",getLongName(aas),"/Figures/",aas,"/R/Refprog",sep=""));
fileName<-paste(binsizelist[bs],dat,'Section_',Qlist[Q],"_chi",chi,"_",refprog,scale,'_50.png',sep="");
if (length(list.files(pattern=paste("^",fileName,sep="")))==0) {
string<-paste('<img border=0 hspace=2 src="Figures/NoData.png" alt="Mean values of &chi;',chi,' per resolution for ',getLongName(aas),' in section ',Q,'."  height="400px" width="400px" align="texttop">',sep="");
} else {
string<-paste('<img border=0 hspace=2 src="Figures/',aas,'/R/Refprog/',binsizelist[bs],dat,'Section_',Q,"_chi",chi,"_",refprog,scale,'_50.png " alt="Mean values of &chi;',chi,' per resolution for ',getLongName(aas),' refined by ',refprog,'."  height="400px" width="400px" align="texttop">',sep="");
}
return(string);
}

makeImg2<-function(aas,Q,chi,dat,bs,scale,dssp) {
dssplist<-list("H"="an &alpha;-helix","S"="a &beta;-strand","C"="a loop");
binsizelist<-list("0.1"="","0.2"="bs2_");
Qlist<-list("1"="1","2"="2","3"="3","4"="4","5"="5","6"="6","7"="7","8"="8","9"="9","g-"="g\\-","t"="t","g+"="g\\+");
setwd(paste("/home/stage/karenb/Documents/Verslag/AminoAcids/",getLongName(aas),"/Figures/",aas,"/R/Refprog",sep=""));
if (dat!="") {
	dat<-paste(dat,"_",sep="");
}
fileName<-paste(dat,binsizelist[bs],'Section_',Qlist[Q],"_chi",chi,"_",dssp,scale,'_50.png',sep="");
if (length(list.files(pattern=paste("^",fileName,sep="")))==0) {
string<-paste('<img border=0 hspace=2 src="Figures/NoData.png" alt="Mean values of &chi;',chi,' per resolution for ',getLongName(aas),' in section ',Q,'."  height="400px" width="400px" align="texttop">',sep="");
} else {
string<-paste('<img border=0 hspace=2 src="Figures/',aas,'/R/Refprog/',dat,binsizelist[bs],'Section_',Q,"_chi",chi,"_",dssp,scale,'_50.png " alt="Mean values of &chi;',chi,' per resolution for ',getLongName(aas),' in ',dssplist[dssp],'."  height="400px" width="400px" align="texttop">',sep="");
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


