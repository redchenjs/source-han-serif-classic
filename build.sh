#!/bin/sh

mkdir -p OTF

for dir in ExtraLight Light Regular Medium SemiBold Bold Heavy; do
  cd "$dir/OTC"
  makeotf -f cidfont.ps.OTC.CL -omitMacNames -ff features.OTC.CL -fi cidfontinfo.OTC.CL -mf ../../FontMenuNameDB -r -nS -cs 3 -ch ../../UniSourceHanSerifCL-UTF32-H -ci ../../SourceHanSerif_CL_sequences.txt ; tx -cff +S cidfont.ps.OTC.CL CFF.OTC.CL ; sfntedit -a CFF=CFF.OTC.CL "SourceHanSerifC-$dir.otf"
  mv "SourceHanSerifC-$dir.otf" ../../OTF
  rm CFF.OTC.CL
  cd ../../
done

zip source-han-serif-classic-otf.zip LICENSE.txt OTF/*
