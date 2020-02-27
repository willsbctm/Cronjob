release=cronjob

echo Build docker image
docker build -t cronjob:stable1 -f Job/Dockerfile Job/

 acao='install'
if [ "$(helm list --filter=$release -q)" == $release ]; then
  acao='upgrade'
fi

echo $acao helm 
helm $acao --debug $release chart-cronjob/