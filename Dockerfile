FROM dart:stable as BUILDER
COPY . /app
WORKDIR /app
RUN mkdir build
RUN dart compile exe ./bin/telegram_wol.dart -o ./build/app

FROM debian:buster-slim
COPY --from=builder /app/build /bin

CMD ["app"]