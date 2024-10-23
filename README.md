**Bem-vindo ao wiki do repositório!**

Esse repositório ajuda no salvamento do estado do terraform e configurações de conta para os usuários colaborarem entre si com o uso do terraform.

1 - Pre-requisito 
* A conta da organização já tem que estar criada na AWS.

Como a primeira conta da organização criada via GUI esse repositório serve para criar o bucket onde iremos salvar esses dados.
Porem o lab já se encontra criado, então seguiremos com a parametrizado e configuração do sistema operacional
Mas primeiro vamos fazer alguns ajustes:

2 - Uso do repositório:

<img width="95" alt="image" src="https://github.com/user-attachments/assets/fcf15663-4841-4995-9c98-f429a918ea25">
* Configuração do git:
Faça o download do git no endereço "Git":https://git-scm.com/downloads. Instale o pacote conforme a versão do seu sistema operacional

<img width="167" alt="image" src="https://github.com/user-attachments/assets/ea7960c3-4057-4f90-9f63-7a8eafc5c0e9">
* Utilize qualquer editor de código como sublime, Atom ou VsCode. Neste exemplo vamos utilizar o VsCode:
Faça o download do VsCode no endereço "VsCode":https://code.visualstudio.com/download. Instale o pacote conforme a versão do seu sistema operacional

<img width="72" alt="image" src="https://github.com/user-attachments/assets/c1942320-3162-4210-9eba-0181ff6f04b0">
* Instalação do AWS CLI:
Faça o download do AWS CLI no endereço "AWS CLI":https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html. Instale o pacote conforme a versão do seu sistema operacional.

<img width="35" alt="image" src="https://github.com/user-attachments/assets/bd1931ac-58b2-4582-b493-fcb28bee08c6">
* Instalação do terraform:
Faça o download do terraform no endereço "Terraform":https://developer.hashicorp.com/terraform/install. Instale o pacote conforme a versão do seu sistema operacional.

3 - Configuração do VsCode:

* Abra o Vscode e efetue login VsCode para clone e versionamento do código.
<img width="333" alt="image" src="https://github.com/user-attachments/assets/fce31344-3924-4d54-b046-335313ad1c94">

4 - Clone do repositório via git.

* Para clonar o repositório, crie uma pasta no seu SO e execute o comando no terminal a partir da pasta que você criou.
Digite: <pre><code>git clone https://github.com/gudesantana/llabs_hml_account.git</code></pre>

* Execute o comando no seu terminal.
<pre><code>git pull</code></pre>
Nesse momento o repositório deverá ser baixado para trabalho no seu repositório local

Nosso projeto já se encontra criado, porem mesmo assim segue ajuda para externá-lo a outros projetos.

Navegue entre os workspaces digitando o comando;
<pre><code>terraform workspace list</code></pre>

Escolha o workspace criado conforme os resultados. Utilize o comando abaixo para selecionar o workspace desejado.
<pre><code>terraform workspace SELECT <workspace></code></pre>

**Para os passos abaixo, somente se for criar novos ambientes.**

5 - Configurando o terraform, criando workspaces

No repositório terraform, tera um arquivo chamado <pre><code>version.tf</code></pre>. Edite o arquivo e comente as seguintes linhas:

<pre><code>  
  # backend "s3" {
  #   bucket         = "s3-aws-llabs-trf-state-prd"
  #   key            = "s3backend/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "dyndb-aws-llabs-trf-state-prd"
  #   encrypt        = true
  #   profile        = "default"
  # }
</code></pre>

Esse tópico salva o estado do terrafom num repositório no S3 na AWS. Mas ainda não configuramos ele ainda, então iremos salvar o estado do terraform e criação do workspace local e posterior salvamento dos dados. Segue:

* Execute o comando abaixo:
 <pre><code>Terraform init</code></pre>

Repare que a estrutura e dependências necessárias serão configuradas localmente. Após a criação dos recursos iremos redirecionar o arquivo terraform.state.

* Edite o arquivo gitignore e comente a seguinte linha:
<pre><code># *.tfvars</code></pre>

* Edite o arquivo <pre><code>s3backend-llabs-prd.tfvars</code></pre>
Insira os valores que deseja ou deixe o mesmo como esta. Em nosso lab, utilizaremos esses mesmos valores.

<pre><code>
project        = "llabs" # Nome da conta AWS
aws_region     = "us-east-1"
aws_profile    = "default"
aws_account_id = "816069124394"

# S3
s3_bucket_names       = ["s3-aws-llabs-trf-state-prd"]
s3_bucket_name        = "s3-aws-llabs-trf-state-prd"
s3_versioning         = "Enabled"
enable_lifecycle_rule = false

# DynamoDB
db_table_name = "dyndb-aws-llabs-trf-state-prd"
billing_mode  = "PAY_PER_REQUEST"
hash_key      = "LockID"
attr_name     = "LockID"
attr_type     = "S"
</code></pre>

* Crie o workspace de trabalho no terraform. Alguns projetos de terraform no necessitam de workspaces, porem devido sua utilidade iremos criar workspaces na maioria deles. 

* Criar o workspace com o mesmo nome do arquivo de variáveis tfvars. Para cada ambiente ou projeto será necessário um novo arquivo tfvars e um workspace de trabalho, nesse caso fica da seguinte maneira nosso projeto.
Segue o comando: 
<pre><code>terraform workspace new s3backend-llabs-prd  </code></pre>

Após a criação do Workspace ele já redireciona para o workspace criado. Mesmo assim valide se realmente se encontra nesse workspace. Essa etapa é muito importante para que você não crie projetos em workspaces errados, podendo corromper sua infraestrutura.

* Digite o comando para avaliar o workspace criado:
<pre><code>terraform workspace list</code></pre>
_Obs.: O workspace default pode ser utilizado, mas por melhores praticas não iremos utilizar nesse momento._

* Caso necessario criar novas infraestrutura onde seja util utilizar o mesmo codigo exemplo para outros projetos em outras regioes ou contas, o codigo do repositorio podera ser utilizado em novo workspace.
  Nesse exemplo criamos o workspace s3backend-llabs-prd. Porem poderia ser configurado o mesmo projeto em contas e regioes separadas apenas criando um novo arquivo .tfvars editando as variaveis do arquivo.
Exemplo:
  s3backend-llabs-prd.tfvars
  s3backend-llabs-hml.tfvars
  s3backend-llabs-prd-us-east-2.tfvars
  etc...

6 - Criação da infraestrutura AWS com o terraform

* Criação da infraestrutura e recursos s3 e dynamodb. O dynamo db nesse projeto tem a função de não permitir que outro usuário altere o código do repositório ao mesmo tempo. Então nesse caso, o dynamodb bloqueia o acesso do segundo usuário.

* Antes de criar a infraestrutura valide primeiramente quais recursos serão criados.
Preste bem atenção se no plano existe algum argumento de "change" ou "destroy". 
Se isso ocorrer, valide se esta no workspace correto.
Para criação de novos ambientes, esses argumentos acima não poderão ser mostrados!

Exemplo:
<img width="446" alt="image" src="https://github.com/user-attachments/assets/676655b6-b672-41ca-a34e-685ada9f3387">

Para novas estruturas que serão modificadas basta avaliar bem oque esta alterando e se o planejamento informado está correto.

_Obs: Nunca digite o comando terraform com o argumento apply antes de executar o plan para não arriscar implementar uma alteração errônea por acidente. Sempre avalie com terraform plan primeiramente_.

Para avaliar a infraestrutura que será criada, execute o seguinte código:
<pre><code>terraform plan -var-file="s3backend-llabs-prd"</code></pre>

Após validação da infra a ser criada, execute o comando:
<pre><code>terraform apply -var-file="s3backend-llabs-prd"</code></pre>

* Após criação da infraestrutura, valide na AWS se os recursos foram criados conforme esperado.
Nesse repositório, foi criado um Bucket S3 com os nomes gerados no arquivo .tfvars e um banco DynamoDB.

7 - Redirecionando o terraform.state para o bucket criado
Agora iremos redirecionar todos os projetos e repositórios para salvar o estado do terraform nesse bucket. 

* Comente novamente o arquivo <pre><code>version.tf</code></pre>. Edite o arquivo e comente as seguintes linhas deixando exatamente conforme o exemplo abaixo:

<pre><code>  
  backend "s3" {
    bucket         = "s3-aws-llabs-trf-state-prd"
    key            = "s3backend/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dyndb-aws-llabs-trf-state-prd"
    encrypt        = true
    profile        = "default"
  }
</code></pre>

Nesse exemplo o bucket usado será o s3-aws-llabs-trf-state-prd.
O caminho a ser salvo o estado será uma pasta no buket s3backend/terraform.tfstate
_Obs: Todo ambiente criado em workspace, cria uma pasta no bucket chamada "env:/". Os Projetos que não foram criados utilizando workspaces (Default) será criado na raiz do bucket._
<img width="223" alt="image" src="https://github.com/user-attachments/assets/ee203375-bb89-4e81-935e-59693c6a552e">


* Execute novamente o comando:
<pre><code>Terraform init</code></pre>

Você terá um resultado com as seguintes informações informando que o estado do terraform foi migrado para o bucket S3.
<img width="451" alt="image" src="https://github.com/user-attachments/assets/7a5963b2-08fe-4655-b01c-8ae00abb841d">

Após digitar "Yes". Você tera o seguinte retorno informando que o estado do seu terraform foi migrado.
<img width="451" alt="image" src="https://github.com/user-attachments/assets/da3298fa-65af-4b65-b858-49799bfec4a6">
_Obs: Esta imagem foi tirada de outro repositório de exemplo, porem segue as mesmas regras!_

8 - Fim

Se você chegou até aqui, todos os passos foram configurados e recursos implementados corretamente.
Vamos para o próximo repositório para criação da conta HML e posteriormente a parametrização das contas de PRD e HML.

Abraço. Be Good! :)
