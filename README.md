# Markov phrases

Simple web app using rack to respond http requests and a Markov chain implementation in ruby to generate tweets by a given user. Markov learning is done using twitter api and stored in yml files.

### Getting started

- Install ruby 2.6.3
- Install [bundler](https://bundler.io/)
- Install [foreman](http://ddollar.github.io/foreman/)
- `bundle install`
- `foreman start`

You'll get the app up and running.

### Training Markov chains

Look at the `./bin/train` script. It uses the object `Phrases::Tasks::Training` to build a markov chain.

### Disclaimer

This is just for fun 🙈

