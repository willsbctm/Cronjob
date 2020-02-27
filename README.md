# Cronjob

Exemplo de uso de cronjob:

  - Template
  - Deploy com helm

Consiste em basicamente uma aplicação dotnet core que apenas escreve:
```
Console.WriteLine($"Rodei às {DateTime.Now}");
```
O Job está configurado para rodar de um em um minuto.

### Instalação

Build da imagem:
Ir até a raiz do projeto e rodar:
```     
docker build -t cronjob:stable1 -f Job/Dockerfile Job/
```

##### Via kubectl

```
kubectl run meu-cronjob --schedule="*/1 * * * *" --restart=OnFailure --image=cronjob:stable1
```

##### Via helm

```
helm install --debug nome-da-release chart-cronjob/
```

##### Script
Realiza o build da imagem e instala/atualiza o job via helm utilizando os parâmetros do arquivo values.yaml

```
./install.sh
```

Você pode validar a instalação através do comando:
```
kubectl get cronjob
```

### Template

- failedJobsHistoryLimit: Quantidade de pods que falharam que serão mantidos
  - Para visualizar: ```kubectl get pods```
- successfulJobsHistoryLimit: Quantidade de pods que rodaram com sucesso que serão mantidos
  - Para visualizar: ```kubectl get pods```
- startingDeadlineSeconds: Deadline em segundos para rodar novamente um job que não rodou por alguma razão
- concurrencyPolicy: Especifica como deve ser a concorrência dos jobs: Allow (padrão), Forbid e Replace. 
- suspend: Se verdadeiro, suspende todas as próximas execuções do job. Padrão falso.
- schedule: Recorrência de execução no formato Cron

### Observações

 - Timezone que o cronjob irá considerar é a mesma do kube-controller-manager
 - Existe um máximo de 52 caracteres no nome do job

### Documentação

- https://kubernetes.io/docs/tasks/job/
- https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/
