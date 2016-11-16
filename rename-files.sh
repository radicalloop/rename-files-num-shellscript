i=1
sorthelper=();
for file in *; do
    # We need something that can easily be sorted.
    # Here, we use "<date><filename>".
    # Note that this works with any special characters in filenames

    sorthelper+=("$(stat --printf "%Y    %n" -- "$file")"); # Linux only
done;

sorted=();
while read -d $'\0' elem; do
    # this strips away the first 14 characters (<date>)
    sorted+=("${elem:14}");
done < <(printf '%s\0' "${sorthelper[@]}" | sort -z)

for file in "${sorted[@]}";
do
    if [[ $file != "rename-files.sh" && $file != $i ]]
    then
        mv -- "$file" "$i"
        ((i++))
    fi
done;