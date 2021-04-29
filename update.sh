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
  sed -i "/lookup kr2.*;/d" "$dir/OTC/features.OTC.CL"
  search_and_delete 'lookup kr2jp' 'kr2jp;\n' "$dir/OTC/features.OTC.CL"
  search_and_delete 'lookup kr2cn' 'kr2cn;\n' "$dir/OTC/features.OTC.CL"
  search_and_delete 'lookup kr2tw' 'kr2tw;\n' "$dir/OTC/features.OTC.CL"
  search_and_delete 'lookup kr2hk' 'kr2hk;\n' "$dir/OTC/features.OTC.CL"
done

sed "s|SerifKR|SerifCL|" "source-han-serif/UniSourceHanSerifKR-UTF32-H" > UniSourceHanSerifCL-UTF32-H

cp source-han-serif/SourceHanSerif_KR_sequences.txt SourceHanSerif_CL_sequences.txt
cp source-han-serif/LICENSE.txt LICENSE.txt
