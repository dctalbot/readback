FROM ruby:2.5.0
RUN apt-get update -qq \
  && apt-get install -y \
  build-essential \
  postgresql-client \
  libpq-dev \
  nodejs

RUN mkdir /readback
WORKDIR /readback
COPY Gemfile* ./
RUN bundle install
COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
