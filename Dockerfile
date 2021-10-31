FROM chromedp/headless-shell:74.0.3717.1 as builder
FROM ubuntu:20.04
RUN \
    apt-get update -y \
    && apt-get install -y libnspr4 libnss3 libexpat1 libfontconfig1 libuuid1 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
COPY --from=builder /headless-shell /headless-shell/
COPY --from=builder /headless-shell/swiftshader /headless-shell/swiftshade
EXPOSE 9222
ENV PATH /headless-shell:$PATH
ENTRYPOINT [ "/headless-shell/headless-shell", "--no-sandbox", "--remote-debugging-address=0.0.0.0", "--remote-debugging-port=9222" ]
