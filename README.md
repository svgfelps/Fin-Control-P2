# FinControl - Aplicativo de Gestão Financeira

## Descrição
FinControl é um aplicativo desenvolvido em Flutter para gerenciamento financeiro pessoal. O aplicativo permite que o usuário registre e organize despesas, receitas, orçamentos e metas, com dados armazenados de forma segura no Firebase.  

O design é intuitivo, com feedback visual claro para todas as ações do usuário, garantindo uma experiência de uso eficiente.

---

## Funcionalidades

### Autenticação de Usuários (RF001)
- Login e logout com Firebase Authentication.
- Recuperação de senha via e-mail.
- Feedback claro para progresso e erros durante o login.

### Registro de Usuários (RF002)
- Cadastro de novos usuários com e-mail, senha e informações adicionais (nome, telefone).
- Validação de senha para garantir segurança.
- Armazenamento seguro de informações na coleção `usuarios` do Firestore.

### Inserção de Dados (RF003)
- Cadastro de **orçamentos**, **despesas**, **receitas** e **metas**.
- Cada coleção possui pelo menos cinco campos.
- Feedback imediato de sucesso ou falha na inserção.
- Dados vinculados ao usuário logado.

### Atualização de Dados (RF004)
- Edição de registros existentes em múltiplas coleções.
- Feedback claro em caso de falha.
- Alterações refletidas de forma consistente no Firestore.

### Recuperação de Dados (RF005)
- Exibição de informações em tempo real usando `StreamBuilder`.
- Uso de `ListView` e `GridView` para visualização organizada.
- Recuperação de dados em duas ou mais coleções.

### Pesquisa de Dados (RF006)
- Sistema de busca eficiente em coleções selecionadas.
- Resultados podem ser ordenados por data, relevância ou ordem alfabética.
- Pesquisa não diferencia maiúsculas e minúsculas.

### Consumo de API (RF007)
- Integração com APIs públicas para obter dados externos (ex.: cotações financeiras, clima ou outros serviços).

---

## Tecnologias Utilizadas
- Flutter SDK
- Firebase Authentication
- Firebase Firestore
- Widgets Flutter: `StreamBuilder`, `ListView`, `GridView`
- Gerenciamento de estado: Provider

---

## Estrutura do Projeto

/lib/screens/ → Telas do aplicativo
/lib/models/ → Modelos de dados (Budget, Transaction, Goal, User)
/lib/providers/ → Providers para gerenciamento de estado
/lib/services/ → Serviços de comunicação com Firebase/API
/lib/core/ → Rotas, constantes e tema do app


---

## Instalação
1. Clone o repositório:

git clone https://github.com/exemplo/fincontrol.git


2. Instale as dependências:

flutter pub get


3. Configure o Firebase:
- Adicione o `google-services.json` (Android) ou `firebase_options.dart` (iOS/Web) no projeto.

4. Execute o aplicativo:

flutter run


---

## Créditos
- Desenvolvido por: Carlos Chen e Felipe Savegnago
- RA: 2840482421030 e 2840482421034
