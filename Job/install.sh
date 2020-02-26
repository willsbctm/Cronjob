release=cronjob

echo Build docker image
docker build -t cronjob:stable1 .

 acao='install'
if [ "$(helm list --filter=$release -q)" == $release ]; then
  acao='upgrade'
fi

echo $acao helm 
helm $acao --debug $release chart-cronjob/