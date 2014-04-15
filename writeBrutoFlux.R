setwd('/home/stage/karenb/Documents/Verslag/06-05-2013');
dsspvect<-c("H","S","C","all");
dsspList<-list("H"="_H","S"="_S","C"="_C","all"="");
dsspList2<-list("H"=" in an &alpha;-helix","S"=" in a &beta;-strand","C"=" in a loop","all"="");
pdbvect<-c("PDB","PDB-REDO","none");
pdbList<-c("PDB"="relativeORG","PDB-REDO"="relativeRED","none"="absolute");
pdbList2<-c("PDB"="Flux relative to PDB","PDB-REDO"="Flux relative to PDB-REDO","none"="Absolute flux");
pdbList3<-c("PDB"="_PDB_","PDB-REDO"="_PDB-REDO_","none"="_");
pdbList4<-c("PDB"="*100/X<sub>i,PDB</sub>","PDB-REDO"="*100/X<sub>j,PDB-REDO</sub>","none"="");
pdbList5<-c("PDB"="*100/X<sub>column,PDB</sub>","PDB-REDO"="*100/X<sub>row,PDB-REDO</sub>","none"="");

text1<-readLines("text15.txt");
text2<-readLines("text2.txt");
text3<-readLines("text3.txt");
text8<-readLines("text16.txt");
text9<-"<p>Definitions:<br>Flux<sub>i,j</sub> = Flux from section i in PDB to section j in PDB-REDO<br>\nX<sub>i,PDB</sub> = total amount of isoleucines in section i in PDB<br>\nX<sub>i,PDB-REDO</sub> = total amount of isoleucines in section i in PDB-REDO</p>";
text10<-"<p>Arrows show the flux from section A in PDB to section B in PDB-REDO.<br>"


lijn0<-paste("<h1>Bruto flux of isoleucine from PDB to PDB-REDO per section</h1>",sep="");
lijn3<-"</div>";
lijn4<-"</body></html>";

for (dssp in dsspvect) {
	for (pdb in pdbvect) {
		text10b<-paste("Thickness of arrow<sub>i,j</sub> = ln(|Flux<sub>i,j</sub>|",pdbList4[pdb],"+0.1).<br>Section 0 is omitted in the plots.</p>",sep="");
		lijn1<-paste("<h2>",pdbList2[pdb],dsspList2[dssp],"</h2>",sep="");
		name<-paste("R_Ile_BrutoFlux",pdbList3[pdb],dssp,".html",sep="");
		table<-makeTable(name,paste("Flux",pdbList5[pdb],sep=""),getTableName(pdb,dssp));
		text<-c(text1,lijn1,text8,text9,table,text10,text10b,text2,makeImg(pdbList[pdb],dsspList[dssp],1),text3,makeImg(pdbList[pdb],dsspList[dssp],2),text3,makeImg(pdbList[pdb],dsspList[dssp],3),lijn3,lijn3,text2,makeImg(pdbList[pdb],dsspList[dssp],4),text3,makeImg(pdbList[pdb],dsspList[dssp],5),text3,makeImg(pdbList[pdb],dsspList[dssp],6),lijn3,lijn3,text2,makeImg(pdbList[pdb],dsspList[dssp],7),text3,makeImg(pdbList[pdb],dsspList[dssp],8),text3,makeImg(pdbList[pdb],dsspList[dssp],9),lijn3,lijn3,lijn4);
		setwd('/home/stage/karenb/Documents/Verslag/06-05-2013');
		writeLines(text, con = name, sep = "\n", useBytes = FALSE)
	}
}

makeImg<-function(pdb,dssp,section) {
setwd("/home/stage/karenb/Documents/Verslag/06-05-2013/Figures/ILE/R/Flux");
fileName<-paste(pdb,dssp,"_S",section,'.png',sep="");
if (length(list.files(pattern=fileName))==0) {
print('Error! Cannot find file');
}
string<-paste('<img border=0 hspace=2 src="Figures/ILE/R/Flux/',pdb,dssp,"_S",section,'.png" alt="Flux isoleucine from PDB to PDB-REDO in section ',section,'."  height="400px" width="400px" align="texttop">',sep="");
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
	dsspList<-list("H"="_helical.txt","S"="_strandy.txt","C"="_irregular.txt","all"=".txt");
	dsspList2<-list("H"="h","S"="s","C"="i","all"="t");
	pdbList5<-list("PDB"=paste("/home/stage/karenb/percentages",dsspList2[dssp],".txt",sep=""),"PDB-REDO"=paste("/home/stage/karenb/percentages",dsspList2[dssp],"2.txt",sep=""),"none"=paste("/home/stage/karenb/Downloads/Counts_gert",dsspList[dssp],sep=""));
	return(pdbList5[[pdb]]);
}
