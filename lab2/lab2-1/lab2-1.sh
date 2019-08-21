#!/bin/bash
#UTF-8
#**************************************************************************
#名称：         lab2-1.sh
#作者：         吴同
#学号：         3170104848
#功能：         1. 统计指定目录下的普通文件、子目录、可执行文件的数目。
#               2. 统计该目录下所有普通文件字节数总和。
#参数：         目录的路径（可选）
#**************************************************************************

#检查运行程序时传入的参数个数是否符合要求，程序最多传入一个参数，即目录的路径。
#错误信息显示为红色。
if test $# -gt 1; then
    echo -e "\033[31m参数个数过多！\033[0m"
    exit 1
fi

#将传入的参数设为待查询目录，若参数为空，后续运行结果不受影响。
directory=$1

#输出待查询的目录，目录显示为深绿色。
#若参数不为空，则参数为待查询目录；若参数为空，则查询当前目录。
echo -en "查询目录：\033[36m"
if test $# -lt 1; then
    pwd
else
    echo $directory
fi

#统计该目录下不同种类文件的个数，包括隐藏文件。
#数字显示为紫色。
#利用长格式ls的输出结果进行判断，第一个字符为文件类型，'-'为普通文件，'d'为目录。
echo -en "\033[0m普通文件个数：    \033[35m"
ls -Al $directory | grep -c "^-"
echo -en "\033[0m目录文件个数：    \033[35m"
ls -Al $directory | grep -c "^d"
#若文件权限中有x或s，则文件为可执行。
echo -en "\033[0m可执行文件个数：  \033[35m"
ls -Al $directory | grep -c "^-[rw-]*[sx]"

#统计该目录下所有普通文件的总字节数。
echo -en "\033[0m普通文件总字节数：\033[35m"
declare -i sum=0
#对该目录下的ls -Al输出结果进行两次正则匹配，
#第一次匹配取普通文件的前五个字段，第二次匹配取第五个字段。
for line in $(ls -Al $directory | grep -o "^-\([^[:blank:]]*[[:blank:]]*\)\{4\}[^[:blank:]]*" | grep -o "[^[:blank:]]*$")
do
    let sum+=line
done
echo -e "$sum\033[0m"

#退出程序
exit 0