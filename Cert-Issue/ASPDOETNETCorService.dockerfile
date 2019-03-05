# escape=`

# reference the nanoserver with ASP.NET core dependencies

FROM microsoft/dotnet:2.1-aspnetcore-runtime-nanoserver-1803

# the default shell for our container is powershell

SHELL ["powershell","-Command","$ErrorActionPreference = 'Stop';"]

# copy the service

COPY netcoreapp2.1/ /Service

# copy certificates

COPY testcert.pfx /Service

# configure ASP.NET Core for service.

EXPOSE 12020
EXPOSE 12021

# start ASP.NET Core Service

WORKDIR /Service
ENTRYPOINT ["dotnet","ASPDOTNETCoreService.dll"]

