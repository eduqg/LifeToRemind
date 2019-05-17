# LifeToRemind

Projeto LifeToRemind.

## Ferramentas e Ambiente

* Ubuntu 16.04.5 LTS 64-bit
* RVM 1.29.4
* Ruby 2.5.1p57
* Rails 5.2.1
* MySQL 5.7.23-0ubuntu0.16.04.1

## Instalação e Execução

Em um terminal, clone o repositório.

```console
$ git clone https://github.com/eduqg/ltr
```

Abra a pasta do projeto.
```console
$ cd ltr
```

[Instale o Ruby Version Manager (RVM)](https://github.com/rvm/ubuntu_rvm) para a configuração da aplicação.

Execute os comandos para configurar a versão correta para o projeto.

```console
$ rvm install 2.5
$ gem install rails -v 5.2.0
$ bundle install
```

[Instale o Postgres](https://www.digitalocean.com/community/tutorials/how-to-setup-ruby-on-rails-with-postgres) para o banco de dados da aplicação.

Faça as migrações necessárias.

```console
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

Execute o projeto.

```console
$ rails s
```

Abra o navegador em [localhost:3000](http://localhost:3000)

Para executar os testes da aplicação.
```console
$ rake spec
```
