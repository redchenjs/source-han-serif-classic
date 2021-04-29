#!/bin/sh

search_and_delete() {
  sed -i ":begin; /$1/,/$2/ { /$2/! { \$! { N; b begin }; }; /$1.*$2/d; };" $3
}

for dir in ExtraLight Light Regular Medium SemiBold Bold Heavy; do
  mkdir -p "$dir/OTC"
  sed "s|SerifK|SerifC|" "source-han-serif/$dir/OTC/features.OTC.K" > "$dir/OTC/features.OTC.CL"
  sed "s|SerifK|SerifC|" "source-han-serif/$dir/OTC/cidfont.ps.OTC.K" > "$dir/OTC/cidfont.ps.OTC.CL"
  sed "s|SerifK|SerifC|
       s|Korean|Classic|" "source-han-serif/$dir/OTC/cidfontinfo.OTC.K" > "$dir/OTC/cidfontinfo.OTC.CL"
  search_and_delete 'feature locl' 'locl;\n' "$dir/OTC/features.OTC.CL"
done

sed "s|SerifKR|SerifCL|" "source-han-serif/UniSourceHanSerifKR-UTF32-H" > UniSourceHanSerifCL-UTF32-H

cp source-han-serif/SourceHanSerif_KR_sequences.txt SourceHanSerif_CL_sequences.txt
cp source-han-serif/LICENSE.txt LICENSE.txt
