# Usar imagem oficial do Ruby
FROM ruby:3.3.5

# Instalar dependências
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client yarn

# Definir o diretório de trabalho no container
WORKDIR /traceguard

# Copiar Gemfile e Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instalar as gems
RUN bundle install

# Copiar o código do projeto para dentro do container
COPY . .

# Expor a porta 3000
EXPOSE 3000

# Comando padrão para rodar o servidor
CMD ["rails", "server", "-b", "0.0.0.0"]