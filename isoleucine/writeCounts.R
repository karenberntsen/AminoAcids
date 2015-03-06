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
binsizes<-c("0.1","0.2");
binsizelist<-list("0.1"="01","0.2"="02");
scales<-c("variable","fixed","log");
scaleslist<-list("variable"="","fixed"="_yscaled","log"="_log10");
scaleslist2<-list("variable"="linear_variableY","fixed"="linear_fixedY","log"="log10_fixedY");
text1<-readLines("text14.txt");
text0<-paste('<h1>Counts of ',getLongName(aas),' per resolution</h1>',sep="");
text8<-readLines("text8.txt");
text2<-readLines("text2.txt");
text3<-readLines("text3.txt");
lijn3<-"</div>";
lijn4<-"</body></html>";

setwd(getLongName(aas));

for (dat in dataset) {
	for (bs in binsizes) {
		for (scale in scales) {
			name<-paste("R_",aa,"_Counts",datasetlist[dat],"_",binsizelist[bs],"_",scaleslist2[scale],".html",sep="");
			lijn1<-paste("<h2>Dataset: ",datasetlist2[dat],"binsize = ",bs," &Aring;, ",scale," y-scale</h2>",sep="");
			text<-c(text1,text0,lijn1,text8,text2,makeImg(aas,"1",datasetlist3[dat],bs,scaleslist[scale]),text3,makeImg(aas,"2",datasetlist3[dat],bs,scaleslist[scale]),text3,makeImg(aas,"3",datasetlist3[dat],bs,scaleslist[scale]),lijn3,lijn3,text2,makeImg(aas,"4",datasetlist3[dat],bs,scaleslist[scale]),text3,makeImg(aas,"5",datasetlist3[dat],bs,scaleslist[scale]),text3,makeImg(aas,"6",datasetlist3[dat],bs,scaleslist[scale]),lijn3,lijn3,text2,makeImg(aas,"7",datasetlist3[dat],bs,scaleslist[scale]),text3,makeImg(aas,"8",datasetlist3[dat],bs,scaleslist[scale]),text3,makeImg(aas,"9",datasetlist3[dat],bs,scaleslist[scale]),lijn3,lijn3,'<p style="clear: both"><br></p>',text2,makeImg2(aas,"g+",datasetlist3[dat],bs,scaleslist[scale],"1"),text3,makeImg2(aas,"t",datasetlist3[dat],bs,scaleslist[scale],"1"),text3,makeImg2(aas,"g-",datasetlist3[dat],bs,scaleslist[scale],"1"),lijn3,lijn3,'<p style="clear: both"><br></p>',text2,makeImg2(aas,"g+",datasetlist3[dat],bs,scaleslist[scale],"2"),text3,makeImg2(aas,"t",datasetlist3[dat],bs,scaleslist[scale],"2"),text3,makeImg2(aas,"g-",datasetlist3[dat],bs,scaleslist[scale],"2"),lijn3,lijn3,lijn4);
			setwd(paste('/home/stage/karenb/Documents/Verslag/AminoAcids',getLongName(aas),sep=""));
			writeLines(text, con = name, sep = "\n", useBytes = FALSE);
		}
	}
}


makeImg<-function(aas,Q,dat,bs,scale) {
binsizelist<-list("0.1"="","0.2"="bs2");
setwd(paste("/home/stage/karenb/Documents/Verslag/AminoAcids",getLongName(aas),"/Figures/",aas,"/R/Counts",sep=""));
fileName<-paste('Counts_',binsizelist[bs],dat,aas,'_Quadrant_',Q,'_counts',scale,'.png',sep="");
if (length(list.files(pattern=fileName))==0) {
string<-paste('<img border=0 hspace=2 src="Figures/NoData.png" alt="Percentage counts per resolution for ',getLongName(aas),' in section ',Q,'." height="400px" width="400px" align="texttop">',sep="");
} else {
string<-paste('<img border=0 hspace=2 src="Figures/',aas,'/R/Counts/Counts_',binsizelist[bs],dat,aas,'_Quadrant_',Q,'_counts',scale,'.png" alt="Percentage counts per resolution for ',getLongName(aas),' in section ',Q,'."  height="400px" width="400px" align="texttop">',sep="");
}
return(string);
}

makeImg2<-function(aas,Q,dat,bs,scale,chi) {
binsizelist<-list("0.1"="","0.2"="bs2");
setwd(paste("/home/stage/karenb/Documents/Verslag/AminoAcids",getLongName(aas),"/Figures/",aas,"/R/Counts",sep=""));
fileName<-paste('Counts_chi',chi,"_",binsizelist[bs],dat,aas,'_Quadrant_',Q,'_chi',chi,'_counts',scale,'.png',sep="");
#code in blue does not work for this category of files
#if (length(list.files(pattern=fileName))==0) {
#string<-paste('<img border=0 hspace=2 src="Figures/NoData.png" alt="Percentage counts per resolution for ',getLongName(aas),' in section ',Q,'." height="400px" width="400px" align="texttop">',sep="");
#} else {
string<-paste('<img border=0 hspace=2 src="Figures/',aas,'/R/Counts/Counts_chi',chi,"_",binsizelist[bs],dat,aas,'_Quadrant_',Q,'_chi',chi,'_counts',scale,'.png" alt="Percentage counts per resolution for ',getLongName(aas),' in section ',Q,'."  height="400px" width="400px" align="texttop">',sep="");
#}
return(string);
}

