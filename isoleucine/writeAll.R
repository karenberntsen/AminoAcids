aa<-'Ile';
aas<-toupper(aa);
setwd('/home/stage/karenb/Documents/Verslag/AminoAcids');
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
text1<-readLines("text14.txt");
text0<-paste('<h1>&chi;1-&chi;2 plots ',getLongName(aas),'</h1>',sep="");
lijn2<-"<p>x-axis: &chi;1, [0,360]<br>y-axis: &chi;2, [0,360]</p>";
text2<-readLines("text2.txt");
text3<-readLines("text3.txt");
lijn3<-"</div>";
lijn4<-"</body></html>";

setwd(getLongName(aas));

for (dat in dataset) {
	for (res in resolution) {
		name<-paste("Java_",aa,"_all",datasetlist[dat],resolutionlist[res],".html",sep="");
		if (dat=="no" && res=="no") {
			lijn1<-"<h2>Dataset: all</h2>";
			name<-paste("Java_",aa,"_all_all.html",sep="");
		} else {
			sublijn1<-paste(datasetlist2[dat],resolutionlist2[res],sep="");
			lijn1<-paste("<h2>Dataset:",substr(sublijn1,0,nchar(sublijn1)-1),"</h2>",sep="");		
		}
		text<-c(text1,text0,lijn1,lijn2,text2,"<p>&alpha;-helix</p>",makeImg(aas,datasetlist[dat],resolutionlist4[res],"H_"),text3,"<p>&beta;-strand</p>",makeImg(aas,datasetlist[dat],resolutionlist4[res],"S_"),lijn3,lijn3,text2,"<p>loop</p>",makeImg(aas,datasetlist[dat],resolutionlist4[res],"C_"),text3,"<p>all</p>",makeImg(aas,datasetlist[dat],resolutionlist4[res],""),lijn3,lijn3,lijn4);
		writeLines(text, con = name, sep = "\n", useBytes = FALSE)
	}
}

makeImg<-function(aas,dat,res,dssp) {
string<-paste('<img border=0 hspace=2 src="Figures/',aas,'/Java/Chi12',dat,'_',dssp,res,'HT14-',aas,'.png" alt="2D histogram of &chi;1-&chi;2 combinations of ',getLongName(aas),'"  height="400px" width="400px" align="texttop">',sep="");
return(string);
}

