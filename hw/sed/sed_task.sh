#!/bin/bash
# Stanislav Král, 17.11:2020 2020

# load a sample translated .sub file
read -d '' subs_with_translations << EOF
{0}{20}First subtitle
První titulek.
{30}{50}Second subtitle|New line is made this way.
Druhý titulek|Nová řádka se dělá takto.
{70}{100}Third.
Třetí.
{1010}{1033}Fourth etc.
Čtvrtý atd.
EOF

# print out the translated sub file
printf "################\nSubs with translations:\n\n"
echo "$subs_with_translations"


# edit the stream - translate subtitles to the czech language
printf "\n################\nCzech only:\n\n"

# split a line using regex into "timestamps" and text.
# then load another line containing the translation 
# keep only timestamps from the previous line and concat with current line
cz=$(echo "$subs_with_translations" | sed "s/\({\(.*\)}\)\(.*\)/\1/;N;s/\n//") 
echo "$cz"

# edit the stream - remove czech translations
printf "\n################\nEnglish only:\n\n"

# keep only odd lines
en=$(echo "$subs_with_translations" | sed "x;N;x") 
echo "$en"

# merge EN and CZ subtitles
printf "\n################\nEN & CZ merged:\n\n"

# join both sub "files", and remove timestamps from even lines
paste <(echo "$en") <(echo "$cz") -d "\n" | sed "x;N;s/{\(.*\)}\(.*\)/\2/;x;p;x;s/\n//"

