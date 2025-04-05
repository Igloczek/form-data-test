FROM oven/bun:canary AS base
RUN apt update && apt install -y unzip
RUN bun upgrade --canary

FROM base AS builder

WORKDIR /usr/src/app

COPY package.json bun.lock ./
RUN bun install

COPY . .
RUN bun run build

FROM base
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app .

ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=3000
ENTRYPOINT [ "bun", "./dist/server/entry.mjs" ]
