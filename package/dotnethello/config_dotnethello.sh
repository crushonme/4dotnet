#!/bin/bash
# p1 BUILD_DIR
# p2 HOST_DIR
# p3 BR2_PACKAGE_{PKGNAME}_TARGET_ARCH
# p4 @D
# p5 STAGING_DIR
# p6 [PKGNAME}_PKGDIR
# p7 TARGET_DIR

packpath=$1/dotnetruntime-origin_master/artifacts/packages
subdirs=($packpath/*)
localpath=${subdirs[0]}/Shipping
runtimepackname=($localpath/Microsoft.NETCore.App.Runtime.*.nupkg)
ridverpkg=${runtimepackname[0]##*Microsoft.NETCore.App.Runtime.}
if [ -z "$ridverpkg" ]; then
	echo "could not find local dotnet core runtime package!"
	exit 1
fi 
ridver=${ridverpkg%%.nupkg*}
rid=${ridver%%.*}
ver=${ridver#*.}

cat <<EOF > $4/nuget.config
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <packageSources>
      <!--To inherit the global NuGet package sources remove the <clear/> line below -->
    <clear />
    <add key="local runtime" value="$localpath" />
   </packageSources>
</configuration>
EOF

cat <<EOF > $4/dotnethello.csproj
<Project Sdk="Microsoft.NET.Sdk">
        <PropertyGroup>
                <OutputType>Exe</OutputType>
                <TargetFramework>net5.0</TargetFramework>
                <RuntimeIdentifier>$rid</RuntimeIdentifier>
        </PropertyGroup>
        <ItemGroup>
                <FrameworkReference Update="Microsoft.NETCore.App" RuntimeFrameworkVersion="$ver" />
        </ItemGroup>
</Project>
EOF
