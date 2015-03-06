aa<-'Ile';
aas<-toupper(aa);
setwd('/home/stage/karenb/Documents/Verslag/AminoAcids/');
source('getLongName.R');

dataset<-c("urdb1","isUnique30","no");
datasetlist<-list("urdb1"="_urdb1","isUnique30"="_isUnique30","no"="");
datasetlist2<-list("urdb1"=' <A target="_blank" href="Ordinary_residues.html" >Ordinary residues</A>,',"isUnique30"=' <A target="_blank" href="Unique_chains.html" >Unique chains</A>,',"no"="");
valuelist<-list("urdb1"="1.0-","isUnique30"="true-","no"="");
resolution<-c("<2.0",">2.0",">3.0","no");
resolutionlist<-list("<2.0"="_0.0-2.0",">2.0"="_2.0-16.0",">3.0"="_3.0-16.0","no"="")
resolutionlist2<-list("<2.0"=" resolution=[0.0 &Aring;-2.0 &Aring;>,",">2.0"=" resolution=<2.0 &Aring;-16.0 &Aring;>,",">3.0"=" resolution=<3.0 &Aring;-16.0 &Aring;>,","no"="")
resolutionlist3<-list("<2.0"="-<2.0",">2.0"="->2.0",">3.0"="->3.0","no"="->0.0")
resolutionlist4<-list("<2.0"="res_0.0-2.0",">2.0"="res_2.0-16.0",">3.0"="res_3.0-16.0","no"="")
dsspvect<-c("H","S","C","no");
dsspvectlist<-c("H"="_H","S"="_S","C"="_C","no"="_all");
dsspvectlist2<-c("H"=" dssp='H'","S"=" dssp='S'","C"=" dssp='C'","no"="");
dsspvectlist3<-c("H"="H-","S"="S-","C"="C-","no"="");
dsspvectlist4<-c("H"="H_","S"="S_","C"="C_","no"="");
text1<-readLines("text14.txt");
text0<-paste('<h1>Refinement software &chi;1-&chi;2 plots ',getLongName(aas),'</h1>',sep="");
lijn2<-"<p>x-axis: &chi;1, [0,360]<br>y-axis: &chi;2, [0,360]</p>";
text2<-readLines("text2.txt");
text3<-readLines("text3.txt");
lijn3<-"</div>";
lijn4<-"</body></html>";

setwd(getLongName(aas));

for (dat in dataset) {
	for (res in resolution) {
		for (dssp in dsspvect) {
			name<-paste("Java_",aa,"_refprog",datasetlist[dat],resolutionlist[res],dsspvectlist[dssp],".html",sep="");
			if (dat=="no" && res=="no" && dssp=="no") {
				lijn1<-"<h2>Dataset: all</h2>";
			} else {
				if (dssp=="no") {
					sublijn1<-paste(datasetlist2[dat],resolutionlist2[res],sep="");
					lijn1<-paste("<h2>Dataset:",substr(sublijn1,0,nchar(sublijn1)-1),"</h2>",sep="");
				} else {	
					lijn1<-paste("<h2>Dataset:",datasetlist2[dat],resolutionlist2[res],dsspvectlist2[dssp],"</h2>",sep="");
				}		
			}
			lijn5<-makeImg(aas,'REFMAC',datasetlist[dat],resolutionlist3[res],dsspvectlist3[dssp],valuelist[dat])
			text<-c(text1,text0,lijn1,lijn2,text2,"<p>REFMAC</p>",makeImg(aas,'REFMAC',datasetlist[dat],resolutionlist3[res],dsspvectlist3[dssp],valuelist[dat]),text3,"<p>CNS</p>",makeImg(aas,'CNS',datasetlist[dat],resolutionlist3[res],dsspvectlist3[dssp],valuelist[dat]),lijn3,lijn3,text2,"<p>PHENIX</p>",makeImg(aas,'PHENIX',datasetlist[dat],resolutionlist3[res],dsspvectlist3[dssp],valuelist[dat]),text3,"<p>X-PLOR</p>",makeImg(aas,'X-PLOR',datasetlist[dat],resolutionlist3[res],dsspvectlist3[dssp],valuelist[dat]),lijn3,lijn3,text2,"<p>SHELXL</p>",makeImg(aas,'SHELXL',datasetlist[dat],resolutionlist3[res],dsspvectlist3[dssp],valuelist[dat]),text3,"<p>TNT</p>",makeImg(aas,'TNT',datasetlist[dat],resolutionlist3[res],dsspvectlist3[dssp],valuelist[dat]),lijn3,lijn3,text2,"<p>PROLSQ</p>",makeImg(aas,'PROLSQ',datasetlist[dat],resolutionlist3[res],dsspvectlist3[dssp],valuelist[dat]),text3,"<p>ALL</p>",makeLastImg(aas,datasetlist[dat],resolutionlist4[res],dsspvectlist4[dssp]),lijn3,lijn3,lijn4);
			writeLines(text, con = name, sep = "\n", useBytes = FALSE)
		}
	}
}

makeImg<-function(aas,refprog,dat,res,dssp,value) {
string<-paste('<img border=0 hspace=2 src="Figures/',aas,'/Java/Refprog/',refprog,'/Chi12',dat,'_HT-',dssp,refprog,res,'-',value,aas,'.png" alt="2D histogram of &chi;1-&chi;2 combinations of ',getLongName(aas),' refined by ',refprog,'"  height="400px" width="400px" align="texttop">',sep="");
return(string);
}

makeLastImg<-function(aas,dat,res,dssp) {
string<-paste('<img border=0 hspace=2 src="Figures/',aas,'/Java/Chi12',dat,'_',dssp,res,'HT14-',aas,'.png" alt="2D histogram of &chi;1-&chi;2 combinations of ',getLongName(aas),'"  height="400px" width="400px" align="texttop">',sep="");
return(string);
}
