# 🏨 S&M Hotel — Aplicativo Mobile

## 📌 Sobre o projeto

O **S&M Hotel** é um aplicativo mobile desenvolvido em Flutter como atividade acadêmica da disciplina de Aplicações Mobile. O objetivo é permitir que o usuário consulte destinos turísticos, planeje sua hospedagem e calcule o valor estimado da viagem de acordo com a quantidade de diárias e acompanhantes.

O aplicativo também possui telas de login, cadastro de usuários e checkout, oferecendo um fluxo de navegação completo para a simulação de uma reserva.

## ✨ Funcionalidades

- **Login:** autenticação de usuários utilizando uma API local.
- **Cadastro de usuários:** registro de novos usuários por meio de requisição HTTP.
- **Destinos turísticos:** exibição de 10 destinos com imagens e valores de hospedagem.
- **Planejamento da viagem:** adição da quantidade de diárias e acompanhantes.
- **Cálculo do orçamento:** cálculo do valor estimado com base nas diárias e nos acompanhantes.
- **Formas de pagamento:** seleção entre PIX e cartão.
- **Desconto no PIX:** aplicação de 10% de desconto sobre o valor calculado.
- **Checkout:** visualização do resumo da viagem, dos valores e da forma de pagamento selecionada.
- **Limpeza dos dados:** opção para limpar os valores calculados e reiniciar o planejamento.

## 🛠️ Tecnologias utilizadas

- **Flutter** — desenvolvimento da interface mobile.
- **Dart** — linguagem de programação.
- **Provider** — gerenciamento de estado da aplicação.
- **HTTP** — comunicação com a API.
- **JSON Server** — simulação de uma API REST para autenticação e cadastro.
- **Git e GitHub** — versionamento e hospedagem do código-fonte.

## 📱 Destinos disponíveis

O aplicativo apresenta 10 opções de destinos turísticos:

1. Angra dos Reis
2. Jericoacoara
3. Arraial do Cabo
4. Florianópolis

Cada destino possui uma imagem e valores definidos para o cálculo da viagem.

## 🧮 Cálculo da viagem

O orçamento considera os valores de hospedagem por diária e os valores por acompanhante.

**Cálculo do subtotal:**

`Subtotal = (Quantidade de diárias × Valor da diária) + (Quantidade de acompanhantes × Valor por pessoa)`

**Desconto para pagamento via PIX:**

`Desconto = Subtotal × 10%`

**Total com PIX:**

`Total final = Subtotal − Desconto`

O desconto é aplicado quando o usuário seleciona PIX como forma de pagamento.

## ⚙️ Pré-requisitos

Para executar o projeto, é necessário ter instalado:

- Flutter SDK.
- Dart SDK, incluído na instalação do Flutter.
- Android Studio ou outro ambiente compatível com Flutter.
- Um emulador Android ou dispositivo compatível.
- Node.js e npm, para executar o JSON Server.

## 🚀 Como executar o projeto

### 1. Clonar o repositório

```bash
git clone https://github.com/MiguelSantos1910/sm_hotel.git
cd sm_hotel
```

### 2. Instalar as dependências do Flutter

```bash
flutter pub get
```

### 3. Iniciar o JSON Server

Na pasta em que estiver o arquivo `db.json`, execute:

```bash
npx json-server --watch db.json --port 3000
```

O banco de dados deve conter as coleções necessárias para as operações de login e cadastro, conforme a implementação da API.

### 4. Verificar a configuração da API

No emulador Android, o endereço `10.0.2.2` permite acessar a porta `3000` da máquina hospedeira. Confira se a URL configurada no serviço da aplicação corresponde ao ambiente em que o JSON Server está sendo executado.

### 5. Executar o aplicativo

Em outro terminal, na raiz do projeto, execute:

```bash
flutter run
```

## 📂 Estrutura do projeto

```text
sm_hotel/
├── android/
├── imagens/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   ├── destino.dart
│   │   ├── destinos_lista.dart
│   │   └── viagem_provider.dart
│   ├── pages/
│   │   ├── cadastro_page.dart
│   │   ├── checkout_page.dart
│   │   ├── home_page.dart
│   │   └── login_page.dart
│   ├── services/
│   │   └── app_services.dart
│   └── widgets/
│       └── destino_card.dart
├── test/
├── web/
├── pubspec.yaml
└── README.md
```

## 💳 Observação sobre o pagamento

A tela de checkout permite selecionar a forma de pagamento e visualizar os valores calculados. A confirmação é uma simulação acadêmica: o aplicativo não realiza cobranças reais nem integra um gateway de pagamentos.

## 🎓 Finalidade acadêmica

Este projeto foi desenvolvido com finalidade educacional, aplicando conceitos de desenvolvimento mobile com Flutter, navegação entre telas, gerenciamento de estado, consumo de API REST, operações HTTP e cálculo de valores a partir das escolhas do usuário.

## 👨‍💻 Autor

**Miguel Santos**

GitHub: [@MiguelSantos1910](https://github.com/MiguelSantos1910)

---

Desenvolvido como atividade acadêmica da disciplina de Aplicações Mobile.
