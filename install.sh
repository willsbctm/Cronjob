echo Build docker image
docker build -t cronjob:stable -f Job/Dockerfile Job/

echo Instalando
helm upgrade --install --debug --atomic --timeout 60s exemplocronjob exemplocronjob/