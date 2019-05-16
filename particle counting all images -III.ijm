

// This macro processes all the images in a folder and any subfolders.


  extension = ".bmp";
  dir1 = getDirectory("Choose Source Directory ");
 // dir2 = getDirectory("Choose Destination Directory ");
  setBatchMode(false);
  x = 0;
  w = 0;
  h = 1;
  y = 0;
  n = 0;
  processFolder(dir1);

  function processFolder(dir1) {
     list = getFileList(dir1);
     for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/")){
              processFolder(dir1+list[i]);}
          else if (endsWith(list[i], extension)){
             processImage(dir1, list[i]);
	x = x+ 200;
	w++;
	if(w == h * 6){
	y = y + 150;
	x = 0;
	h++;	        
}
					         }
      }
  }

  function processImage(dir1, name) {
      open(dir1+name);
     print(n++, name);
	
setLocation(x,y,300,200);

run("16-bit");
run("Subtract Background...", "rolling=20 light");
setAutoThreshold("Default");
//run("Threshold...");
setOption("BlackBackground", false);
run("Convert to Mask");
run("Watershed");
run("Fill Holes");
run("Analyze Particles...", "size=50-Infinity display clear summarize");


    // saveAs(extension, dir2+name);

  }
