#!/user/bin/env bash
help(){
    cat << EOF
    Description:
        A picture batch processing script written with Bash
    Usage:
        bash $0 [-q <dir> <Q>] [-r <dir> <R>] [-w <dir> <content> <position> <size> <transparent>] 
                [-p <dir> <prefix>] [-s <dir> <suffix>] [-t <dir>] 
    Avaliable options:
        -f,--file                         the file name or path of your images
        -q,--quality                      change the compress qualities of jpg/jpeg images
        -r,--resize                       resize your jpg/jpeg/svg/png images with original aspect ratio
        -m,--mark                         add watermark to jpg/jpeg/png images
        -p,--prefix                       add prefix to new images' names
        -s,--suffix                       add suffix to new images' names
        -c,--convert                      convert png/svg images to jpg images
        -h,--help                         show help information
EOF
}
jepg_Qcompress(){
     Q=$1 # 质量因子
    for img in *;do
        type=${img##*.} # 删除最后一个.及左边全部字符
        if [[ ${type} != "jpeg" ]]; then continue; fi;
        convert "${img}" -quality "${Q}" "${img}"
        echo "${img}" is compressed.
    done
}

image_compress_resolution(){
     R=$1
    for img in *;do
        type=${img##*.}
        if [[ ${type} != "jpeg" && ${type} != "png" && ${type} != "svg" ]]; then continue; fi;
        convert "${img}" -resize "${R}" "${img}"
        echo Resolution of "${img}" is resized into "$R"
    done
}

add_watermark(){
     for img in *;do
        type=${img##*.}
        if [[ ${type} != "jpeg" && ${type} != "png" && ${type} != "svg" ]]; then continue; fi;
        convert "${img}" -pointsize "$1" -fill black -gravity center -draw "text 10,10 '$2'" "${img}"
        echo "${img} is watermarked with $2."
    done
}
#
add_prefix(){
    for img in *;do
        type=${img##*.}
        if [[ ${type} != "jpeg" && ${type} != "png" && ${type} != "svg" ]]; then continue; fi;
        mv "$img" "$1$img"
        echo "$img is renamed as $1$img"
        done
}
#
add_suffix(){
     for img in *;do
        type=${img##*.}
        if [[ ${type} != "jpeg" && ${type} != "png" && ${type} != "svg" ]]; then continue; fi;
        filename=${img%.*}$1"."${type}
        mv "${img}" "${filename}"
        echo "${img} is renamed to ${filename}"
    done
}
#
image_transform(){
    for img in *;do
        type=${img##*.}
        if [[ ${type} != "png" && ${type} != "svg" ]]; then continue; fi;
        filename=${img%.*}".jpg"
        convert "${img}" "${filename}"
   	echo "${img} is transformed to ${filename}"
    done
}

while [ "$1" != "" ];do
case "$1" in
    "-q")
        jepg_Qcompress "$2"
        exit 0
        ;;
    "-r")
        image_compress_resolution "$2"
        exit 0
        ;;
    "-w")
        add_watermark "$2" "$3"
        exit 0
        ;;
    "-p")
        add_prefix "$2"
        exit 0
        ;;
    "-s")
        add_suffix "$2"
        exit 0
        ;;
    "-t")
        image_transform
        exit 0
        ;;
    "-h")
        help
        exit 0
        ;;
esac
done

#jepg_Qcompress 50
#image_compress_resolution 90%
#add_watermark 10 cmy
#add_prefix 0
#add_suffix 1
#image_transform