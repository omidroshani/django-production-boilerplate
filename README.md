# Django Production Boilerplate

Install nginx on the VM:
```
https://www.nginx.com/resources/wiki/start/topics/tutorials/install/
```

Install CertBot on the VM:
```
https://certbot.eff.org/instructions
```

Enable sites-enabled on nginx:
```
sudo ./nginx-enable.sh
```

Setting up doppler
```
doppler setup
```

Downloading env file from doppler
```
doppler secrets download --no-file --format env > .env
```

Rename docker-compose content
```
in docker-compose.yml change django-app to your project name
```

For development environment
```
docker compose --env-file ./.env.dev up -d --build
```

For production
```
docker compose --env-file ./.env.prod up -d --build
```

Deploy Application
```
sudo ./nginx-deploy.sh
```

