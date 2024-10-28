# Recomendador de Filmes, Séries e Musicas - Projeto em Haskell

## Identificação
**Nome:** Guilherme Fereira da Silva
**Curso:** Ciência da Computação

## Objetivo
O presente trabalho tem como objetivo construir um servidor Web em Haskell que recomenda filmes, séries ou músicas, de acordo com a vontade do usuário. A aplicação exibe uma sugestão aleatória de cada categoria, com o intuito de praticar habilidades de programação funcional, manipulação de arquivos em haskell e criação de uma interface web minimalista com o framework **Scotty**

## Desenvolvimento
O trabalho em si foi desenvolvido nas seguintes etapas
### Estrutura do Projeto
1. **Configuração do Servidor Web:** Utilizando o framework recomendado pela professora (Scotty), o servidor foi configurado para servir paginas HTML e rotas para cada tipo de recomendação (filme, música e série). Para essa construção, demandou um estudo da ferramenta através da consulta de sites e comparação de códigos fornecidos pela professora.

2. **Carregamentos dos Arquivos:** a fim de modularizar melhor o trabalho e mante-lo legivel, a base de dados de filmes, series e musicas foi montada em 3 aquivos CSV separados e armazenados em uma estrutura de diretórios apropriada (`/data`). Além disso, foram criadas funções para ler esses arquivos e selecionar uma entrada aleatória. Sendo elas `LoadFile` e `RandomFile`, que carrega um arquivo para uma variavel e aleatoriza um dado para exibição, respectivamente. 

3. **Templates HTML:** Foram criados templates HTML que iriam conter o conteúdo da página principal e das recomendações, a fim de trazer uma interface mais amigável para a aplicação. Além de permitir a compreensão de como utilizar o HTML juntamente com o Haskell. 

4. **Folhas para estiização:** Um arquivo CSS simples foi criado e adicionado para estilizar o layout, centralizando os conteúdos e ajustando a aparência dos botões e textos.

Além disso, durante o desenvolvimento do codigo, tiveram as dificuldades a seguir
### Principais dificuldades 
1.  **Concatenação de textos e conversão `String`-`Text`:** Ao tentar usar o operador `<>` para concatenar Strings com Text, surgiram erros pelos tipos serem incompatíveis
```hs
text $ "Filme Recomendado: " <> movie
```
Assim, a conversão de texto se dá pelo uso da bibliotexa `Data.Text.Lazy`, substituindo `movie` por `TL.pack movie`

2. **Uso do MiddleWare para Arquivos Estáticos:** No inicio não era bem claro o uso do MiddleWare dentro do código, mas com a ajuda de IAs generativas e pesquisas no [Hoogle](https://hoogle.haskell.org/) 

3. **Mistura de Ferramentas diferentes**: Durante a execução do projeto, viu-se a necessidade de uma interface para o usuário, Logo, em determinado ponto do projeto, o código em Haskell estava uma bagunça por misturar HTML nas chamadas de rotas. Assim, a modularização em arquivos que armazenariam os templates HTML foram a solução ideal para manter o código mais legível.

## Resultado Final

![example](video/animation.gif)

## Referências e Créditos

**Fontes**
- [Leitura e escrita de dados em Haskell](https://kuniga.wordpress.com/2012/06/17/leitura-e-escrita-de-dados-em-haskell/)

- [Programação Fuincional com a Linguagem Haskell](https://www.facom.ufu.br/~madriana/PF/tutorial_avancado.pdf)

- [Scotty Haskell web framework inspired by Ruby's Sinatra, using WAI and Warp](https://hackage.haskell.org/package/scotty)

- [Data.Lazy.Text](https://hackage.haskell.org/package/text-2.1.2/docs/Data-Text-Lazy.html)

- IAs generativas como ChatGPT e Gemini para dúvidas mais pontuais e sintaxe
