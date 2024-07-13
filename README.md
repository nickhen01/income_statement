# Income Statement

## Prerequisites

- Ruby ≥ 3.3.0
- Rails 7.1

## Local development

### Rails dependencies

  ```shell
bundle install
```

Setup db from schema:

```shell
bundle exec rake db:setup
```

### Start local server

```shell
bin/dev
```

The app is accessible on [http://localhost:5000](http://localhost:5000)

### Management of assets

- CSS is built with [tailwindcss-rails](https://github.com/rails/tailwindcss-rails).
- Javascript is managed by [Importmap-rails](https://github.com/rails/importmap-rails) and the [Stimulus](https://github.com/stimulusjs/stimulus) framework.

### Run tests

```shell
bundle exec rspec
```

## Thoughts and Improvements

The app has been developed so that all requirements specified in the description are covered and with the aim of respecting the time constraint (2hrs). Therefore some optimisations have been left aside.

Improvements:
1. Use nested form in statement

    Currently there are separate forms to add incomes and expenses one by one. It would be beneficial to modify the statement form into a nested form where income and expense can be added directly. Benefits: 
   
    
- better UX as the user would be able to keep an overview of the statement while building it.
- remove incomes and expenses controllers/views in the backend. I am conscious these are duplicates at the moment.

2. Store in db statement #disposable income, #ratio and #rating in order to:


- decrease computation/memory load on statements index and show page
- remove N+1 on statements#index
- allow for further analysis by backoffice without further computation
- can be achieved via a single callback on statement when nested form is implemented 
