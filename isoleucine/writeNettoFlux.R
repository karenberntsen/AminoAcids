setwd('/home/stage/karenb/Documents/Verslag/AminoAcids/');
dsspvect<-c("H","S","C","all");
dsspList<-list("H"="_H","S"="_S","C"="_C","all"="");
dsspList2<-list("H"=" in an &alpha;-helix","S"=" in a &beta;-strand","C"=" in a loop","all"="");
pdbvect<-c("Central","Decentral","none");
pdbList<-c("Central"="relativeFromORG_netto","Decentral"="relativeToORG_netto","none"="netto");
pdbList2<-c("Central"="Net flux relative to central section","Decentral"="Net flux relative to decentral sections","none"="Absolute net flux");
pdbList3<-c("Central"="_Central_","Decentral"="_Decentral_","none"="_");
pdbList4<-c("Central"="*100/X<sub>i,PDB</sub>","Decentral"="*100/X<sub>j,PDB</sub>","none"="");
pdbList5<-c("Central"="*100/X<sub>column,PDB</sub>","Decentral"="*100/X<sub>column,PDB</sub>","none"=""); #tocheck

text1<-readLines("text17.txt");
text2<-readLines("text2.txt");
text3<-readLines("text3.txt");
text8<-readLines("text16.txt");
text9<-"<p>Definitions:<br>Flux<sub>i,j</sub> = Flux from section i in PDB to section j in PDB-REDO<br>\nNet flux<sub>i,j</sub> = Flux<sub>i,j</sub>-Flux<sub>j,i</sub><br>\nX<sub>i,PDB</sub> = total amount of isoleucines in section i in PDB</p>";
text10<-"<p>Arrows show the net flux from section A in PDB to section B in PDB-REDO.<br>"


lijn0<-paste("<h1>Net flux of isoleucine from PDB to PDB-REDO per section</h1>",sep="");
lijn3<-"</div>";
lijn4<-"</body></html>";
setwd('isoleucine');

for (dssp in dsspvect) {
	for (pdb in pdbvect) {
		text10b<-paste("Thickness of arrow<sub>i,j</sub> = ln(net flux",pdbList4[pdb],"+1).<br>Section 0 is omitted in the plots.</p>",sep="");
		lijn1<-paste("<h2>",pdbList2[pdb],dsspList2[dssp],"</h2>",sep="");
		name<-paste("R_Ile_NettoFlux",pdbList3[pdb],dssp,".html",sep="");
		table<-makeTable(name,paste("Netto flux",pdbList5[pdb],sep=""),getTableName(pdb,dssp));
		if (pdb=="none") {
			text<-c(text1,lijn1,text8,text9,table,text10,text10b,text2,makeImg(pdbList[pdb],dsspList[dssp],1),lijn3,lijn3,lijn4);
		} else {
			text<-c(text1,lijn1,text8,text9,table,text10,text10b,text2,makeImg(pdbList[pdb],dsspList[dssp],1),text3,makeImg(pdbList[pdb],dsspList[dssp],2),text3,makeImg(pdbList[pdb],dsspList[dssp],3),lijn3,lijn3,text2,makeImg(pdbList[pdb],dsspList[dssp],4),text3,makeImg(pdbList[pdb],dsspList[dssp],5),text3,makeImg(pdbList[pdb],dsspList[dssp],6),lijn3,lijn3,text2,makeImg(pdbList[pdb],dsspList[dssp],7),text3,makeImg(pdbList[pdb],dsspList[dssp],8),text3,makeImg(pdbList[pdb],dsspList[dssp],9),lijn3,lijn3,lijn4);
		}
		setwd('/home/stage/karenb/Documents/Verslag/AminoAcids/isoleucine');
		writeLines(text, con = name, sep = "\n", useBytes = FALSE)
	}
}

makeImg<-function(pdb,dssp,section) {
setwd("/home/stage/karenb/Documents/Verslag/AminoAcids/isoleucine/Figures/ILE/R/Flux");
if (pdb=="netto") {
	fileName<-paste(pdb,dssp,'.png',sep="");
	name="Flux isoleucine from PDB to PDB-REDO.";
} else {
	fileName<-paste(pdb,dssp,"_S",section,'.png',sep="");
	name=paste('Flux isoleucine from PDB to PDB-REDO in section ',section,'.',sep="");
}
if (length(list.files(pattern=fileName))==0) {
print('Error! Cannot find file');
print(fileName);
}
string<-paste('<img border=0 hspace=2 src="Figures/ILE/R/Flux/',fileName,'" alt="',name,'"  height="400px" width="400px" align="texttop">',sep="");
return(string);
}

makeTable<-function(name,title,tableFile) {
table<-read.table(tableFile,header=TRUE,row.names=1);
if (row.names(table)[1]=="R0") {
	rowname="R";
	colname="O";
} else {
	rowname="B";
	colname="A";
}
line<-"";
firstline<-paste('<A ONCLICK="return kadabra(',"'sublist01'",');" HREF="',name,'">Table</A>\n<UL ID="sublist01">\n<TABLE border="1">',sep="");
caption<-paste('<CAPTION><EM>',title,'</EM></CAPTION>',sep="");
foot<-paste('<TFOOT>\n','<TR><TD colspan=11>Numbers are rounded to two digits to the right of the decimal point','\n</TFOOT>\n',sep="");
firstrow<-"<TR><TH>PDB<br>PDB-REDO<TH>S0<TH>S1<TH>S2<TH>S3<TH>S4<TH>S5<TH>S6<TH>S7<TH>S8<TH>S9";
for (s in c(0:9)) {
	row<-table[paste(rowname,s,sep=""),];
	line<-paste(line,"<TR><TH>S",s,sep="");
	for (t in c(0:9)) {
		line<-paste(line,"<TD>",row[paste(colname,t,sep="")]);
	}
	line<-paste(line,'\n',sep="");	
}
return(paste(firstline,'\n',caption,'\n',foot,firstrow,'\n',line,"</TABLE>\n</UL>",sep=""));
}

getTableName<-function(pdb,dssp) {
	dsspList<-list("H"="h","S"="s","C"="i","all"="t");
	pdbList5<-list("Central"=paste("/home/stage/karenb/counts",dsspList[dssp],"diffpercentage.txt",sep=""),"Decentral"=paste("/home/stage/karenb/counts",dsspList[dssp],"diffpercentage.txt",sep=""),"none"=paste("/home/stage/karenb/counts",dsspList[dssp],"diff.txt",sep=""));
	return(pdbList5[[pdb]]);
}
