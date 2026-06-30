

FIJI="/nrs/scicompsoft/otsuna/Macros/Fiji_Linux.app/ImageJ-linux64"
SEGMACRO1="/nrs/scicompsoft/otsuna/Macros/Skeleton_Generator_cluster_CPUpart.ijm"
SEGMACRO2="/nrs/scicompsoft/otsuna/Macros/Skeleton_Generator_cluster_GPUpart.ijm"

fullpath=$1
savedir=$2
JFRCMaskDir="/nrs/scicompsoft/otsuna/template/Template_MIP/"
Textpath=$3


echo "fullpath; "${fullpath}
echo "savedir; "${savedir}
echo "JFRCMaskDir; "${JFRCMaskDir}
echo "Textpath; "$Textpath

if [[ ! -d $savedir ]]; then
    mkdir $savedir
fi


foldername=${fullpath%/*}/
echo "foldername; "$foldername


cd ${savedir}

$FIJI -macro ${SEGMACRO2} "${fullpath},${savedir},${JFRCMaskDir},${Textpath}" 



#rm -rf $foldername

exit 0




