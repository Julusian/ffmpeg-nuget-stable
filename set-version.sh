#!/bin/bash

OLD_VERSION=$1
NEW_VERSION=$2

echo "Changing $OLD_VERSION to $NEW_VERSION"

OLD_NUGET_VERSION=`sed -n 's|\s*<version>\(.*\)</version>|\1|p' FFmpeg.Stable.nuspec`
OLD_NUGET_VERSION_MAJOR=`expr "${OLD_NUGET_VERSION}" : '^\([0-9]*\)[.]'`
OLD_NUGET_VERSION_MINOR=`expr "${OLD_NUGET_VERSION}" : '^[0-9]*[.]\([0-9]*\)'`
NEW_NUGET_VERSION_MAJOR=${NEW_VERSION:0:8}

if [ "$OLD_NUGET_VERSION_MAJOR" \> "$NEW_NUGET_VERSION_MAJOR" ]
then
    echo "New major version is lower than old version."
    exit 1
fi

if [ "$OLD_NUGET_VERSION_MAJOR" == "$NEW_NUGET_VERSION_MAJOR" ]
then
    NEW_NUGET_VERSION_MINOR=$((OLD_NUGET_VERSION_MINOR+1))
else
    NEW_NUGET_VERSION_MINOR=0
fi

NEW_NUGET_VERSION=${NEW_NUGET_VERSION_MAJOR}.${NEW_NUGET_VERSION_MINOR}.0

echo "$OLD_VERSION -> $NEW_VERSION"
echo "$OLD_NUGET_VERSION -> $NEW_NUGET_VERSION"

find *.nuspec *.ps1 test/ -type f -exec sed -i "s/$OLD_VERSION/$NEW_VERSION/g" {} \;
find *.nuspec *.ps1 test/ -type f -exec sed -i "s/$OLD_NUGET_VERSION/$NEW_NUGET_VERSION/g" {} \;
sed -i "s/$OLD_VERSION/$NEW_VERSION/g" FFmpeg.Stable.nuspec
sed -i "s/$OLD_VERSION/$NEW_VERSION/g" nuget-readme.txt

