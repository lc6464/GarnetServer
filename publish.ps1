$lastPwd = $pwd

cd $PSScriptRoot

# Build the solution
Write-Host "Building the solution ..."
dotnet publish GarnetServer.sln -p:PublishProfile=linux-arm64-based
dotnet publish GarnetServer.sln -p:PublishProfile=linux-x64-based
dotnet publish GarnetServer.sln -p:PublishProfile=osx-arm64-based
dotnet publish GarnetServer.sln -p:PublishProfile=osx-x64-based
dotnet publish GarnetServer.sln -p:PublishProfile=portable
dotnet publish GarnetServer.sln -p:PublishProfile=win-arm64-based-readytorun
dotnet publish GarnetServer.sln -p:PublishProfile=win-x64-based-readytorun

# Create the directories
if (!(Test-Path bin/Release/net8.0/publish/output)) {
	mkdir bin/Release/net8.0/publish/output
}
cd bin/Release/net8.0/publish/output

# Compress the files
Write-Host "Compressing the files ..."
7z a -mmt20 -mx5 -scsWIN win-x64-based-readytorun.zip ../win-x64/*
7z a -mmt20 -mx5 -scsWIN win-arm64-based-readytorun.zip ../win-arm64/*

7z a -scsUTF-8 linux-x64-based.tar ../linux-x64/*
7z a -scsUTF-8 linux-arm64-based.tar ../linux-arm64/*
7z a -scsUTF-8 osx-x64-based.tar ../osx-x64/*
7z a -scsUTF-8 osx-arm64-based.tar ../osx-arm64/*

7z a -mmt20 -mx5 -sdel linux-x64-based.tar.xz linux-x64-based.tar
7z a -mmt20 -mx5 -sdel linux-arm64-based.tar.xz linux-arm64-based.tar
7z a -mmt20 -mx5 -sdel osx-x64-based.tar.xz osx-x64-based.tar
7z a -mmt20 -mx5 -sdel osx-arm64-based.tar.xz osx-arm64-based.tar

7z a -mmt20 -mx5 -scsUTF-8 portable.7z ../portable/*


cd $lastPwd