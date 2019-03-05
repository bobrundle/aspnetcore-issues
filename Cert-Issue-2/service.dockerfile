# escape=`

# reference the nanoserver with ASP.NET core dependencies

FROM microsoft/dotnet:2.1-aspnetcore-runtime-nanoserver-1803

# the default shell for our container is powershell

SHELL ["powershell","-Command","$ErrorActionPreference = 'Stop';"]

# copy the service

COPY netcoreapp2.1/ /Service

# copy certificates

COPY testcert.pfx /Service

ENV ASPNETCORE_Kestrel__Certificates__Default__Path "/Service/testcert.pfx"
ENV ASPNETCORE_Kestrel__Certificates__Default__Password "Monkey123"
ENV ASPNETCORE_URLS "https://+:12023;http://+:12022"
ENV ASPNETCORE_HTTPS_PORT 12023
ENV ASPNETCORE_HTTP_PORT 12022

# configure ASP.NET Core for service.

EXPOSE 12022
EXPOSE 12023

# start ASP.NET Core Service

WORKDIR /Service
ENTRYPOINT ["dotnet","ASPDOTNETCoreService.dll"]

