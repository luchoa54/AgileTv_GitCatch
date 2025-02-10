# 🦑 Desafio iOS - Agile Tv: Tela de Detalhes de um usuáiro no Github

Este projeto é parte do desafio técnico para a **Agile Tv**. O objetivo foi desenvolver a tela de **detalhes de um usuário no Github**, utilizando dados da API do **própio Github**. A implementação seguiu os requisitos fornecidos, priorizando organização, boas práticas e atenção aos detalhes.

---

## 📋 Índice

- [😁 Mensagem aos avaliadores](#-mensagem-aos-avaliadores)
- [📖 Sobre o Projeto](#-sobre-o-projeto)
- [🛠️ Tecnologias Utilizadas](#️-tecnologias-utilizadas)
- [🚀 Como Executar](#-como-executar)
- [🗂 Estrutura do Projeto](#-estrutura-do-projeto)
- [✉️ Contato](#️-contato)

---

## 😁 Mensagem aos avaliadores

Oi pessoal da AgileTv! 🎉

Foi um prazer participar deste desafio e aplicar meus conhecimentos no desenvolvimento desse teste técnico. Durante o projeto, busquei equilibrar fidelidade ao design, performance e boas práticas de desenvolvimento. Espero que gostem do resultado e que o código reflita minha dedicação e atenção aos detalhes.

Fiquem à vontade para explorar o projeto e entrar em contato para qualquer dúvida ou feedback. Obrigado pela oportunidade!

> **⚠️ Aviso Importante:**
> Caso enfrente problemas ao instalar as dependências devido a divergências de versões do CocoaPods, execute o comando `pod deintegrate` para limpar as configurações antigas antes de rodar `pod install`.


## 📖 Sobre o Projeto

O desafio consistiu em implementar a **tela de detalhes de um usuário** no estilo do layout enviado pela AgileTv, utilizando dados da API do **Github**. A tela apresenta informações como nome, avatar, nome de repositório e linguagem principal do repositório.

Os principais objetivos foram:
- Criar um layout baseado no design fornecido.
- Manter código limpo e organizado.
- Retornar os casos de erro corretamente ao usuário

---

## 🛠️ Tecnologias Utilizadas

- **Swift**: Linguagem principal de desenvolvimento.
- **UIKit**: Framework para criação de interfaces gráficas.
- **ViewCode**: Layouts foram implementados sem Storyboard para maior flexibilidade e performance.
- **RxSwift**: Utilizado para programação reativa e melhor gerenciamento de eventos assíncronos.

---

## 🚀 Como Executar

### Pré-requisitos:
- **Xcode 15** instalado no macOS.
- Gerenciador de dependências **CocoaPods**.

### Passos:
1. Clone este repositório:
   ```bash
   git clone https://github.com/luchoa54/AgileTv_GitCatch.git
2. Instale as dependências do projeto:
   ```bash
   cd local_do_projeto
   pod install
3. Abra o arquivo .xcworkspace no Xcode:
   ```bash
   open AgileTv_GitCatch.xcworkspace
4. Selecione um simulador e execute o projeto pressionando Cmd + R.

## 🗂 Estrutura do Projeto

```plaintext
AgileTv_GitCatch/
├── Source/
│   ├── Model/               # Modelos de dados
│   ├── View/                # Pasta principal para Views e ViewControllers
│   │   ├── Views/           # Componentes visuais reutilizáveis e layouts
│   │   └── ViewController/  # Lógica e controle das telas principais
│   ├── ViewModel/           # Lógica e manipulação de dados (MVVM)
│   └── Service/             # Serviço para consumo da API
├── Resources/               # Assets e configurações
├── Extensions/              # Extensões para reutilização de código
└── Pods/                    # Testes unitários
```

## ✉️ Contato

Fique à vontade para entrar em contato:

- **E-mail**: lucianou54@gmail.com<br>
- [![Luciano Uchoa](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/luciano-uchoa/)
