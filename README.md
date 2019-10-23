# LifeToRemind

[![Build Status](https://travis-ci.org/eduqg/LifeToRemind.svg?branch=master)](https://travis-ci.org/eduqg/LifeToRemind)

**LifeToRemind** is a website for career-oriented Personal Strategic Planning.

Enjoy **Hacktoberfest** to do four Pull Requests and win your event t-shirt! :v::tada::raised_hands:

## Deploys

[LifetoRemind stable](http://lifetoremindhub.herokuapp.com/)

[LifeToRemind master](http://lifetoremindhubdevel.herokuapp.com/)

## Tools and Environment

* Ubuntu 16.04.5 LTS 64-bit
* RVM 1.29.8
* Ruby 2.5.5p157
* Rails 5.2.3
* PostgreSQL 9.5.17

## Installation and Execution

In one terminal, clone the repository.

```console
git clone https://github.com/eduqg/LifeToRemind
```

Open the project folder.
```console
cd LifeToRemind
```

[Install Ruby Version Manager (RVM)](https://github.com/rvm/ubuntu_rvm) for application configuration.

Run the commands to set the correct version for the project.

```console
rvm install 2.5.5
gem install rails -v 5.2.3
bundle install
```

[Install Postgres](https://www.digitalocean.com/community/tutorials/how-to-setup-ruby-on-rails-with-postgres) to the application database.

Make the necessary migrations.

```console
rake db:create
rake db:migrate
```

Run the project.

```console
rails s
```

Open the browser at [localhost:3000](http://localhost:3000)

To run the application tests.
```console
rspec
```

## Execution with **DOCKER**

### Install Docker

- [Docker CE](https://docs.docker.com/v17.09/engine/installation/linux/docker-ce/ubuntu/)

- [Docker Compose](https://docs.docker.com/compose/install/)

### Define variables

Define on: ./env_file.env

```env
DB_USER=postgres
## The same name defined on docker-compose.yml
DB_HOST=db_ltr
## If you change default port 5432 you need to change in database.yml as well as execute a "docker-compose --build".
DB_PORT=5432
RAILS_MAX_THREADS=5
RAILS_ENV=development
```

### Usefull Commands

```bash
## build docker-compose.yml
docker-compose build

## run deatached
docker-compose up -d

## list containers
docker ps -a

## join in the bash container
docker exec -it <container> bash

## stop container
docker stop <container>

## remove container
docker rm -f <container>

## stop all containers from docker-compose
docker-compose down

## inspect container
docker inspect <container>

## show container logs
docker logs <container>

## follow container logs
docker logs -f <container>
```

## Execution Tests with **DOCKER**

### Change enviroments

Change de value of key RAILS_ENV to test in ./env_file.env

```env
RAILS_ENV=test
```

### Run compose

```bash
docker-compose up -d
```

### List containers and get "web" containerid

```bash
docker ps -a
```

### Run tests

```bash
docker exec -it <container> bash -c "bundle exec rspec"
```

## Become a Life to Remind Developer

To contribute to the project check the open issues. If what you want to improve or the problem you found is not already listed, create a new issue with a description of the problem. To contribute to the project send a Pull Request to the repository, it will be evaluated later.

Step 1 - Make a copy of the repository by clicking on the Fork tab.

<img src="./app/assets/images/readme/fork.png" alt="fork"/>

Step 2 - Download the Life to Remind project created in your account.
```console
git clone https://github.com/SEU_USUARIO/LifeToRemind.git
```

Step 3 - Make changes to the code and upload it to your repository.

```console
git add new_file.txt
```
```console
git commit -m "Adding new file"
```
```console
git push origin master
```

Step 4 - Enter your repository with the changes made and click to make the Pull Request.

<img src="./app/assets/images/readme/pull.png" alt="pull"/>

Step 5 - Wait for your Pull Request to be approved and **congratulations on becoming a contributor to the Life to Remind Project!**

## Application Images

<table>
  <tr class="row">
    <th class="column"">
      <img src="./app/assets/images/home.png" alt="mainpage" style="width:420px;height:285px;"/>
    </th>
    <th class="column">
      <img src="./app/assets/images/analiseambientalltr.png" alt="swot" style="width:420px;height:285px;"/>
    </th>
  </tr>

  <tr class="row">
    <th class="column">
      <img src="./app/assets/images/statusltr.png" alt="status" style="width:420px;height:285px;"/>
    </th>
    <th class="column">
      <img src="./app/assets/images/meuplanejamentoltr.png" alt="plan" style="width:420px;height:285px;"/>
    </th>
  </tr>
</table>
