setBatchMode(true);


dir=getDirectory("Choose a Directory");
list = getFileList(dir);
Array.sort(list);
Array.reverse(list);

FolderLSF=dir;

resolutnum=0; minus=0;
for(i=0; i<list.length; i++){
	if(endsWith(list[i], ".tif") || endsWith(list[i], ".h5j") || endsWith(list[i], ".nrrd")){
		
		VolumeIndex = indexOf(dir, "Volumes");
		scicompIndex = indexOf(dir, "scicompsoft");
		if(VolumeIndex!=-1 && scicompIndex==-1){
			FolderLSF = replace (FolderLSF, "Volumes", "nrs/scicompsoft");
			parentsdirLSF = replace (parentsdirLSF, "Volumes", "nrs/scicompsoft");
			templatePath = replace (templatePath, "Volumes", "nrs/scicompsoft");
		}
		
		if(VolumeIndex!=-1 && scicompIndex!=-1){
			FolderLSF = replace (FolderLSF, "Volumes", "nrs");
			parentsdirLSF = replace (parentsdirLSF, "Volumes", "nrs");
			templatePath = replace (templatePath, "Volumes", "nrs");
		}

FolderLSF = replace (FolderLSF, "\\", "/");
FolderLSF = replace (FolderLSF, "//", "/");
FolderLSF = replace (FolderLSF, "nrsv", "nrs");

		prefolder=substring(FolderLSF, 0, lengthOf(FolderLSF)-1);
		filepathindex=lastIndexOf(prefolder, File.separator);
		prefolder=substring(FolderLSF, 0, filepathindex+1);
//DIR=$1
//		SAVEDIR=$2
//		MASKDIR=$3
//		FILENAME=$4
//		GAMMA=$5
//		easyADJ=$6
		
		print(FolderLSF+list[i]+" "+FolderLSF+"Res/"+" 0.44 0.44");
		
		//for i in /nrs/scicompsoft/emlm/VNC/split/test/*.nrrd; do bsub -n 1 -W 10 -R"select[avx512]" -o /nrs/scicompsoft/emlm/VNC/split/test/ -P imagingsupport sh /nrs/scicompsoft/otsuna/Macros/color_depthMIP_creation_packbits.sh /nrs/scicompsoft/emlm/VNC/split/test/ /nrs/scicompsoft/emlm/VNC/split/segmented_CDM/ /nrs/scicompsoft/otsuna/template/ $i 1.4 true; done
		
	//	setResult("Name", resolutnum, list[minus]);
	}
}
