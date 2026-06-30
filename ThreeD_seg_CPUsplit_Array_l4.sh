


inputarray=$1
linum=$LSB_JOBINDEX

echo "inputarray  "$inputarray
echo "LSB_JOBINDEX  "$LSB_JOBINDEX

#file open
stringline=$(awk 'NR == v1' v1="${linum}" $inputarray)

echo "stringline; "$stringline

#line by line, split to array
IFS=' ' read -r -a array <<< $stringline

fullpath=${array[0]}
savedir=${array[1]}
VxWidth=${array[2]}
VxDepth=${array[3]}

FIJI="/nrs/scicompsoft/otsuna/Macros/Fiji_Linux.app/ImageJ-linux64"
SEGMACRO1="/nrs/scicompsoft/otsuna/Macros/Skeleton_Generator_cluster_CPUpart.ijm"
SEGMACRO2="/nrs/scicompsoft/otsuna/Macros/Skeleton_Generator_cluster_GPUpart.ijm"
JFRCMaskDir="/nrs/scicompsoft/otsuna/template/Template_MIP/"

echo "fullpath; "${fullpath}
echo "savedir; "${savedir}
echo "JFRCMaskDir; "${JFRCMaskDir}
echo "VxWidth; "${VxWidth}
echo "VxDepth; "${VxDepth}

if [[ ! -d $savedir ]]; then
    mkdir $savedir
fi

cd ${savedir}


a=$fullpath

b=${a%.*}
c=${b#*/}
d=${c#*/}
e=${d#*/}
f=${e#*/}
g=${f#*/}
h=${g#*/}
i=${h#*/}
p=${i#*/}
foldername=${p#*/}

echo "foldername; "$foldername

fullpath2=${savedir}${foldername}/${foldername}.nrrd

Textpath=${savedir}${foldername}/${foldername}.txt

if [ ! -e ${fullpath2} ]; then
    $FIJI -macro ${SEGMACRO1} "${fullpath},${savedir},${JFRCMaskDir},${VxWidth},${VxDepth}" 
fi

if [ -e ${fullpath2} ]; then
  bsub -n 4 -W 240 -gpu "num=1" -q gpu_l4 -o /nrs/scicompsoft/otsuna/Guest/Abraham/LM_2026/ -P imagingsupport sh /nrs/scicompsoft/otsuna/Macros/ThreeD_seg_GPUpart.sh $fullpath2 $savedir $Textpath;
  echo "running GPUjob"
fi
#/nrs/scicompsoft/emlm/public_release_2024/Omunibus_broad/VNC/IS/$foldername.log
#/dev/null
#rm ${savedir}${foldername}.h5j.txt

exit 0




