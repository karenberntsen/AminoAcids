##PLEASE ALTER THE FUNCTION MAKETABLE FOR OTHER AMINO ACIDS THAN ISOLEUCINE!!!
library(Hmisc);
aa<-'Ile';
aas<-toupper(aa);
setwd('/home/stage/karenb/Documents/Verslag/');
source('getLongName.R');

resolution<-c("<2.0","<2.5","<1.5");
resolutionlist<-list("<2.0"="_1.5-2.0","<2.5"="_2.0-2.5","<1.5"="_0.0-1.5")
resolutionlist2<-list("<2.0"="<1.5 &Aring;-2.0 &Aring;], ","<2.5"="<2.0 &Aring;-2.5 &Aring;], ","<1.5"="[0.0 &Aring;-1.5 &Aring;], ")
resolutionlist3<-list("<2.0"="2","<2.5"="2.5","<1.5"="1.5");
dsspvect<-c("H","S","C");
text1<-readLines("text19.txt");
lijn0<-'<p><A HREF="index.html">Back</A></p>';
lijn2<-"<p>x-axis: &chi;1, [0,360]<br>y-axis: &chi;2, [0,360]<br>solid ellips: 1 standard deviation from the mean<br>dotted ellips: 2 standard deviations from the mean<br>'+': fitted mean when at least one standard deviation is greater than 120 degrees (see Table below)<br>'*': mean when there are less than 50 data points</p>";
text2<-readLines("text2.txt");
text3<-readLines("text3.txt");
lijn3<-"</div>";
lijn4<-"</body></html>";
lijn5<-'<p style="clear: both"></p><br>';

setwd(getLongName(aas));

for (res in resolution) {
	for (dssp in dsspvect) {
		name<-paste("Java_",aa,"_rpfit_urdb1",resolutionlist[res],'_',dssp,".html",sep="");
		lijn1<-paste('<h2>Dataset: <A ONCLICK="return kadabra(',"'sublist01');",'" HREF="Ordinary_residues.html">Ordinary residues</A>, resolution=',resolutionlist2[res],"dssp='",dssp,"'</h2>",sep="");	
		text<-c(text1,lijn0,lijn1,lijn2,text2,"<p>REFMAC</p>",makeImg(aas,'REFMAC',resolutionlist3[res],dssp),text3,"<p>CNS</p>",makeImg(aas,'CNS',resolutionlist3[res],dssp),lijn3,lijn3,text2,"<p>PHENIX</p>",makeImg(aas,'PHENIX',resolutionlist3[res],dssp),text3,"<p>X-PLOR</p>",makeImg(aas,'X_PLOR',resolutionlist3[res],dssp),lijn3,lijn3,text2,"<p>SHELXL</p>",makeImg(aas,'SHELXL',resolutionlist3[res],dssp),lijn3,lijn3,lijn5,makeTable(aas,resolutionlist3[res],dssp),lijn4);
		writeLines(text, con = name, sep = "\n", useBytes = FALSE)
	}
}

makeImg<-function(aas,refprog,res,dssp) {
string<-paste('<img border=0 hspace=2 src="Figures/',aas,'/Java/RefProgFit/',dssp,'_',refprog,'_',res,'_q17_urdb1_noax.png" alt="2D histogram of &chi;1-&chi;2 combinations of ',getLongName(aas),' refined by ',refprog,'"  height="400px" width="400px" align="texttop">',sep="");
return(string);
}

makeTable<-function(aas,res,dssp) {
	table<-c(paste('<A ONCLICK="return kadabra(',"'sublist01');",'" HREF="Java_',capitalize(tolower(aas)),'_Fit_Ord.html">Table</A>',sep=""),'<UL ID="sublist01">');
	table<-c(table,readLines(paste("/home/stage/karenb/Dropbox/Stage/Distributies_gert/Table_q17_urdb1_",dssp,"_",res,".txt",sep="")));
	table<-c(table,'</UL>');
	return(table);
}

