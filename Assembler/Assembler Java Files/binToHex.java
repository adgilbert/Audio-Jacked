package assembler;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;

/*
 * This class 
 */
public class binToHex {

	public static void main(String[] args, String machineName, String hexRepName) throws IOException {
	
		int lineCount = 0;
// make a new file to write to
File file = new File(hexRepName);

// if file doesn't exist, then create it
		if (!file.exists()) {
			try {
				file.createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// make a new file writer and line writer
			FileWriter fw = new FileWriter(file.getAbsoluteFile());
			BufferedWriter bw = new BufferedWriter(fw);
			File binFile = new File(machineName);
			Scanner s = null;
			try 
			{
				s = new Scanner(binFile);
			} 
			
			catch (FileNotFoundException e) {
				e.printStackTrace();}
			String line = "";
			// move through each line in the Assembly Code file
			while(s.hasNextLine()){
				// write the instruction from passTwo to the file
				line = s.nextLine();
				if (line.length()>0){
					String hex = Long.toHexString(Long.parseLong(line,2));
					int padding = 8 - hex.length();
					
					String pad = "";
					for (int i = 0; i < padding; i++)
						pad += "0";
					
					String padded = pad + hex;
					bw.write(padded);
					lineCount++;}
				bw.newLine();
			}
			int fillerLines = 150 - lineCount;
			for (int i = 0; i < fillerLines; i++)
			{
				bw.write("00000000");
				bw.newLine();
				lineCount++;
			}
			
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
// READ IN THE GLYPH FILE
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------					
			File glyphFile = new File("largeGlyphs.txt");
			Scanner t = null;
			try 
			{
				t = new Scanner(glyphFile);
			} 
			
			catch (FileNotFoundException e) {
				e.printStackTrace();}
			
			while(t.hasNextLine()){
				// write the instruction from passTwo to the file
				line = t.nextLine();
				if (line.length()>0){
					String hex = Long.toHexString(Long.parseLong(line,2));
					int padding = 8 - hex.length();
					
					String pad = "";
					for (int i = 0; i < padding; i++)
						pad += "0";
					
					String padded = pad + hex;
					bw.write(padded);
					lineCount++;}
				bw.newLine();
			}
			
			// fill the remainder with 0's
			for (int i = 0; i < (1024-lineCount); i++){
				bw.write("00000000");
				bw.newLine();
			}
			
			s.close();
			bw.close();
			System.out.println(hexRepName + " written");
		}
}


