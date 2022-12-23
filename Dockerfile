FROM dart:stable as BUILDER
COPY . /app
WORKDIR /app
RUN mkdir build
RUN dart compile exe ./bin/telegram_wol.dart -o ./build/app

FROM debian:buster-slim

LABEL maintainer=binozoworks
LABEL org.opencontainers.image.source="https://github.com/Binozo/Telegram-WOL"
LABEL org.opencontainers.image.description="Wake up your devices from anywhere"

COPY --from=builder /app/build /bin

CMD ["app"]