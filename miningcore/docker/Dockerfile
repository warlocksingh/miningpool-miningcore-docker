FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    cmake \
    libboost-all-dev \
    libsodium-dev \
    libssl-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Clone and build MiningCore
RUN git clone https://github.com/xiaolin1579/miningcore.git .
WORKDIR /app/src/Miningcore

# Build native libraries first
RUN mkdir -p bin/Release/net6.0/
RUN sh build-libs-linux.sh bin/Release/net6.0/

# Build .NET project
RUN dotnet restore
RUN dotnet publish -c Release -o /app/out

# Build WebUI
WORKDIR /app
RUN git clone https://github.com/btclinux/Miningcore.WebUI.git webui
WORKDIR /app/webui
RUN apt-get update && apt-get install -y nodejs npm
RUN npm install
RUN npm run build

# Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app

# Install runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libsnappy-dev \
    libc6-dev \
    libgdiplus \
    libboost-atomic1.74.0 \
    libboost-chrono1.74.0 \
    libboost-date-time1.74.0 \
    libboost-filesystem1.74.0 \
    libboost-program-options1.74.0 \
    libboost-system1.74.0 \
    libboost-thread1.74.0 \
    libsodium23 \
    libssl1.1 \
    && rm -rf /var/lib/apt/lists/*

# Copy build outputs
COPY --from=build-env /app/out .
COPY --from=build-env /app/webui/dist ./wwwroot

# Create log directory
RUN mkdir -p /var/log/miningcore
RUN chmod 777 /var/log/miningcore

# Expose ports
EXPOSE 4000 4001 4002 4003 80

# Start MiningCore
ENTRYPOINT ["dotnet", "Miningcore.dll"]
