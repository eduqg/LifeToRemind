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
