# FINLEX API

### Getting Started

```
  git clone git@github.com:pcofilada/finlex.git
  cd finlex
  cp .env.sample .env
  // Before continuing be sure to change the content of .env file
  docker-compose up --build
```

### Other Commands

```
  docker-compose run --rm api bundle install // To install new ruby gem
  docker-compose run --rm api bundle exec rspec // To run the test
```

### API Documentation

- [Finlex API Documentation](https://documenter.getpostman.com/view/1624205/TzXtJfcQ)

### System Dependecies

- [Docker](https://www.docker.com/)
