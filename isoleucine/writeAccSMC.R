aa<-'Ile';
aas<-toupper(aa);
setwd('/home/stage/karenb/Documents/Verslag/AminoAcids');
source('getLongName.R');


dataset<-c("urdb1","isUnique30","no");
datasetlist<-list("urdb1"="urdb_","isUnique30"="isUnique30_","no"="");
datasetlist2<-list("urdb1"=' <A target="_blank" href="Ordinary_residues.html" >Ordinary residues</A>,',"isUnique30"=' <A target="_blank" href="Unique_chains.html" >Unique chains</A>,',"no"="");
datasetlist3<-list("urdb1"="urdb1_","isUnique30"="isUnique30_","no"="");
valuelist<-list("urdb1"="1.0-","isUnique30"="true-","no"="");
resolution<-c("<2.0",">2.0",">3.0","no");
resolutionlist<-list("<2.0"="[01]{1}\\.[0-9]-2\\.0",">2.0"="2\\.[0-9]{1}-(3\\.0|2\\.[1-9]{1})",">3.0"="3\\.0-[0-9]{1,2}\\.[0-9]{1}","no"="[01]{1}\\.[0-9]{1}-(2\\.[1-9]{1}|[3-9]{1}\\.[0-9]{1}|[0-9]{2}\\.[0-9])")
resolutionlist2<-list("<2.0"=" resolution=[0.0 &Aring;-2.0 &Aring;>,",">2.0"=" resolution=<2.0 &Aring;-3.0 &Aring;>,",">3.0"=" resolution=<3.0 &Aring;-16.0 &Aring;>,","no"="")
resolutionlist3<-list("<2.0"="-<2.0",">2.0"="->2.0",">3.0"="->3.0","no"="->0.0")
resolutionlist4<-list("<2.0"="0.0-2.0_",">2.0"="2.0-3.0_",">3.0"="3.0-16.0_","no"="")
dsspvect<-c("H","S","C","no");
dsspvectlist<-c("H"="H","S"="S","C"="C","no"="all");
dsspvectlist2<-c("H"=" dssp='H'","S"=" dssp='S'","C"=" dssp='C'","no"="");
dsspvectlist3<-c("H"="H-","S"="S-","C"="C-","no"="");
dsspvectlist4<-c("H"="H_","S"="S_","C"="C_","no"="");
text0<-readLines("text4.txt");
text1<-readLines("text5.txt");
text2<-readLines("text2.txt");
text3<-readLines("text3.txt");
lijn3<-"</div>";
lijn4<-"</body></html>";

setwd(getLongName(aas));

for (dat in dataset) {
	for (res in resolution) {
		for (dssp in dsspvect) {
			name<-paste("Java_",aa,"_accSMC_",datasetlist3[dat],resolutionlist4[res],dsspvectlist[dssp],".html",sep="");
			if (dat=="no" && res=="no" && dssp=="no") {
				lijn1<-"<h2>Dataset: all</h2>";
			} else {
				if (dssp=="no") {
					sublijn1<-paste(datasetlist2[dat],resolutionlist2[res],sep="");
				} else {	
					lijn1<-paste("<h2>Dataset:",datasetlist2[dat],resolutionlist2[res],dsspvectlist2[dssp],"</h2>",sep="");
				}		
			}
			if (!(dat=="isUnique30" && res ==">3.0")) {
				text<-c(text0,lijn1,text1,text2,"<p>Accessible</p>",makeImg(aas,"Accessible_","accessible ","","",datasetlist[dat],dsspvectlist3[dssp],resolutionlist[res]),text3,"<p>Intermediate</p>",makeImg(aas,"Intermediate_","intermediate ","","",datasetlist[dat],dsspvectlist3[dssp],resolutionlist[res]),text3,"<p>Burried</p>",makeImg(aas,"Burried_","burried ","","",datasetlist[dat],dsspvectlist3[dssp],resolutionlist[res]),lijn3,lijn3,text2,"<p>Symmetry contact</p>",makeImg(aas,"","","SMC_"," with symmetry contact",datasetlist[dat],dsspvectlist3[dssp],resolutionlist[res]),text3,"<p>No symmetry contact</p>",makeImg(aas,"","","NoSMC_"," without symmetry contact",datasetlist[dat],dsspvectlist3[dssp],resolutionlist[res]),lijn3,lijn3,text2,"<p>Accessible symmetry contact</p>",makeImg(aas,"Accessible_","accessible ","SMC_"," with symmetry contact",datasetlist[dat],dsspvectlist3[dssp],resolutionlist[res]),text3,"<p>Accessible no symmetry contact</p>",makeImg(aas,"Accessible_","accessible ","NoSMC_"," without symmetry contact",datasetlist[dat],dsspvectlist3[dssp],resolutionlist[res]),lijn3,lijn3,text2,"<p>Intermediate symmetry contact</p>",makeImg(aas,"Intermediate_","intermediate ","SMC_"," with symmetry contact",datasetlist[dat],dsspvectlist3[dssp],resolutionlist[res]),text3,"<p>Intermediate no symmetry contact</p>",makeImg(aas,"Intermediate_","intermediate ","NoSMC_"," without symmetry contact",datasetlist[dat],dsspvectlist3[dssp],resolutionlist[res]),lijn3,lijn3,lijn4);
				setwd(paste('/home/stage/karenb/Documents/Verslag/AminoAcids/',getLongName(aas),sep=""));
				writeLines(text, con = name, sep = "\n", useBytes = FALSE)
			}
		}
	}
}

makeImg<-function(aas,acc,acc2,smc,text,dat,dssp,res) {
setwd(paste("/home/stage/karenb/Documents/Verslag/AminoAcids/",getLongName(aas),"/Figures/",aas,"/Java/AccessibilitySMC",sep=""));
sublijn<-paste("_",acc,smc,dat,sep="");
fileName<-list.files(pattern=paste('Chi12_ResolutionBin_0-360',substr(sublijn,0,nchar(sublijn)-1),'-',aas,'-',dssp,res,'.png',sep=""));
if (length(fileName)==0) {
	print(paste('error, cannot find file: ','Chi12_ResolutionBin_0-360',substr(sublijn,0,nchar(sublijn)-1),'-',aas,'-',dssp,res,'.png',sep=""));
	fileName<-paste('Chi12_ResolutionBin_0-360',substr(sublijn,0,nchar(sublijn)-1),'-',aas,'-',dssp,res,'.png',sep="");
}
string<-paste('<img border=0 hspace=2 src="Figures/',aas,'/Java/AccessibilitySMC/',fileName,'" alt="2D histogram of &chi;1-&chi;2 combinations of ',acc2,getLongName(aas),text,'." height="400px" width="400px" align="texttop">',sep="");
return(string);
}
