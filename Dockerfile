FROM ruby:2.5.5

RUN apt-get update -qq && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev


# enviroments
ENV DB_HOST db_ltr
ENV DB_PASSWORD postgres
ENV DB_USER ltr
ENV APP_NAME LifeToRemind
ENV APP_HOME /$APP_NAME

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install


ADD . $APP_HOME
RUN rm -f tmp/pids/server.pid