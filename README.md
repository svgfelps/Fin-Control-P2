# FinControl Firebase - Projeto Prático Parte 2

Projeto Flutter adaptado para Firebase Authentication, Cloud Firestore, API REST pública e Firebase Hosting.

## O que foi implementado

- RF001: Login com Firebase Authentication e recuperação de senha por e-mail.
- RF002: Cadastro com e-mail/senha e campos adicionais em `usuarios`: nome, telefone e cidade.
- RF003: Inserção no Firestore em duas coleções principais: `transactions` e `goals`, ambas com pelo menos cinco campos e `userId`.
- RF004: Atualização de transações e metas.
- RF005: Recuperação em tempo real com `StreamBuilder` e `ListView`.
- RF006: Tela exclusiva de pesquisa em transações, sem diferenciar maiúsculas/minúsculas e com opções de ordenação.
- RF007: Consumo de API pública de cotação USD-BRL.
- Firebase Hosting configurado em `firebase.json`.

## Antes de executar

1. Crie um projeto no Firebase.
2. Ative Authentication > Email/senha.
3. Crie o Firestore Database.
4. Rode:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Esse comando deve substituir `lib/firebase_options.dart` com as credenciais reais do seu Firebase.

## Executar

```bash
flutter pub get
flutter run -d chrome
```

## Publicar no Firebase Hosting

```bash
flutter build web
firebase login
firebase init hosting
firebase deploy
```

Na pergunta da pasta pública, use `build/web`.
