FROM rockylinux:9

RUN dnf install -y procps-ng

WORKDIR /app

COPY scripts/disk.sh /app/disk.sh

RUN chmod +x /app/disk.sh

ENTRYPOINT ["/app/disk.sh"]
CMD ["--all"]
