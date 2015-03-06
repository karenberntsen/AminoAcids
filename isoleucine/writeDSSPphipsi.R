library(Hmisc);
aa<-'Ile';
aas<-toupper(aa);
setwd('/home/stage/karenb/Documents/Verslag/');
source('getLongName.R');

dataset<-c("urdb1","isUnique30","no");
datasetlist<-list("urdb1"="_urdb1","isUnique30"="_isUnique30","no"="");
datasetlist2<-list("urdb1"='<A target="_blank" href="Ordinary_residues.html" >Ordinary residues</A>, ',"isUnique30"='<A target="_blank" href="Unique_chains.html" >Unique chains</A>, ',"no"="");
datasetlist3<-list("urdb1"="urdb1_","isUnique30"="sel_","no"="");
valuelist<-list("urdb1"="1.0-","isUnique30"="true-","no"="");
chis<-c("chi1","chi2");
chislist<-list("chi1"="1","chi2"="2");
binsizes<-c("0.1","0.2");
binsizelist<-list("0.1"="01","0.2"="02");
scales<-c("variable","fixed");
scaleslist<-list("variable"="","fixed"="_yscaled");
text1<-readLines("text14.txt");
text0<-paste('<h1>Mean &chi;1 and mean &chi;2 of ',getLongName(aas),' in a loop per resolution</h1>',sep="");
text8<-readLines("text13.txt");
text2<-readLines("text2.txt");
text3<-readLines("text3.txt");
lijn2<-paste("<p>",capitalize(getLongName(aas))," in a loop: light colours, ",getLongName(aas)," in a helix (blue) or strand (red): dark colours</p>",sep="");
lijn3<-"</div>";
lijn4<-"</body></html>";

setwd(getLongName(aas));

for (dat in dataset) {
	for (chi in chis) {
		for (bs in binsizes) {
			for (scale in scales) {
				name<-paste("R_",aa,"_DSSPphipsi",datasetlist[dat],"_",binsizelist[bs],"_",chi,"_",scale,"Y.html",sep="");
				lijn1<-paste("<h2>Dataset: ",datasetlist2[dat],"&chi;",chislist[chi],", binsize = ",bs," &Aring;, ",scale," y-scale</h2>",sep="");
				text<-c(text1,text0,lijn1,text8,lijn2,text2,makeImg(aas,"1",chislist[chi],datasetlist3[dat],bs,scaleslist[scale]),text3,makeImg(aas,"2",chislist[chi],datasetlist3[dat],bs,scaleslist[scale]),text3,makeImg(aas,"3",chislist[chi],datasetlist3[dat],bs,scaleslist[scale]),lijn3,lijn3,text2,makeImg(aas,"4",chislist[chi],datasetlist3[dat],bs,scaleslist[scale]),text3,makeImg(aas,"5",chislist[chi],datasetlist3[dat],bs,scaleslist[scale]),text3,makeImg(aas,"6",chislist[chi],datasetlist3[dat],bs,scaleslist[scale]),lijn3,lijn3,text2,makeImg(aas,"7",chislist[chi],datasetlist3[dat],bs,scaleslist[scale]),text3,makeImg(aas,"8",chislist[chi],datasetlist3[dat],bs,scaleslist[scale]),text3,makeImg(aas,"9",chislist[chi],datasetlist3[dat],bs,scaleslist[scale]),lijn3,lijn3,'<p style="clear: both"><br></p>',text2,makeImg(aas,"g+",chislist[chi],datasetlist3[dat],bs,scaleslist[scale]),text3,makeImg(aas,"t",chislist[chi],datasetlist3[dat],bs,scaleslist[scale]),text3,makeImg(aas,"g-",chislist[chi],datasetlist3[dat],bs,scaleslist[scale]),lijn3,lijn3,lijn4);
				setwd(paste('/home/stage/karenb/Documents/Verslag/',getLongName(aas),sep=""));
				writeLines(text, con = name, sep = "\n", useBytes = FALSE)
			}
		}
	}
}

makeImg<-function(aas,Q,chi,dat,bs,scale) {
binsizelist<-list("0.1"="","0.2"="bs2_");
Qlist<-list("1"="1","2"="2","3"="3","4"="4","5"="5","6"="6","7"="7","8"="8","9"="9","g-"="g\\-","t"="t","g+"="g\\+");
setwd(paste("/home/stage/karenb/Documents/Verslag/",getLongName(aas),"/Figures/",aas,"/R/DSSPphipsi",sep=""));
fileName<-paste(dat,binsizelist[bs],'Quadrant_',Qlist[Q],"_chi",chi,scale,'_HCHSCS_50.png',sep="");
if (length(list.files(pattern=fileName))==0) {
string<-paste('<img border=0 hspace=2 src="Figures/NoData.png" alt="Mean values of &chi;',chi,' per resolution for ',getLongName(aas),' in section ',Q,'."  height="400px" width="400px" align="texttop">',sep="");
} else {
string<-paste('<img border=0 hspace=2 src="Figures/',aas,'/R/DSSPphipsi/',dat,binsizelist[bs],'Quadrant_',Q,"_chi",chi,scale,'_HCHSCS_50.png " alt="Mean values of &chi;',chi,' per resolution for ',getLongName(aas),' in a loop in section ',Q,'."  height="400px" width="400px" align="texttop">',sep="");
}
return(string);
}
