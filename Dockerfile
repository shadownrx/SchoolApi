# Usar imagen oficial de .NET 8 SDK para build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiar csproj y restaurar dependencias
COPY SchoolApi/*.csproj ./SchoolApi/
RUN dotnet restore ./SchoolApi/SchoolApi.csproj

# Copiar todo y compilar release
COPY SchoolApi/. ./SchoolApi/
WORKDIR /app/SchoolApi
RUN dotnet publish -c Release -o out

# Imagen runtime para producción
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/SchoolApi/out .

# Exponer puerto 80
EXPOSE 80

# Comando para correr la app
ENTRYPOINT ["dotnet", "SchoolApi.dll"]
