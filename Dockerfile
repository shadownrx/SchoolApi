FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Listar archivos antes de copiar para ver qué hay (debug)
RUN ls -la

# Copiar csproj y mostrar contenido para debug
COPY *.csproj ./
RUN ls -la
RUN cat *.csproj

RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

EXPOSE 80
ENTRYPOINT ["dotnet", "SchoolApi.dll"]
