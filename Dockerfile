FROM oven/bun:1.2.8

WORKDIR /app

COPY . .

ENTRYPOINT ["bun", "index.ts"]
