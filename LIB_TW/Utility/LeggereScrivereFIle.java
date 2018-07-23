//SCRITTURA BUFFERIZZATA
// creo un oggetto FileWriter...
FileWriter fileout = new FileWriter("copyprintwrite.txt");
// ... che incapsulo in un BufferedWriter...
BufferedWriter filebuf = new BufferedWriter(fileout);
// ... che incapsulo in un PrintWriter
PrintWriter printout = new PrintWriter(filebuf);
// ... stampo sul file
printout.writeLine("ASDASDASD");

//LETTURA BUFFERIZZATA
// incapsula in BufferedReader un file aperto in lettura 
BufferedReader filebuf = new BufferedReader(new FileReader("copyread.txt")); 
/* equivale alla coppia di istruzioni:
*
* FileReader filein = new FileReader("copyread.txt");
* BufferedReader filebuf = new BufferedReader(filein);
*/
String s = filebuf.readLine();