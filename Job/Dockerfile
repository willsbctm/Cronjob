FROM mcr.microsoft.com/dotnet/core/runtime-deps:3.1-alpine AS base
RUN apk add icu-libs
WORKDIR /app

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS restore
WORKDIR /src
COPY ["Job.csproj", "./"]
RUN dotnet restore -r linux-musl-x64 "./Job.csproj"
COPY . .

FROM restore AS publish
RUN dotnet publish "Job.csproj" -c Release -r linux-musl-x64 -o /app/publish --no-restore

FROM base AS final
COPY --from=publish /app/publish .
ENTRYPOINT ["/app/Job"]
