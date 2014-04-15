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
resolution<-c("<2.0","2.0-3.0",">3.0","no");
resolutionlist<-list("<2.0"="_0.0-2.0","2.0-3.0"="_2.0-3.0",">3.0"="_3.0-16.0","no"="");
resolutionlist2<-list("<2.0"="resolution=[0.0 &Aring;,2.0 &Aring;>, ","2.0-3.0"="resolution=<2.0 &Aring;,3.0 &Aring;>, ",">3.0"="resolution=<3.0 &Aring;,16.0 &Aring;>, ","no"="");
resolutionlist3<-list("<2.0"="_reslt20","2.0-3.0"="_resbet2030",">3.0"="_resgt30","no"="");
chis<-c("chi1","chi2");
chislist<-list("chi1"="1","chi2"="2");
scales<-c("variable","fixed");
scaleslist<-list("variable"="","fixed"="_yscaled");
text1<-readLines("text14.txt");
text0<-paste('<h1>Mean &chi;1 and mean &chi;2 of ',getLongName(aas),' per deposition year</h1>',sep="");
text8<-readLines("text8.txt");
text2<-readLines("text2.txt");
text3<-readLines("text3.txt");
lijn3<-"</div>";
lijn4<-"</body></html>";

setwd(getLongName(aas));

for (dat in dataset) {
	for (res in resolution) {
		for (chi in chis) {
			for (scale in scales) {
				name<-paste("R_",aa,"_Date",datasetlist[dat],resolutionlist[res],"_",chi,"_",scale,"Y.html",sep="");
				lijn1<-paste("<h2>Dataset: ",datasetlist2[dat],resolutionlist2[res],"&chi;",chislist[chi],", ",scale," y-scale</h2>",sep="");
				text<-c(text1,text0,lijn1,text8,text2,makeImg(aas,"1",chislist[chi],datasetlist3[dat],resolutionlist3[res],scaleslist[scale]),text3,makeImg(aas,"2",chislist[chi],datasetlist3[dat],resolutionlist3[res],scaleslist[scale]),text3,makeImg(aas,"3",chislist[chi],datasetlist3[dat],resolutionlist3[res],scaleslist[scale]),lijn3,lijn3,text2,makeImg(aas,"4",chislist[chi],datasetlist3[dat],resolutionlist3[res],scaleslist[scale]),text3,makeImg(aas,"5",chislist[chi],datasetlist3[dat],resolutionlist3[res],scaleslist[scale]),text3,makeImg(aas,"6",chislist[chi],datasetlist3[dat],resolutionlist3[res],scaleslist[scale]),lijn3,lijn3,text2,makeImg(aas,"7",chislist[chi],datasetlist3[dat],resolutionlist3[res],scaleslist[scale]),text3,makeImg(aas,"8",chislist[chi],datasetlist3[dat],resolutionlist3[res],scaleslist[scale]),text3,makeImg(aas,"9",chislist[chi],datasetlist3[dat],resolutionlist3[res],scaleslist[scale]),lijn3,lijn3,lijn4);
				setwd(paste('/home/stage/karenb/Documents/Verslag/',getLongName(aa),sep=""));
				writeLines(text, con = name, sep = "\n", useBytes = FALSE)
			}
		}
	}
}

makeImg<-function(aas,Q,chi,dat,res,scale) {
setwd(paste("/home/stage/karenb/Documents/Verslag/",getLongName(aas),"/Figures/",aas,"/R/Date");
fileName<-paste('Year_',dat,'Quadrant_',Q,'_chi',chi,res,scale,'_50.png',sep="");
if (length(list.files(pattern=fileName))==0) {
string<-paste('<img border=0 hspace=2 src="Figures/NoData.png" alt="Mean values of &chi;',chi,' per resolution for ',getLongName(aas),' in section ',Q,'."  height="400px" width="400px" align="texttop">',sep="");
} else {
string<-paste('<img border=0 hspace=2 src="Figures/',aas,'/R/Date/Year_',dat,'Quadrant_',Q,'_chi',chi,res,scale,'_50.png" alt="Mean values of &chi;',chi,' per resolution for ',getLongName(aas),' in section ',Q,'."  height="400px" width="400px" align="texttop">',sep="");
}
return(string);
}

