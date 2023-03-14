FROM ruby:2.6.9

RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*

RUN npm install --global yarn

RUN apt-get update && \
    apt-get install -y --no-install-recommends libpq-dev && \
    rm -rf /var/lib/apt/lists/*
    
RUN mkdir /app
WORKDIR /app

COPY . /app/

ENV BUNDLE_PATH /gems
RUN bundle install

ENTRYPOINT ["bin/rails"]
CMD ["s","-b","0.0.0.0"]

EXPOSE 3000
