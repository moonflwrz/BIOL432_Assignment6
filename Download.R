ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")
#separate vector for ncbi IDs

library(rentrez) #loading rentrez
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, 
                    rettype = "fasta")
#'entrez_fetch' passes IDs onto an NCBI database..
#'db=nuccore' is database name
# 'id=' unique IDs
#'rettype="fasta"' data in FASTA format

print(Bburg)
Sequences<-strsplit(Bburg, split="\n\n", fixed=T)
print(Sequences)

Sequences<-unlist(Sequences)

header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences<-data.frame(Name=header,Sequence=seq)


Sequences$Sequence<-gsub("\n", "",as.character(
  Sequences$Sequence))

write.csv(Sequences, file="Sequences.csv",
          row.names=F)
