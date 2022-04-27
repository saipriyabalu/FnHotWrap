FROM alpine:latest
FROM php:7.4-cli

# Install hotwrap binary in your container
COPY --from=fnproject/hotwrap:latest  /hotwrap /hotwrap


COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
CMD [ "php", "./sample.php" ]

ENTRYPOINT ["/hotwrap"]

