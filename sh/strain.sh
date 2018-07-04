#!/bin/bash

#     1.0  0.0  0.0
#     0.0  1.0  0.0
#     0.0  0.0  1.0

POSCAR=1.0


AtRegularIntervals(){
  echo "HelloAt"
  echo "$4"
  if [$1 = esc]; then
    for dankai in `seq 0 $Interval`
    do
      POSCARelements$4+=\($POSCAR\)
    done


  else

    wariai=`echo "scale=3; $POSCAR*($1*0.01)" | bc |awk '{if($0~/^\./){print "0"$0}else{print $0}}'`
    echo "Percent: $wariai"

    
    kankaku=`echo "scale=3; $wariai/$2" | bc |awk '{if($0~/^\./){print "0"$0}else{print $0}}'`
    echo "Interval: $kankaku"

    if [ $3 = plus ]; then
      for dankai in `seq 0 $Interval`
      do
        echo "$POSCAR"
        eval POSCARelements$4+=\($POSCAR\)
        POSCAR=`echo "scale=3; $POSCAR+$kankaku" | bc | sed 's/^\./0\./'`
      done

    else 
  
    for dankai in `seq 0 $Interval`
    do
      echo "$POSCAR"
      eval POSCARelements$4+=\($POSCAR\)
      POSCAR=`echo "scale=3; (($POSCAR - $kankaku))" | bc |  sed 's/^\./0\./'`
    done
    fi
  fi
    POSCAR=1.0
    return 0
}

#ここでX~Zの値の変動％と間隔、プラス方向マイナス方向を設定
for value in {X..Z};
do
   echo -n "$value Percent: "
   read  Percent[$value]
   echo  ${Percent[$value]}

   echo -n "$value Interval: "
   read  Interval[$value]
   echo  ${Interval[$value]}

   echo -n "minus or plus ?: "
   read  Trancelate[$value]

AtRegularIntervals "${Percent[$value]}" "${Interval[$value]}" "${Trancelate[$value]}" "$value"

done

echo "escapeAt"
#シェルスクリプトでは0.〜の形で配列にしまえ無いため、置き換えるときに０をつけたす処理を行う。
#| sed -e 's/^\./0./g'これ

echo ${POSCARelementsX[@]}
echo ${POSCARelementsY[@]}
echo ${POSCARelementsZ[@]}


echo "$value"
echo "$Interval"
#sedの行置き換えをつかって3~5行を置換する
sed -i -e '3,5s/1.0/*/g' POSCAR

cat POSCAR

DDD=0
for DDD in `seq 0 $Interval`
do
  echo "welcome Final"
  echo $DDD
  eval sed -i -e '3s/*/'${POSCARelementsX[$DDD]}'/g' POSCAR 
  eval sed -i -e '4s/*/'${POSCARelementsY[$DDD]}'/g' POSCAR
  eval sed -i -e '5s/*/'${POSCARelementsZ[$DDD]}'/g' POSCAR


  #vasp.exe
  #mkdir tmp
  #cp OSZICAR tmp/OSZICAR.$dankai
  
  cat POSCAR
  echo "weeeeeel2"
  eval sed -i -e '3s/'${POSCARelementsX[$DDD]}'/*/g' POSCAR
  eval sed -i -e '4s/'${POSCARelementsY[$DDD]}'/*/g' POSCAR
  eval sed -i -e '5s/'${POSCARelementsZ[$DDD]}'/*/g' POSCAR

  cat POSCAR
done

rm POSCAR
cp POSCAR.cp POSCAR
